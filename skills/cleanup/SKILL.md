---
name: cleanup
description: Free disk space by removing scratch worktrees and worktrees whose PRs are merged or closed. Use when the disk fills, a build dies on "No space left on device", or when asked to clean up worktrees.
---

# Cleanup

1. Run `git fetch --prune origin`, then list the worktrees (`git worktree list --porcelain`) and every PR's state (`gh pr list --state all --json number,state,headRefName`), matched on the branch name.
2. Remove:
   - scratch worktrees a session made for itself, such as a detached checkout made to run a proving test
   - worktrees whose branch has PRs and all of them are merged or closed
3. Keep everything else: the main checkout, a branch with an open PR, a branch with no PR (live local work, pushed or not), a detached worktree with commits on no branch, and these, which I've asked to keep:
   - `custody-manual`
   Never cut on creation date. That once removed `custody-manual`, and it had to be recreated.
4. Before removing a worktree with uncommitted changes, back them up, untracked files included: `git add -A -N && git diff HEAD --binary > /Users/me/work/platform/worktrees/backups/<worktree>.patch`.
5. Remove with `rm -rf <dir>`, then `git worktree prune`. `git worktree remove --force` fails on build output. Leave branches and the shared Gradle caches alone.
6. If a disk-full crash left a kept worktree's Gradle broken, run `./gradlew --stop` there and delete `servers/.gradle` and `servers/buildSrc/.gradle`.
7. Report what was removed (with each PR's state), what was kept and why, which backups were written, and free space before and after.
