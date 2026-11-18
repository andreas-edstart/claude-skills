---
name: logging
description: Where and what to log. Use when writing or reviewing server code that logs, especially jobs and system tasks.
---

# logging

Logs live in the layer with side effects: the job, system task or workflow action. A deeper function doesn't log; its signature and return value tell the story.

- A top-level job that exits early without doing anything logs why, such as `Nothing to confirm: 2026-12-11 is outside the December renewals`.
- A job that does work ends on one line with what it did and out of how many, such as `Queued 120 of 500 plans due by 2026-12-10 to confirm`.
- A record that fails inside a job's loop is caught and logged in the job, with `log.structuredError` and the record's id. The helper it calls just throws, so the skip shows where the work happens.
- SLF4J `{}` placeholders, never string interpolation.
