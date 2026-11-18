---
name: shape
description: Shape an epic. Set its appetite, pin the outcome and measures to something countable, then sketch a solution in the product's existing idioms. Use when asked to shape an epic.
---

# Shape

Input is an epic's Problem, Outcome and Measures, pasted or as a GitHub issue of type Epic. Everything drafted follows `docs/writing_standard.md`. Anything product reads is in the register of the product decision tickets memory: domain words, no mechanism.

1. **Appetite.** Unless it's given, ask how much time the epic is worth before anything else. The appetite caps the solution, not the other way round.
2. **Problem.** Restate who is affected and what they can't do today. Then check what the code and live data already do, because a problem that is partly solved changes the epic. Measure how many accounts, schools or families it touches.
3. **Outcome.** One sentence describing a state someone can observe in the product. Define every vague word ("all", "visible", "target"). A definition that is a business choice is a question for product, not an assumption: record it, state the default you are carrying on with, and move on.
4. **Measures.** One line per measure:
   - unit: what one counted row is
   - population, and what it excludes
   - numerator over denominator, or the count
   - window
   - source: the warehouse table or entity it is counted from
   - baseline: measured now, or zero by construction; say which
   - target

   A measure passes when one warehouse query computes it after release, so write that query. If the data it needs isn't recorded anywhere, recording it becomes a requirement of the solution. Turn a capability ("countable") into a number with a target. State the population and grain with every number, per the warehouse claim population memory.

   Stop here and agree the outcome and measures before the solution.
5. **Solution.** At breadboard level, sized to the appetite:
   - places (admin pages, portal screens, jobs), what a user can do there, and what gets stored
   - for each element, the precedent it follows: an existing entity, page or job, found in the code and confirmed in recent production data
   - the requirements the measures created
   - rabbit holes: the parts most likely to blow the appetite, and how the shape avoids them
   - no-gos: what is out, so the appetite holds
6. **Questions for product.** Every business choice from steps 3 to 5, each with one measured number and suggested directions written as prose, never an A/B menu.

Draft in chat and run `bin/lint-prose` on the draft. Update the epic's issue body only on an explicit yes.
