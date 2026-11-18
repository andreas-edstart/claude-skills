# claude-skills

Claude Code skills for reviewing, shaping and shipping changes.

## Install

```bash
git clone https://github.com/andreas-edstart/claude-skills.git ~/.claude-skills
~/.claude-skills/bootstrap
```

Each skill and agent is symlinked into `~/.claude`, and one you already have with the same name is left alone. To add one, create it in `skills/` or `agents/` and re-run `bootstrap`.

## Commands

| Command | What it does |
| --- | --- |
| `/review` | Reviews your local commits or a teammate's PRs, using the subskills below |
| `/pr-loop` | A script checks every minute and wakes Claude when a PR needs you. Runs `/review` on PRs waiting for you.<br>Leaves pending reviews to check before you submit.<br>Auto-approves once feedback is addressed, also if review gets dismissed 🕊️ |
| `/shape` | Shapes an epic: appetite, countable measures, then a solution sketch |
| `/release` | Plans how a change is tested and switched on in production |
| `/cleanup` | Frees disk space by removing worktrees whose PRs are merged or closed |
| `/headache` | Answers with the point first and the detail after |

## Subskills

`/review` runs all of these except `bulletproof` on every PR. Claude also picks any of them up on its own when they fit.

- `naming`: use the words the product already uses
- `types`: model the domain and make impossible states unrepresentable
- `dry`: reuse what the codebase already decides
- `safety`: fail safely and loudly
- `logging`: where and what to log
- `readability`: code that reads as the story of what it does
- `bulletproof`: prove every assumption before building on it

### Agents

- `wcgw`: finds what will go wrong with a change, never fixes
