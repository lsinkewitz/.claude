# Rules

Layered coding standards: `common/` base + language-specific overrides. Language-specific rules take precedence when they conflict.

## Structure

```
rules/
├── common/       # Universal principles (always active)
├── typescript/   # TS/JS specific
├── python/       # Python specific
├── golang/       # Go specific
└── swift/        # Swift specific
```

## Common Rules

| File | Covers |
|------|--------|
| `coding-style.md` | Immutability, small files (<800 lines), error handling, input validation |
| `development-workflow.md` | Research → Plan → TDD → Code Review → Commit |
| `git-workflow.md` | Conventional commits, PR summaries |
| `testing.md` | 80% coverage minimum, TDD mandatory (RED-GREEN-IMPROVE) |
| `security.md` | No hardcoded secrets, input validation, OWASP prevention |
| `performance.md` | Model selection (Haiku/Sonnet/Opus), extended thinking |
| `patterns.md` | Repository pattern, API response envelope, skeleton projects |
| `hooks.md` | PreToolUse/PostToolUse automation, permission management |
| `agents.md` | Agent selection and parallel execution |

## Language-Specific Rules

Each language directory contains: `coding-style.md`, `testing.md`, `patterns.md`, `hooks.md`, `security.md`.

| Language | Key Tools | Highlights |
|----------|-----------|------------|
| **TypeScript** | Prettier, tsc, Playwright | Zod validation, typed API envelope, async/await |
| **Python** | black, ruff, mypy, pytest | PEP 8, type annotations, Protocol for duck typing |
| **Go** | gofmt, go vet, staticcheck, gosec | Accept interfaces/return structs, table-driven tests, `-race` flag |
| **Swift** | SwiftFormat, SwiftLint, Swift Testing | Value types, Actor pattern, Keychain for secrets, strict concurrency |

## Adding a Language

1. Create `rules/<language>/` with the 5 standard files
2. Start each file with `> This file extends [common/xxx.md](../common/xxx.md)`
3. Reference or create matching skills under `skills/`

See [rules/README.md](../rules/README.md) for full details.
