---
name: fastapi-async-boundaries
description: FastAPI async boundaries — whether a handler is `async def` or `def`, and where a blocking call crosses into a thread. Use when writing or reviewing a route handler, choosing a driver or client library, or diagnosing latency that appears only under concurrency.
---

# FastAPI async boundaries

FastAPI is always async. uvicorn runs an event loop, and the `def` keyword only
decides where a handler runs:

- `async def` runs on the loop's single thread, interleaved with every other
  request at each `await`.
- `def` is offloaded by Starlette to a shared AnyIO threadpool of 40 slots.

Every rule below follows from those two sentences. Account for each I/O call on
a handler's path. Where those clients and engines are constructed is a separate
question, answered by the `fastapi-dependency-injection` skill.

## The service stance

One **stance** per service, because the driver stack is shared: picking asyncpg
or psycopg2 settles nearly every handler.

In an existing project the stance already sits in the environment, so read it
rather than decide it — `pyproject.toml`, the engine factory, the handlers
already there — and conform to what you find. When the stance looks wrong for
the workload, say so and leave the change to the developer: a driver swap is an
architecture decision, not a side effect of adding a handler.

In a new project the spec usually settles the stance; ask the developer only
when the workload shape stays unclear. Judge by wait duration against
downstream ceiling, rather than by whether the work is I/O:

| | DB-bound CRUD | upstream API, SSE, WebSocket |
|---|---|---|
| wait per call | 1–10 ms | 100–500 ms |
| ceiling under 40 threads | yes, a ~20 connection pool | none |
| stance | sync is sound | async |

A sync stance is a real choice: async lifts a threadpool ceiling that a
connection pool was already holding well below 40.

## Per-handler boundaries

Under a settled stance each handler asks one question: does its path hold a long
blocking call? Short synchronous work — validation, dict assembly, json
parsing — runs on the loop and needs nothing.

A blocking segment inside an `async def` handler crosses into a thread.

```python
@app.get("/report")
async def report(svc: RatesDep):
    rows = await run_in_threadpool(legacy_sync_query, 42)
    return await svc.enrich(rows)
```

A handler that blocks end to end is simply `def`, and Starlette takes it from
there. CPU-bound work belongs in a process pool or a task queue, since a thread
still holds the GIL.

Raise the threadpool when sync handlers carry the bulk of the traffic.

```python
anyio.to_thread.current_default_thread_limiter().total_tokens = 100
```

## Fan-out

Concurrency inside one handler is what an async stance buys. `TaskGroup` cancels
its siblings when one task raises, leaving no orphans.

```python
async with asyncio.TaskGroup() as tg:
    rates = tg.create_task(svc.fetch_rates())
    news = tg.create_task(svc.fetch_news())
```

`TaskGroup` re-raises whatever its tasks raised wrapped in an `ExceptionGroup`,
so a plain `except UpstreamError` and an `@app.exception_handler(UpstreamError)`
both stop matching and the response becomes a 500. Unwrap at the boundary that
owns the contract.

```python
try:
    async with asyncio.TaskGroup() as tg:
        ...
except* UpstreamError as group:
    raise group.exceptions[0] from None
```

An `asyncio.Semaphore` caps how much of that reaches one upstream. Fan out where
real parallelism exists; a single upstream call stays a plain `await`.

## Gotchas

- Async SQLAlchemy wants eager loading written out (`selectinload`) or
  `await obj.awaitable_attrs.items`, and one `AsyncSession` per task, since a
  session shared across a `TaskGroup` corrupts.
- `anyio.from_thread.run` sends a coroutine back to the app's loop, keeping the
  lifespan's clients and pools usable; `asyncio.run` opens a fresh loop, and
  anything bound to the old one raises `attached to a different loop`.
- `BackgroundTasks` follows the same split: a `def` task goes to the threadpool,
  an `async def` task to the loop.
- `StreamingResponse` iterates a sync generator through the threadpool, so an
  async handler yields an async generator.
- `PYTHONASYNCIODEBUG=1` prints every callback over 100 ms, naming the blocking
  call that sync-looking latency hides.
