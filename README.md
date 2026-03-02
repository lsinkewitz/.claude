# Claude Code Config

Portable Claude Code setup — agents, skills, commands, hooks, and scripts.

## Setup

```bash
git clone <repo-url> ~/.claude
./setup.sh
```

The setup script installs `git`/`jq`, creates `settings.json` from the template (prompts for API keys), and initializes runtime directories.

## Structure

| Directory | Purpose |
|-----------|---------|
| `agents/` | Custom agent definitions |
| `.agents/` | Agent skills with OpenAI configs |
| `commands/` | Slash commands (`/plan`, `/commit`, etc.) |
| `skills/` | Auto-activated context skills |
| `hooks/` | Event-driven hook scripts |
| `contexts/` | Switchable context profiles |
| `rules/` | Layered coding standards (common + per-language) |
| `scripts/` | CI validators, hook scripts, utilities |
| `plugins/` | Plugin metadata (content auto-downloaded) |

## Docs

- [Skills & Commands](docs/skills.md) — 22 commands, 14 skills
- [Agents](docs/agents.md) — 9 agents
- [Hooks](docs/hooks.md) — pre/post tool use, session lifecycle
- [Rules](docs/rules.md) — coding standards (common + TS/Python/Go/Swift)

## Adding new files

The `.gitignore` uses a whitelist — everything is ignored by default. To track new directories or files, add `!path/` entries to `.gitignore`.
