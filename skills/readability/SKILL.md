---
name: readability
description: Shape code so it reads as the story of what it does. Use when writing or reviewing code, especially long functions.
---

# readability

A reader should understand a function from its top level alone.

- A long function splits along its semantic seams: the distinct things it does, such as finding what is due, checking what is ready and acting on it. The top level reads as those steps, and each read moves into a function named for what it returns.
- Signpost a dense function: a blank line between its steps, each led by a few-word comment. In review, raise one comment on the function's signature asking for signposts, not one per block.
- A comment talks only about the code it sits on. If it names something that code never mentions, such as another flow, screen or caller, it is explaining a cause that lives elsewhere, and the reader has to find that place before the comment makes sense. Pin the behaviour with a test named for the case and drop the comment. If the line still needs a word, use the terms the line itself uses. Example: `// A bulk clone has no one drawdown to pick a billing period for, so like any clone without one it's added at Draft` sat above `if (params.billingPeriodId != null && item.clonesViaManualInvoice(context.repo))`. Nothing in `clone()` mentions bulk; Bulk Clone's dialog just sends no billing period. The test `a bulk clone of drawdowns to a school adds each at Draft` already fails if the null check goes, so the comment went.
- Name the algorithm. A well-known technique (hash bucketing, binary search, exponential backoff) gets its name in the signpost, so the reader can look it up rather than decode it, and its intermediate steps get named values.
- Inside a long function, a chain of two or more combinators becomes a private extension named for its result. A single `map` or `filter` stays inline.
- Branch on the positive case and let the other fall through. `null` never leads an if/else, and `takeUnless` is the same negation. A guard that would otherwise indent the whole function returns early instead, and logs the no-op.
- In TypeScript, logic with more than one step is a plain `for` loop with `if`s, not an inline arrow helper or a `Set` copied to move an element.
- In TypeScript, name a shape that means something in the domain: `bursaries: BursaryChoice[]` with an interface, not `Array<{name?: string; students?: Record<string, StudentConcession>}>`. The name tells the reader what each entry is without parsing its structure, and a function can take one entry as `(bursary: BursaryChoice)` rather than `Form['bursaries'][number]`. Raise it as a readability point in its own comment, not tucked under another finding. It isn't a safety point, because the compiler treats both forms the same.
- One kind of thing per list, and no special values. When an entry or value stands in for something else, every reader of it has to decode it, and each one adds a special case. Examples: an empty-name entry in a list of presets that is really the "Add custom" button, or an empty string, `0` or `-1` meaning "none". The special cases show up as checks like `name && name === preset.name` and `name ? … : 'Add custom'`. Give the other thing its own element, field or branch, so the list holds only its own kind and the checks go.
- In review, a readability finding has to make sense to someone who hasn't opened the file. Say what the code sets up and what the odd part really is before quoting the lines it complicates. Then, for each line, say what goes wrong without its special case ("without `name &&`, adding a custom bursary would hide the custom button"). Only then give the principle and the ask.
