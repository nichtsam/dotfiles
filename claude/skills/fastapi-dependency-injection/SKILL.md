---
name: fastapi-dependency-injection
description: FastAPI dependency wiring — where a dependency is constructed, so lifecycle-owning resources are built once and request state stays per-request. Use when adding a client, engine or service to a FastAPI app, or when writing or reviewing a lifespan or a Depends provider.
---

# FastAPI dependency injection

Every dependency in the app is placed by one question: **where is it
constructed?** That, not `return` versus `yield`, separates the two scopes.
Account for each dependency the app has.

## App scope: construct in the lifespan

A **lifecycle** dependency — http client, database engine, connection pool,
cache, background worker — is constructed once at startup and attached to
`app.state`. `AsyncExitStack` keeps shutdown flat.

```python
@asynccontextmanager
async def lifespan(app: FastAPI):
    async with AsyncExitStack() as stack:
        http = await stack.enter_async_context(httpx.AsyncClient(base_url=...))
        engine = create_async_engine(DB_URL)
        stack.push_async_callback(engine.dispose)

        app.state.rates = RateService(http)
        app.state.sessionmaker = async_sessionmaker(engine, expire_on_commit=False)
        yield

app = FastAPI(lifespan=lifespan)
```

A provider reads what the lifespan put there and constructs nothing, since a
client built per request means a connection pool per request.

```python
def get_rates(request: Request) -> RateService:
    return request.app.state.rates
```

Construct eagerly, even when construction needs `await`, so startup **fails
fast**: a missing env var or an unreachable upstream fails the deploy rather
than the first user's request.

Immutable settings carry no lifecycle, so module level suits them, and
`@lru_cache` on a `Settings` provider is the one place that cache belongs.

## Request scope: the `Depends` default

A provider already runs once per request, and its result is cached for the rest
of that request, so request scope needs nothing extra.

```python
def get_current_user(request: Request) -> User:
    return decode_token(request.headers["authorization"])
```

`yield` adds a teardown point; the scope is the same.

```python
async def get_session(request: Request) -> AsyncIterator[AsyncSession]:
    async with request.app.state.sessionmaker() as session:
        yield session
        await session.commit()   # skipped when the handler raises
```

That per-request cache is what holds a transaction together: a route and a
repository both depending on `get_session` receive the same session.

`expire_on_commit=False` matches that lifetime. The default expires every object
at commit, so the next attribute read becomes an implicit `SELECT` — which async
forbids and reports as `MissingGreenlet`. Pull a server-computed value with an
explicit `await session.refresh(row)`.

Alias the wiring so routes stay readable.

```python
SessionDep = Annotated[AsyncSession, Depends(get_session)]
```

## Keep services framework-free

Service and domain classes take plain constructor arguments and import no
FastAPI. `Depends` stays at the route boundary, and the provider layer is the
only code that knows the framework exists.

## Deferring construction

Defer a **lifecycle** dependency past startup only when construction itself does
I/O that startup must not block on. It then needs double-checked locking against
a lock created in the lifespan, plus an `AsyncExitStack` on `app.state` to own
the teardown — and the lock is held across that I/O, so a slow upstream blocks
every waiting request.

## Testing

Swap dependencies through `dependency_overrides`.

```python
app.dependency_overrides[get_rates] = lambda: FakeRateService()
```

Drive the app with `TestClient(app)` as a context manager, so the lifespan runs
and `app.state` is populated.

## Gotchas

- A module-level client outlives the event loop it bound to, so under pytest it
  raises `Event loop is closed`; a `TestClient` used without `with` leaves
  `app.state` empty and surfaces as a bare `AttributeError`.
- Async SQLAlchemy needs `sqlalchemy[asyncio]`; plain `sqlalchemy` fails at
  import with a missing `greenlet`.
- A `yield` dependency's teardown runs before the response is sent, so a
  `BackgroundTask` opens its own session rather than reusing the request's.
- `asyncio.Lock`, `Event` and `Queue` are created in the lifespan, so they bind
  to the running loop.
