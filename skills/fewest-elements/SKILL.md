---
name: fewest-elements
description: Check that each piece of a change needs to exist. Use when designing, writing or reviewing code, and again after a design changes.
---

# Fewest elements

Each field, type, function, parameter, job and test earns its place, or goes: fewest elements, the last of Kent Beck's
four rules of simple design. It ranks below passing the tests, revealing intention and no duplication, so a cut that
makes the code harder to follow loses.

For each piece a change adds, find what reads it and what breaks without it. It goes when:

- Nothing reads it. A field only the raw entity shows, holding an error that's already logged with the record's id.
- Something else already says it. A stored value worked out from other stored values, or a timestamp marking what a
  status already marks.
- The design moved on. A helper, option or migration built for an earlier shape of the change, such as a scheduling
  option kept only for a migration that's since gone.
- The step before can do it. A check inside a job that the query choosing the work can make instead, or a retry the
  next scheduled run already does.

Check again each time the design changes, not only at the end: every change of direction strands pieces of the last.

Keep a piece that stops a state the domain never has, such as one type for two fields only ever set together, or that
carries a guarantee: a lock, a transaction per record, a loud failure.

In a review, open on the piece and what already covers it, and cite the rule by name. List what was looked at but kept,
each with what it guarantees.
