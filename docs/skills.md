# Skills, Commands & Plugins

> **Skills** = auto-injected context (`~/.claude/skills/`)
> **Commands** = user-invocable via `/name` (`~/.claude/commands/`)
> **Plugins** = bundles of skills, commands, hooks, agents

## Commands (`~/.claude/commands/`)

| Command | Description |
|---------|-------------|
| `/plan` | Restate requirements, assess risks, create step-by-step plan |
| `/feature-dev` | Guided feature development with architecture focus |
| `/tdd` | Test-driven development: tests first, then implement |
| `/build-fix` | Fix build errors |
| `/simplify` | Review changed code for reuse, quality, efficiency |
| `/refactor-clean` | Refactor and clean up code |
| `/code-review` | Code review of recent changes |
| `/review-pr` | Comprehensive PR review with specialized agents |
| `/python-review` | Python code review (PEP 8, types, security) |
| `/test-coverage` | Check/improve test coverage |
| `/e2e` | Generate and run Playwright end-to-end tests |
| `/commit` | Create a git commit |
| `/commit-push-pr` | Commit, push, and open a PR |
| `/clean-gone` | Clean up local branches deleted on remote |
| `/checkpoint` | Save a checkpoint of current progress |
| `/verify` | Run verification checks |
| `/orchestrate` | Orchestrate multi-step workflows |
| `/recommend` | Recommend relevant skills, agents, commands for a task |
| `/learn` | Extract reusable patterns from session |
| `/revise-claude-md` | Update CLAUDE.md with session learnings |
| `/update-docs` | Update project documentation |
| `/update-codemaps` | Regenerate code maps |
| `/new-sdk-app` | Scaffold a new Claude Agent SDK app |
| `/skill-create` | Extract patterns from git history into skills |

## Skills (`~/.claude/skills/`)

Auto-activated by Claude when relevant — no `/command` needed.

| Skill | Description |
|-------|-------------|
| `api-design` | REST API patterns, naming, pagination, errors |
| `backend-patterns` | Node.js/Express/Next.js server-side best practices |
| `claude-md-improver` | Audit and improve CLAUDE.md files |
| `coding-standards` | TS/JS/React/Node.js standards and patterns |
| `deployment-patterns` | CI/CD, Docker, rollback, production readiness |
| `docker-patterns` | Docker Compose, container security, networking |
| `frontend-design` | Production-grade frontend interfaces |
| `playground` | Interactive HTML playgrounds with live preview |
| `python-patterns` | Pythonic idioms, PEP 8, type hints |
| `python-testing` | pytest, TDD, fixtures, mocking, coverage |
| `regex-vs-llm-structured-text` | Choose regex vs LLM for structured text parsing |
| `search-first` | Research existing solutions before coding |
| `security-review` | Auth, input validation, secrets, OWASP patterns |
| `security-scan` | Scan .claude/ config for vulnerabilities |

## Plugin Skills

| Skill | Plugin | Description |
|-------|--------|-------------|
| `claude-automation-recommender` | claude-code-setup | Recommend hooks/agents/skills for a codebase |
| `command-development` | plugin-dev | Develop slash commands |
| `hook-development` | plugin-dev | Develop event-driven hooks |
| `agent-development` | plugin-dev | Develop autonomous agents |
| `mcp-integration` | plugin-dev | Integrate MCP servers |
| `writing-hookify-rules` | hookify | Write hookify rule files |
| `stripe-best-practices` | stripe | Stripe payments, subscriptions, webhooks |
| `example-skill` | example-plugin | Reference template for skill structure |
