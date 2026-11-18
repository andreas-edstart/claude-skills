---
name: pr-loop
description: Keep reviewing PRs waiting on me in the background. Use when asked to start the PR loop.
---

# PR loop

From the repo's checkout, start the Monitor tool on `~/.claude/skills/pr-loop/watch.sh --fresh` with the longest timeout. It checks GitHub every minute and prints a line for each PR that needs me: a review request, a head that moved since my last review, or a dismissed review. The first poll lists everything already waiting.

- On each line, run the review skill's background run (step 10) on the PRs it names.
- On a `poll failed` line, tell me once and keep watching.
- When the monitor expires, re-arm it without `--fresh`, so PRs already handled stay quiet.
