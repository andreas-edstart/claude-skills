---
name: release
description: Plan how a change is tested before it is enabled in production, and what it will be judged against. Pins the epic's outcome and measures, then asks for the test plan and explores it. Use when a change is ready to go behind a flag, or before turning a flag on in production. Also run it without being asked once a PR stack that delivers a notable feature is up for review.
---

# Release

Input is a PR, branch, issue or flag. Everything drafted follows `docs/writing_standard.md`. Anything ops or product read is in the register of the product decision tickets memory: domain words and UI labels, no mechanism.

A PR stack that delivers a notable feature gets a release plan like this without being asked: start it once the stack is up for review. A small fix or a refactor doesn't need one.

1. **The change.** Read the issue and its parent epic (`gh api graphql`, field `parent`; epics are Epic issues in project 10). List what behaves differently from master, in the words ops see. Then say how it is enabled: a `FeatureFlagRecord` (per account, or `enabledForAll`) and who has it today on beta and in prod (`edstart` MCP, entity `FT_FL`), or a deploy with no flag.

2. **Outcome and measures.** Read them from the epic, because they are what the release is judged against. Ask when they are missing, vague, or don't cover what the change does. Pin each measure as `/shape` step 4 does. Measure its baseline now, before anything is enabled, and write the query that computes it after release. Agree them before going on.

3. **Test plan.** Ask how it will be tested before it is enabled in production: who tests, in which environment, on which accounts, and what they do. Then explore the answer:
   - every behaviour change from step 1 has a scenario: the account, the steps, and the result to expect, in UI labels
   - so does every path that should behave as master does
   - each scenario moves a measure, or says why no measure covers it
   - what has already been tried on beta, from the `edstart` MCP: the outcomes, and anything stuck or failed
   - customer emails and SMS follow the root `CLAUDE.md` rules

   Name each gap with the scenario that would close it. Ask rather than assume who does what.

4. **Enabling in production.**
   - the phases (a few accounts, a cohort, everyone)
   - what enabling does to work already queued or in progress in prod
   - what to watch after each phase: the measures, plus failure signals such as stuck items or error tasks, each with its query
   - what stops a phase
   - how to roll back
   - a briefing for the ops contact, given before the first phase: what they'll see change, what to tell us about, and how to switch it off, all in UI labels. The team covers holidays; the contact needs to know what's changing, not who's on watch.

5. **Release plan.** Draft it in chat, opening with the overall in one line: ready or not, and the measure that decides it. Never open with a table. Then give the phases, the test plan, the measures with baselines and queries, go or no-go for each phase, and the ops briefing. Run `bin/lint-prose` on the draft. Save it in the worktree's `tasks/` and in a memory, with its queries, and post nothing yet.

6. **Handover after go-live.** Once it's switched on for everyone, post the plan on the ticket as the handover, rewritten as what happened: what was switched on and when, each phase's numbers against the report or prediction, anything stopped or rolled back, each measure's reading so far and when the deciding one can be read, and the ops briefing. Re-measure every number first. When the deciding measure can be read, post its reading on the ticket as well.
