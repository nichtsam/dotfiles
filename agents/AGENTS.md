# Global rules

## Discussing

- Never refer back by number or shorthand. Name the thing again in words.

## Starting work

Starting a new chain of actions needs my explicit agreement. Steps inside a chain I already
approved don't.

- Non-trivial work: run the quality guardrails (checks, lint, format), then report the
  change in three parts — what prompted it, what it changed, and how that answers the
  original need. STOP. Commit on approval.

## Commit messages

- English only, even when the diff is zh locale copy.
- Propose the message, body included, as part of the pre-commit stop. Write a body when
  the diff alone doesn't carry the intention.
