---
description: Analyze current directory and task to recommend relevant skills, agents, and commands
argument-hint: Optional task description
allowed_tools: ["Glob", "Grep", "Read", "Bash", "Agent"]
---

# /recommend - Skill & Agent Recommender

Analyze the current working directory and the user's task to recommend the most relevant skills, agents, and commands.

## Input

Task or prompt: $ARGUMENTS

## Step 1: Analyze the Project

Quickly scan the current directory to understand the project type. Run these in parallel:

1. **Check for project markers** — look for: `package.json`, `tsconfig.json`, `pyproject.toml`, `setup.py`, `Cargo.toml`, `go.mod`, `Dockerfile`, `docker-compose.yml`, `.github/workflows/`, `CLAUDE.md`, `Makefile`, `requirements.txt`, `pnpm-lock.yaml`, `yarn.lock`, `bun.lockb`
2. **Check top-level structure** — `ls` the root to understand folder layout
3. **Check git status** — are there uncommitted changes, open branches, recent commits?

From this, determine:
- **Language(s)**: TypeScript, JavaScript, Python, Rust, Go, etc.
- **Framework(s)**: React, Next.js, Express, FastAPI, Django, etc.
- **Project type**: web app, API, CLI, library, monorepo, etc.
- **Current state**: fresh project, active development, pre-PR, debugging, etc.

## Step 2: Match Against Available Tools

### Skills (auto-activated context — `~/.claude/skills/`)

| Skill | When to Recommend |
|-------|-------------------|
| `api-design` | Building or modifying REST APIs |
| `backend-patterns` | Node.js/Express/Next.js server-side work |
| `claude-md-improver` | User mentions CLAUDE.md, project setup, or memory |
| `coding-standards` | TypeScript/JavaScript/React projects |
| `deployment-patterns` | CI/CD, Docker deployment, production readiness |
| `docker-patterns` | Dockerfile, docker-compose, containerization tasks |
| `frontend-design` | Building UI components, pages, or web interfaces |
| `playground` | Creating interactive HTML explorers or configurators |
| `python-patterns` | Any Python project |
| `python-testing` | Python testing with pytest |
| `regex-vs-llm-structured-text` | Parsing structured text, choosing between regex and LLM |
| `search-first` | Starting unfamiliar work, looking for existing solutions |
| `security-review` | Auth, user input, secrets, API endpoints, payments |
| `security-scan` | Auditing Claude Code config for vulnerabilities |

### Agents (launched via Agent tool — `~/.claude/agents/`)

| Agent | When to Recommend |
|-------|-------------------|
| `agent-sdk-verifier-py` | After creating/modifying a Python Agent SDK app |
| `code-architect` | Designing new features, need architecture blueprint |
| `code-explorer` | Understanding unfamiliar codebase areas |
| `code-reviewer` | After writing code, before committing or PR |
| `code-simplifier` | After completing a coding task, simplify for clarity |
| `comment-analyzer` | After adding docstrings/comments, before PR |
| `pr-test-analyzer` | Reviewing PR test coverage completeness |
| `silent-failure-hunter` | Code with error handling, catch blocks, fallbacks |
| `type-design-analyzer` | Introducing or refactoring types/interfaces |

### Commands (user-invocable — `/command`)

| Command | When to Recommend |
|---------|-------------------|
| `/plan` | Starting a non-trivial feature, need to plan first |
| `/feature-dev` | Full guided feature development workflow |
| `/tdd` | Test-driven development workflow |
| `/build-fix` | Build is broken, need to fix errors |
| `/code-review` | Quick code review of recent changes |
| `/review-pr` | Comprehensive PR review with multiple agents |
| `/commit` | Ready to commit changes |
| `/commit-push-pr` | Ready to commit, push, and open a PR |
| `/test-coverage` | Check or improve test coverage |
| `/e2e` | Generate and run end-to-end Playwright tests |
| `/refactor-clean` | Clean up and refactor code |
| `/python-review` | Python-specific code review |
| `/learn` | Extract reusable patterns from this session |
| `/update-docs` | Update project documentation |
| `/revise-claude-md` | Update CLAUDE.md with session learnings |
| `/new-sdk-app` | Scaffold a new Claude Agent SDK application |
| `/verify` | Run verification checks |
| `/orchestrate` | Orchestrate multi-step workflows |
| `/skill-create` | Extract patterns from git history into skills |
| `/clean-gone` | Clean up stale local git branches |
| `/update-codemaps` | Regenerate code maps |
| `/checkpoint` | Save a checkpoint of current progress |
| `/security-scan` | Scan Claude Code config for security issues |

## Step 3: Generate Recommendations

Based on the project analysis (Step 1) and the user's task ($ARGUMENTS), produce recommendations in this format:

---

### Recommended for This Task

For each recommendation (3-5 max), include:

**[Type] Name** — one-line reason why it's relevant

> How to use: `/command-name` or "this agent activates automatically" or "invoke with Agent tool"

### Also Useful for This Project

List 2-3 additional tools that are relevant to the project type even if not directly related to the current task. Keep it brief — just name + one-line reason.

### Not Applicable

Optionally note 1-2 tools the user might expect but that don't apply here, with a brief reason (e.g., "No Python tools needed — this is a TypeScript project").

---

## Rules

- **Be specific**: tie each recommendation to something concrete found in the project or task
- **Prioritize**: put the most impactful recommendation first
- **Don't over-recommend**: 3-5 targeted picks beats listing everything
- **If no task given**: base recommendations purely on the project analysis and current git state (e.g., uncommitted changes → suggest `/commit` or `/code-review`)
- **Be honest**: if nothing is particularly relevant, say so rather than forcing recommendations
