---
name: release
description: Plan how a change is tested before it is enabled in production, and what it will be judged against. Pins the epic's outcome and measures, then asks for the test plan and explores it. Use when a change is ready to go behind a flag, or before turning a flag on in production. Also run it without being asked once a PR stack that delivers a notable feature is up for review.
---

# Release

Input is a PR, branch, issue or flag. Everything drafted follows `docs/writing_standard.md`. Anything ops or product read is in the register of the product decision tickets memory: domain words and UI labels, no mechanism.

A PR stack that delivers a notable feature gets a release plan like this without being asked: start it once the stack is up for review. A small fix or a refactor doesn't need one.

1. **The change.** Read the issue and its parent epic (`gh api graphql`, field `parent`; epics are Epic issues in project 10). List what behaves differently from master, in the words ops see. Then say how it is enabled: a `FeatureFlagRecord` (per account, or `enabledForAll`) and who has it today on beta and in prod (`edstart` MCP, entity `FT_FL`), or a deploy with no flag.

2. **Outcome and measures.** Read them from the epic, because they are what the release is judged against. Ask when they are missing, vague, or don't cover what the change does. Pin each measure as `/shape` step 4 does. Measure its baseline now, before anything is enabled, and write the query that computes it after release. Agree them before going on.

3. **Test plan.** Ask how it will be tested before it is enabled in production: who tests, in which environment, on which accounts, and what they do. Then explore the answer, as two separate parts of the plan:
   - **Human review** comes first, and spends people's time only on what no test or query can judge, such as whether an AI's answers are right. Say who reviews, how many items, and how sure that sample makes us. A scenario a person runs gives the account, the steps and the result to expect, in UI labels.
   - **Automated review** covers the rest. Every behaviour change from step 1, and every path that should behave as master does, names the test that pins it before deploy and the query that checks it in prod after switching on.
   - each check moves a measure, or says why no measure covers it
   - what has already been tried on beta, from the `edstart` MCP: the outcomes, and anything stuck or failed
   - before running a scenario on beta, confirm beta runs a build with the change and the rollout has finished. Check that the scenario's account reaches the changed check, because an earlier check can stop it first, and beta's data often does
   - customer emails and SMS follow the root `CLAUDE.md` rules. The beta testing memory says what beta sends, and to whom

   Name each gap with the check that would close it. Ask rather than assume who does what.

4. **Enabling in production.**
   - switching it on: for everyone in prod once it's tested, which closes the ticket. Don't schedule it weeks out because the ticket names a later date. Check what that date protects, and keep it only when switching on early would change what customers get
   - what enabling does to work already queued or in progress in prod
   - what to watch after switching on: the measures, plus failure signals such as stuck items or error tasks, each with its query
   - what makes us switch it off
   - a stop condition that compares a count against a prediction: predict how many will actually get through, not how many the change applies to. A change often removes one obstacle among several, and whatever it lets past still has to pass every other check. For example, letting at risk families renew still sends some of them to manual review for other reasons. So either predict with every check applied, or compare against a count that only the change decides, such as how many no longer fail the check it changed
   - how to roll back. For a `FeatureFlagRecord`, switch `enabledForAll` off on the record that has it: the lookup reads the first record with it set, so a value on a second record can leave it on
   - a briefing for the ops contact, given when it's switched on: what they'll see change, what to tell us about, and that it's behind a flag we can switch off, all in UI labels. We switch flags, not ops, so leave out how. The team covers holidays; the contact needs to know what's changing, not who's on watch. Write each instruction while looking at the screen it's done on, using the labels and controls it shows: a Yes/No drop-down isn't a tick box, and a field may show a code rather than its label.

5. **Release plan.** Draft it in chat, opening with the overall in one line: ready or not, and the measure that decides it. Never open with a table. Then give switching it on, the human review, the automated review, the measures with baselines and queries, go or no-go, and the ops briefing. Run `bin/lint-prose` on the draft. Save it in the worktree's `tasks/` and in a memory, with its queries. Post nothing on the ticket yet, except a note for product once it's tested: "tested in beta and ready to turn on in prod (via feature flag)", the most it could affect as "up to about X of Y", and the deciding measure in plain words (last season's figure for the group against everyone, and that we'll measure how far it rises). Say "we", round the numbers, and leave out edge cases, corrections and how-to. The product tickets memory has an approved example. Draft it in chat and post it only on a yes.

6. **Handover after go-live.** Once it's switched on for everyone, post the plan on the ticket as the handover, rewritten as what happened: what was switched on and when, the numbers against the report or prediction, anything stopped or rolled back, each measure's reading so far and when the deciding one can be read, and the ops briefing. Re-measure every number first. When the deciding measure can be read, post its reading on the ticket as well.
