---
name: safety
description: Write code that fails safely and loudly. Use when writing or reviewing server code, especially jobs and system tasks.
---

# safety

Code that meets bad data fails in a way someone can see and act on, and never takes good data down with it.

- No `!!` in production Kotlin. A failed `!!` shows admin users a null pointer error that tells them nothing. Throw `InvalidState` with what is missing and the id that lets someone find it: `tuitionYear ?: throw InvalidState("Plan has no tuition year", "accountPlanId" to id)`.
- A job that loops over many records checks each one in its own `try`/`catch` and skips one that fails, so one bad record can't stop everyone else's.
- Bound every query to the records in hand or a date. Never load a table's whole history, such as every failed job ever written.
- A timeout, limit or batch size states why it differs from the default, or uses the default.
- Bad config throws; it never quietly does nothing.
- A function takes the values it reads, not the whole `AccountWrapper` they come from: the plan status, the current plan's tailored plan type, the enrolments for a year. Its signature then says what it depends on, it can't quietly read anything else, and its test passes those values instead of simulating an account. Keep the wrapper only when the values would make too many parameters to read well.
