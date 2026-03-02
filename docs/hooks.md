# Hooks

## Personal (`~/.claude/hooks/hooks.json`)

### PreToolUse
| Matcher | Description |
|---------|-------------|
| `Bash` | Block dev servers outside tmux |
| `Bash` | Remind to use tmux for long-running commands |
| `Bash` | Remind to review before git push |
| `Write` | Warn about non-standard doc files |
| `Edit\|Write` | Suggest manual compaction at intervals |

### PostToolUse
| Matcher | Description |
|---------|-------------|
| `Bash` | Log PR URL after creation |
| `Bash` | Async build analysis (background) |
| `Edit` | Auto-format JS/TS (Biome/Prettier) |
| `Edit` | TypeScript check after edits |
| `Edit` | Warn about console.log after edits |

### Other Events
| Event | Matcher | Description |
|-------|---------|-------------|
| SessionStart | `*` | Load previous context, detect package manager |
| PreCompact | `*` | Save state before compaction |
| Stop | `*` | Check for console.log in modified files |
| SessionEnd | `*` | Persist session state |

## Plugin Hooks

| Plugin | Event | Matcher | Description |
|--------|-------|---------|-------------|
| explanatory-output-style | SessionStart | `*` | Add educational insights instructions |
| hookify | PreToolUse, PostToolUse, Stop, UserPromptSubmit | `*` | User-configurable hooks from .local.md |
| security-guidance | PreToolUse | `Edit\|Write\|MultiEdit` | Warn about security issues on file edits |
| ralph-loop | Stop | `*` | Detect self-referential loops |
