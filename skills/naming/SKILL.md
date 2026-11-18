---
name: naming
description: How to name variables, functions, types, tests and comments. Use when naming anything or checking names.
---

# Naming

Use the words the product already uses. Never coin a term.

## Where the words come from, in order

1. The design and UI copy (labels, buttons, dialog text) for anything a user sees.
2. Names already in the code: API types and fields, entity fields, existing tests, and the phrases its KDoc uses ("a line being saved").
3. Domain terms the team already uses in tickets and product docs.

Look these up before naming. If nothing fits, say so and propose a name rather than inventing one silently.

The design's copy is the truth. Depart from it only where the functionality has pivoted, and then only as far as
the pivot reaches: drop or adapt the words for what was built differently, and keep the rest verbatim. A wording
you find more precise, or a shared component that won't take the label, is no reason to depart.

## Principles

- One concept, one name, in every layer: server, API, front end, tests, comments. Reuse the existing name (`originatingAccountPlanId`) instead of adding a synonym (`sourceAccountPlanId`).
- Names that set appearance (component props and CSS that style something) may describe the look rather than the state behind it: a `done` task can pass `faded` to its marker. Translating domain state into appearance naturally flips the word, so don't raise it.
- Keep a word's established meaning. If `billed` means invoiced everywhere else, don't call a total that includes estimates `billed`. Search the code for the word first.
- Name for what it means, not how it is worked out.
- Read the name cold: could it mean something else? `schoolTotal` reads as a sum across the school.
- Read the name where it's used, aloud; that's the test. Each use should say what the KDoc or copy says. For a collection, check that its uses show what it holds, by what key, and how it is narrowed. If they already read right, the name is fine; don't raise it from the declaration alone.
- Read the call, not the declaration: the receiver, name and first argument form a phrase. A value reads as a noun phrase (`batchDays.dayFor(plan.id)`, "the batch day for this plan") and an action as a verb phrase (`plan.queueConfirm(ctx)`). Drop words the call already says: `plan.id.batchDay(batchDays)` repeats "batch" and reads as nothing.
- Mark a hypothetical value as one (`totalIfSavedForSchool`), and check the marker doesn't clash with a neighbouring name.
- Name a handler after the action the user takes, in its label's words: "Save as a rule" gives `saveAsRule`.
- Name a component for everything it renders, not the first case it was built for.
- A test's name states the behaviour in domain words.
- When naming is being aligned across the code, update the tests to the same terminology too. Otherwise, don't nitpick a one-off variable name inside a unit test.
- Check a KDoc in two passes. First, strike what says how the code works or what it does; the code already shows that. Then read what's left against the name. If it says nothing the name doesn't, delete the KDoc rather than trimming it. On `BulkCustomerInvoiceProgress`, "How far a bulk has got" says nothing `Progress` doesn't, so the KDoc goes.
- A local or lambda variable's name needs to say only as much as its scope hides. Where every use is close enough to the definition for the meaning to be apparent, `val added = schemaDiff(…)?.added` is fine; read further down a long function, `added` no longer says what was added.
- Don't propose a name over about 20 characters (Code Complete's "Optimum Name Length"). If being accurate takes a clause (`failedForGoodWithNoRetryWaiting`, 31), say what the current name gets wrong and let the author choose. A name that long usually means the value holds two ideas.

## Shipped names

Renaming a mirrored API field breaks its readers: add the new name alongside, and drop the old one after the front end deploys.
