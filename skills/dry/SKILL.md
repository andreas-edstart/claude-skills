---
name: dry
description: Reuse what the codebase already decides instead of writing a second copy. Use when writing or reviewing code.
---

# DRY

Each rule has one home, so changing it changes every place that relies on it. Before writing a rule, find where the
codebase already decides it and call that. A second copy gets left behind when the rule changes, and the two disagree:
a page offers a date its save then refuses.

Pull nearby copies onto the same home while you're there. How far depends on whose change it is. Building your own,
reach past the files the change touches to the other copies of the rule you're reusing. Reviewing someone else's, keep
to the same file and the files their change touches: asking for more widens their PR. Either way, take only the easy
wins, a call swap that keeps behaviour. A copy that would behave differently through the shared home is a question for
the author, not a quiet change. This isn't a sweep of the codebase. A new home its neighbours don't use is just one
more copy.

When reusing a function, check what it does differently from the copy, and pin any change with a test. A helper can
carry its caller's context: split the rule from the lookup so each caller supplies its own.

Frontend styles stay WET. Repeated declarations across styled components aren't a copy to pull together: shared
styling gets promoted into the theme later, once the design has settled. Don't raise them, in writing or review.

In a review, open on the principle in words and cite the repo's rule: `CLAUDE.md`'s "Don't duplicate code - extract
common logic into shared methods". Copies sit in several places, so the problem alone doesn't show why it matters; only
a single pair can open on the two lines side by side instead. Copies that already disagree are the strongest evidence,
so they come straight after the principle.
