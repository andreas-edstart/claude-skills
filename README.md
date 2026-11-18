# claude-skills

Claude Code skills for reviewing, shaping and shipping changes.

## Install

```bash
git clone https://github.com/andreas-edstart/claude-skills.git ~/.claude-skills
~/.claude-skills/bootstrap
```

Each skill is symlinked into `~/.claude/skills`, and one you already have with the same name is left alone. To add a skill, create it in `~/.claude-skills` and re-run `bootstrap`.

## Commands

| Command | What it does |
| --- | --- |
| `/review` | Reviews your local commits or a teammate's PRs, using the subskills below |
| `/shape` | Shapes an epic: appetite, countable measures, then a solution sketch |
| `/release` | Plans how a change is tested and switched on in production |
| `/cleanup` | Frees disk space by removing worktrees whose PRs are merged or closed |
| `/headache` | Answers with the point first and the detail after |

## Subskills

`/review` runs the first six on every PR. Claude also picks any of them up on its own when they fit.

- `naming`: use the words the product already uses
- `types`: model the domain and make impossible states unrepresentable
- `dry`: reuse what the codebase already decides
- `safety`: fail safely and loudly
- `logging`: where and what to log
- `readability`: code that reads as the story of what it does
- `bulletproof`: prove every assumption before building on it
