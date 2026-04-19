# Claude AI Learning Guide
*A progressive guide from casual use to advanced developer workflows*

## Table of Contents
1. [Choose Your Path](#choose-your-path)
2. [Level 0: Core Concepts](#level-0-core-concepts)
3. [Level 1: Start Here — Claude.ai (Web)](#level-1-claudeai-web)
4. [Level 2: Level Up — Claude Code (CLI)](#level-2-claude-code-cli)
5. [Level 3: Supercharge — Superpowers Plugin](#level-3-superpowers-plugin)
6. [Level 4: Build — Claude API](#level-4-claude-api)
7. [Quick Reference Card](#quick-reference-card)
8. [Learning Path](#learning-path)
9. [Troubleshooting](#troubleshooting)
10. [Resources](#resources)

---

## Choose Your Path

Answer three questions to find your starting level:

```
Do you write code professionally or regularly?
├── No  → Start at Level 1 (Claude.ai Web)
└── Yes → Do you want AI assistance directly in your terminal and repo?
           ├── No  → Level 1 + Level 4 (Claude.ai + API basics)
           └── Yes → Do you want structured workflows for TDD, PRs, and planning?
                      ├── No  → Level 2 (Claude Code vanilla)
                      └── Yes → Level 3 (Superpowers Plugin)
```

**Not sure?** Start at Level 1. Each level builds on the previous — you can always continue.

---

## Level 0: Core Concepts

*These concepts apply across all Claude interfaces. Read this first regardless of your path.*

### The Two Levers of AI Performance

**1. Model — what Claude knows (not directly controllable)**
- The underlying neural network, trained by Anthropic
- Determines reasoning ability, knowledge cutoff, and coding capability
- You select which model to use, but cannot modify it

**2. Context — what Claude sees per session (fully controllable)**
- Everything in the conversation: your messages, files, history, system prompt
- This is where most performance gains come from
- Better context = fewer hallucinations, more accurate responses
- The context window is finite — when it fills, older content is lost or summarized

**The practical implication:** Spending time on context quality (clear prompts, relevant files, good system prompts) returns more than obsessing over model selection for most tasks.

---

### How the Context Window Works

Every Claude session has a context window — a limit on how much text can be "in view" at once.

| What fills the context window |
|-------------------------------|
| Your messages |
| Claude's responses |
| Files you attach |
| System prompt / instructions |
| Tool call results (MCP, file reads, etc.) |

**When the window fills:**
- Claude starts losing memory of earlier parts of the conversation
- Quality degrades — responses become less consistent with earlier context
- In Claude Code, use `/compact` to summarize before this happens

**Golden rule:** One task per conversation. New task = new chat.

---

### Token and Cost Mental Model

- **1 token ≈ ¾ of a word** (roughly 4 characters)
- "Hello, how are you today?" ≈ 7 tokens
- A typical code file: 500–2,000 tokens
- Context windows: 200,000 tokens for most Claude models

Cost scales with model and token count. Rough tiers:

| Model | Best For | Speed | Cost |
|-------|----------|-------|------|
| **Haiku 4.5** | Simple tasks, fast iteration, high volume | Fastest | Lowest |
| **Sonnet 4.6** | Most coding and analysis tasks | Fast | Mid |
| **Opus 4.6** | Complex reasoning, architecture, planning | Slower | Highest |

**Default to Sonnet 4.6** for most work. Use Haiku when speed matters more than depth. Use Opus when the task requires sustained multi-step reasoning (e.g., writing a full implementation plan).

---

## Level 1: Claude.ai (Web)

*The browser-based interface. No installation required. Best for: writing, analysis, Q&A, quick coding help, non-technical workflows.*

### Getting Started

1. Go to **claude.ai** and create an account
2. Select a model from the dropdown at the top of the chat (default: Sonnet)
3. Start a conversation — no setup required

**Interface overview:**
- **Chat area** — your main workspace
- **Model selector** — top of chat; switch models per conversation
- **Projects** — left sidebar; persistent context across sessions
- **Artifacts** — rendered panel on the right for code, documents, diagrams

---

### Projects — Persistent Context

Projects let Claude remember context across multiple conversations. Think of them as persistent workspaces.

**What a Project contains:**
- A **system prompt** you write (instructions, context, persona)
- **Uploaded files** (PDFs, docs, code) available in every conversation
- **Conversation history** Claude can refer back to

**Setting up a Project:**
1. Click **Projects** in the left sidebar
2. Click **New Project**
3. Add a project system prompt — tell Claude what it needs to know permanently:
   ```
   You are helping me with my Java microservices codebase.
   Stack: Java 17, Spring Boot 3, Kafka, PostgreSQL.
   Always suggest solutions compatible with these versions.
   Prefer immutable objects and avoid nulls.
   ```
4. Upload relevant reference files (architecture docs, style guides, API contracts)

**When to use Projects vs plain chat:**
| Use Projects | Use Plain Chat |
|---|---|
| Recurring work on the same codebase | One-off questions |
| Want Claude to remember your preferences | No persistent context needed |
| Team-shared context | Personal quick tasks |

---

### Memory

Claude.ai can remember things across all conversations (not just within a Project).

**How to use it:**
- Say: *"Remember that I prefer TypeScript over JavaScript for all future conversations"*
- Claude confirms and stores it
- Applies to all future chats automatically

**Managing memory:**
- Go to **Settings** → **Memory** to view and delete stored memories
- Be intentional — memory that conflicts with a project system prompt can cause inconsistency

---

### Artifacts

Artifacts are rendered outputs that appear in a side panel — code, documents, SVGs, and React components Claude can generate and iterate on live.

**What renders as an artifact:**
- Code files (with syntax highlighting and copy button)
- Markdown documents
- SVG diagrams
- Simple React components (rendered live)
- HTML pages

**Iterating on artifacts:**
- Ask Claude to modify the artifact directly: *"Add error handling to the fetch call"*
- The artifact updates in place — no need to copy/paste back
- Click the artifact to expand it full-screen

**Exporting:**
- Click **Copy** to copy the full content
- Click the download icon (where available) to save as a file

---

### Advanced Features

**File uploads:**
- Drag and drop or click the attachment icon
- Supports: PDFs, images, text files, code files, CSV
- Images: Claude can read diagrams, screenshots, handwritten notes

**Web search:**
- Ask: *"Search the web for the latest Spring Boot 3.3 release notes"*
- Claude retrieves and summarizes current information
- Useful for anything after your knowledge cutoff

**Voice mode:**
- Click the microphone icon in supported browsers
- Talk to Claude and receive spoken responses
- Best for: thinking out loud, quick questions, accessibility

---

### Best Practices — Claude.ai

**Do:**
- Give Claude a role and context at the start: *"You are a senior Java engineer reviewing my PR. Here's the diff: ..."*
- Be specific about format: *"Give me a bullet-point summary, max 5 points"*
- Start a new conversation for each distinct task
- Use Projects for recurring work

**Don't:**
- Continue a conversation that has drifted far from the original topic
- Assume Claude remembers things from a previous chat (unless using Projects/Memory)
- Treat long conversations as reliable — context degrades over time

---

### Troubleshooting — Claude.ai

**"Claude is ignoring my instructions"**
- The conversation context may be too long — start a new chat
- Check if a Project system prompt is conflicting with your in-chat instructions

**"Claude made something up"**
- Hallucination increases on specific facts (dates, API names, version numbers)
- Always verify factual claims against primary sources
- Ask Claude to cite its sources or acknowledge uncertainty

**"Claude refused my request"**
- Rephrase to clarify intent: add context about why you need it
- Some refusals are hard limits; most can be resolved with clearer framing

---

## Level 2: Claude Code (CLI)

*Claude in your terminal. Full file system access, runs commands, reads your repo. Best for: feature implementation, bug fixing, code review, PR workflows.*

### Installation and Setup

**Prerequisites:** Node.js 18+

```bash
# Install Claude Code globally
npm install -g @anthropic-ai/claude-code

# Authenticate
claude
# Follow the OAuth flow in your browser

# Verify installation
claude --version
```

**First run:**
```bash
cd your-project
claude
```

Claude Code opens an interactive session with your repo indexed and available.

---

### CLAUDE.md — Your Rules File

`CLAUDE.md` is the most important configuration file in Claude Code. It's a markdown file Claude reads at the start of every session — equivalent to a persistent system prompt for your project.

**Locations:**

| File | Scope |
|------|-------|
| `~/.claude/CLAUDE.md` | Global — applies to all repos on your machine |
| `<repo-root>/CLAUDE.md` | Project — applies to this repo only (commit to source control) |

**What to put in CLAUDE.md:**

```markdown
# My Project — Claude Instructions

## Stack
Java 17, Spring Boot 3.2, Kotlin, PostgreSQL, Redis

## Conventions
- Use constructor injection, never field injection
- All new classes need unit tests
- Follow existing package structure — don't create new packages without asking

## Git Rules
- Never commit unless explicitly asked
- Never push to main
- Commit messages follow: type(scope): description

## Testing
- Use JUnit 5 + MockK for Kotlin, Mockito for Java
- Run `./gradlew test` before claiming anything passes
```

**What NOT to put in CLAUDE.md:**
- Verbose documentation that belongs in a README
- Obvious coding standards that any developer would follow
- Information specific to one task (put that in the chat, not the file)

**Rule:** CLAUDE.md uses context tokens on every session. Keep it dense and actionable.

---

### Built-in Slash Commands

Type `/` in the Claude Code prompt to see all available commands.

| Command | What it does |
|---------|-------------|
| `/help` | List all commands and current settings |
| `/clear` | Clear conversation history, start fresh |
| `/compact` | Summarize the conversation to free up context |
| `/cost` | Show token usage and cost for this session |
| `/model` | Switch model mid-session |
| `/init` | Generate a CLAUDE.md for the current project |
| `/review` | Review the last set of changes |
| `/commit` | Stage and commit with an AI-generated message |
| `/doctor` | Check Claude Code health and configuration |

**Pro tip — `/init`:**
In a new project, run `/init` first. Claude Code reads the codebase and generates a starter `CLAUDE.md` with the detected stack, conventions, and structure. Edit it from there rather than writing from scratch.

---

### Working Modes

**Interactive mode (default):**
```bash
claude
```
Full back-and-forth session. Claude can read files, run commands, make edits, ask clarifying questions.

**Non-interactive / print mode:**
```bash
claude --print "What does the UserService class do?"
claude -p "Summarize the recent git log"
```
One-shot: Claude responds once and exits. Useful for scripting, CI pipelines, or quick lookups.

**Continue last session:**
```bash
claude --continue
```
Resumes the most recent conversation with its context intact.

---

### Context Management

Claude Code automatically indexes your repo, but you control what's explicitly in context.

**Adding files to context:**
```
@src/main/java/UserService.java    # add a specific file
@src/main/java/                    # add a directory
```

**Context discipline:**
- Avoid adding entire directories unless necessary — each file costs tokens
- Use `/compact` when the session gets long; it summarizes what's been done and keeps the working state
- Start a new session for each new task — don't let one session accumulate context from multiple unrelated tasks

**Checking context usage:**
```
/cost
```
Shows current token usage. When you're approaching the limit, `/compact` before continuing.

---

### MCP Integrations

MCP (Model Context Protocol) gives Claude Code access to external tools and APIs — Jira, GitHub, Confluence, Datadog, Slack, and more.

**Configure MCPs in `~/.claude/settings.json`:**
```json
{
  "mcpServers": {
    "atlassian": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-server-atlassian"],
      "env": {
        "ATLASSIAN_TOKEN": "your-token-here"
      }
    }
  }
}
```

**Using MCPs in chat:**
```
What Jira tickets are assigned to me this sprint?
```
Claude Code recognizes the intent, calls the MCP tool, and returns results inline.

**Finding available MCPs:**
- Browse the MCP directory in Anthropic's Claude Code documentation
- Enterprise teams can configure shared MCPs via admin settings

**Troubleshooting MCPs:**
- Run `/doctor` to check MCP connection status
- Most issues are auth or network — verify tokens and firewall rules

---

### Subagents

Claude Code can spawn subagents — independent agent instances with their own context window — to work on parallel tasks.

**When Claude Code uses subagents:**
- Tasks that are explicitly independent (e.g., "update the README and fix the linting errors")
- When asked to use the Agent tool explicitly

**Parallelizing work:**
```
Implement the login endpoint and the logout endpoint in parallel.
They share no state — run them as separate agents.
```

**Key rule:** Only parallelize tasks that don't touch the same files. Subagents working on the same file will conflict.

---

### Permission Modes

Claude Code asks for approval before taking potentially destructive actions (deleting files, running certain commands, pushing to git).

| Mode | Behavior |
|------|----------|
| Default | Prompts for approval on risky actions |
| `--dangerously-skip-permissions` | Auto-approves everything — use only in trusted environments |

**Approving a tool call:**
- Claude shows you exactly what it's about to run
- Type `y` to approve, `n` to deny
- Denied actions are not retried automatically

---

### Best Practices — Claude Code

**Do:**
- Write a `CLAUDE.md` before your first real session
- Use `/compact` proactively — before you hit the context ceiling, not after
- Verify before trusting: run tests, check diffs, read generated code
- Keep sessions focused — one feature, one bug, one PR

**Don't:**
- Let Claude commit or push without reviewing the diff
- Assume tests pass because Claude said they do — run them yourself
- Use `--dangerously-skip-permissions` in repos with shared or production state

---

### Troubleshooting — Claude Code

**"Claude is making changes I didn't ask for"**
- Add explicit scope constraints to CLAUDE.md: *"Only modify files directly related to the current task"*
- Be more specific in your prompt about what is and isn't in scope

**"Context window is filling up"**
- Run `/compact` to summarize
- Start a new session for the next task

**"MCP tool not connecting"**
- Check `~/.claude/settings.json` for syntax errors
- Verify auth token is valid and not expired
- Run `/doctor` for diagnostic output

**"Claude Code won't run a command"**
- Check your permission mode — you may have denied it earlier
- Some commands require explicit approval in default mode

---

## Level 3: Superpowers Plugin

*A skill library built on top of Claude Code. Adds structured workflows for planning, TDD, PR lifecycle, and more. Best for: developers who want repeatable, disciplined AI-assisted development.*

### What It Is

The Superpowers plugin is a collection of skills — structured workflow prompts — that load on demand into Claude Code. Where vanilla Claude Code gives you tools, Superpowers gives you processes.

**Key difference from plain Claude Code:**
- Skills use **progressive disclosure** — only the skill name and trigger description are always in context
- Full skill content loads only when invoked — saves context window space
- Skills encode best practices so you don't have to remember them

---

### Installation

```bash
# Install the plugin
claude mcp add superpowers

# Verify skills are available
# In a Claude Code session, type /
# You should see skills listed alongside built-in commands
```

After installation, Claude Code automatically checks for applicable skills at the start of each session and before major actions.

---

### Skill Library Overview

| Skill | Trigger | What it does |
|-------|---------|-------------|
| `brainstorming` | Before building anything new | Explores requirements, proposes 2-3 approaches, writes a spec before any code |
| `test-driven-development` | Before implementing a feature or fix | Red/green/refactor loop with explicit test-first discipline |
| `writing-plans` | After brainstorming, before coding | Turns a spec into a phased implementation plan |
| `executing-plans` | When you have a written plan | Executes the plan with review checkpoints between phases |
| `systematic-debugging` | When a bug or test failure occurs | Hypothesis-driven debugging before proposing fixes |
| `pr-desc` | Before creating a PR | Generates a structured PR description from the diff |
| `pr-review` | After implementing changes | Reviews the diff for correctness, coverage, and scope |
| `requesting-code-review` | Before merging | Pre-merge checklist and review preparation |
| `receiving-code-review` | When reviewer feedback arrives | Structured processing of feedback — technical rigor, not performative agreement |
| `personal-coach` | Workplace or communication situations | Coaching for decisions, drafts, conflict navigation |
| `verification-before-completion` | Before claiming work is done | Forces evidence (test output, diff review) before any success claim |
| `finishing-a-development-branch` | When implementation is complete | Options for merge, PR, or cleanup — guides to the right next step |

---

### Key Skills Walkthrough

#### brainstorming
**When:** Any time you're about to build something new — feature, component, config change.

**What it does:**
1. Explores project context (reads files, recent commits)
2. Asks clarifying questions one at a time
3. Proposes 2-3 approaches with trade-offs
4. Presents a design section by section for approval
5. Writes a spec doc to `docs/superpowers/specs/YYYY-MM-DD-topic-design.md`
6. Hands off to `writing-plans`

**Trigger:**
```
Let's build a caching layer for the user profile service
```
Claude Code recognizes new feature work and invokes brainstorming automatically — or you can invoke it directly:
```
/brainstorming
```

---

#### test-driven-development
**When:** Before writing any implementation code for a feature or bug fix.

**The loop:**
1. Write a failing test for the smallest next behavior
2. Run it — confirm it fails for the right reason
3. Write the minimum code to make it pass
4. Run it — confirm green
5. Refactor if needed
6. Repeat

**Why it matters:** Forces you to define the contract before the implementation. Claude Code generates tests that actually test behavior, not just coverage numbers.

---

#### writing-plans + executing-plans
**When:** For any multi-step implementation.

**writing-plans:**
- Takes a spec or requirement
- Produces a phased plan: each phase is a shippable PR
- Identifies dependencies between phases
- Flags risky steps

**executing-plans:**
- Works through the plan one phase at a time
- Stops at each phase boundary for review before continuing
- Multi-phase plans: complete one phase, show a summary, wait for confirmation before the next

**Pro tip:** Use Opus 4.6 for `writing-plans` (complex reasoning), then switch to Sonnet 4.6 for `executing-plans` (faster execution).

---

#### pr-desc + pr-review
**When:** At the end of any implementation before raising a PR.

**pr-desc:**
Generates a structured PR description from the current diff:
- Summary (what changed and why)
- Changes (file-level breakdown)
- Testing (what was verified)
- Notes for reviewers

**pr-review:**
Reviews the diff before you submit — catches scope creep, missing tests, unintended changes, and security issues. Think of it as a self-review pass with a second set of eyes.

**Typical workflow:**
```
1. Implementation complete
2. /pr-review   → fix any issues found
3. /pr-desc     → generate description
4. Create PR
```

---

#### personal-coach
**When:** Any workplace, communication, or career situation — not just code.

**What it handles:**
- Drafting a Slack message or email in a specific tone
- Navigating a difficult conversation or conflict
- Making a career decision
- Analyzing someone's behavior ("what do you make of X's response?")
- Post-event debriefs to track patterns

**3-variant draft format:**
- **Variant A** — direct, no hedging
- **Variant B** — same substance, softer framing
- **Variant C** — blunt, minimum words

---

### Writing Your Own Skill

Skills live in `~/.claude/skills/<skill-name>/SKILL.md`.

**Minimal skill structure:**
```markdown
---
name: my-skill
description: Use when X happens — triggers on phrases like "Y" and "Z"
---

## What This Skill Does

[Instructions for Claude to follow when this skill is invoked]

## Steps
1. First do this
2. Then do this
3. Finally do this
```

**Rigid vs flexible skills:**
- **Rigid** (like TDD, debugging) — follow exactly, no adaptation
- **Flexible** (like patterns, style guides) — adapt principles to context
- State which type your skill is inside the SKILL.md

**Trigger description matters:** Claude uses the `description` field to decide when to auto-invoke. Make it specific — include the exact phrases that should trigger the skill.

---

### MEMORY.md — Persistent Memory Across Sessions

Claude Code doesn't remember previous sessions by default. The MEMORY.md pattern solves this.

**How it works:**
- Claude writes important context to `~/.claude/projects/<project>/memory/MEMORY.md`
- At session start, Claude reads this file automatically
- Learnings, patterns, and decisions persist across sessions

**What to save in MEMORY.md:**
- Stable conventions confirmed across multiple interactions
- Key architectural decisions and important file paths
- Reviewer patterns and PR conventions
- Solutions to recurring problems

**What NOT to save:**
- Session-specific task state
- Speculative conclusions from a single interaction
- Anything that duplicates CLAUDE.md

**Repo-specific memories:**
For project-specific patterns, save to a dedicated file and link from MEMORY.md:
```markdown
## Key Files
- `debugging.md` — recurring failure modes and fixes
- `reviewer-patterns.md` — what each reviewer focuses on
```

---

## Level 4: Claude API

*Direct programmatic access to Claude. Best for: building products, automations, pipelines, and anything that needs Claude as a component rather than an assistant.*

### When to Use the API vs Claude Code

| Use Claude Code | Use the API |
|----------------|-------------|
| Your own development workflow | Building a product for others |
| Interactive coding sessions | Automations and pipelines |
| PR and code review workflows | Custom integrations |
| You are the user | Your users are the users |

The API is not an upgrade from Claude Code — it's a different tool for a different purpose.

---

### Setup

**Python:**
```bash
pip install anthropic
export ANTHROPIC_API_KEY=your-key-here
```

```python
import anthropic

client = anthropic.Anthropic()

message = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[
        {"role": "user", "content": "Explain dependency injection in one paragraph."}
    ]
)
print(message.content[0].text)
```

**TypeScript:**
```bash
npm install @anthropic-ai/sdk
```

```typescript
import Anthropic from "@anthropic-ai/sdk";

const client = new Anthropic();

const message = await client.messages.create({
  model: "claude-sonnet-4-6",
  max_tokens: 1024,
  messages: [
    { role: "user", content: "Explain dependency injection in one paragraph." }
  ],
});
console.log(message.content[0].text);
```

---

### Model Selection

| Model ID | Use When |
|----------|---------|
| `claude-haiku-4-5-20251001` | High volume, low latency, simple tasks |
| `claude-sonnet-4-6` | Most production use cases |
| `claude-opus-4-6` | Complex reasoning, high-stakes outputs |

---

### Core Patterns

**System prompt:**
```python
client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    system="You are a code reviewer. Focus on correctness and security. Be concise.",
    messages=[{"role": "user", "content": diff_content}]
)
```

**Multi-turn conversation:**
```python
conversation = []

def chat(user_message):
    conversation.append({"role": "user", "content": user_message})
    response = client.messages.create(
        model="claude-sonnet-4-6",
        max_tokens=1024,
        messages=conversation
    )
    assistant_message = response.content[0].text
    conversation.append({"role": "assistant", "content": assistant_message})
    return assistant_message
```

**Streaming (for real-time output):**
```python
with client.messages.stream(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Write a haiku about APIs."}]
) as stream:
    for text in stream.text_stream:
        print(text, end="", flush=True)
```

---

### Context Strategies

**Prompt caching** — reduce cost on repeated system prompts:
```python
client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    system=[
        {
            "type": "text",
            "text": very_long_system_prompt,
            "cache_control": {"type": "ephemeral"}
        }
    ],
    messages=[{"role": "user", "content": user_message}]
)
```
Cache hits cost ~10% of normal input token price. Use when the same large system prompt repeats across many calls.

**Structuring long context efficiently:**
- Put stable, reusable content first (system prompt, reference docs)
- Put variable content last (user message, current task)
- Remove content that isn't needed for the current call — don't pass the entire conversation history when only the last 3 turns matter

---

### When to Go Further

- **Claude Agent SDK** — for multi-agent systems where Claude agents coordinate with each other
- **Tool use / function calling** — give Claude structured tools to call (search, database queries, APIs)
- **Batch API** — process large volumes of requests at 50% cost
- **Files API** — upload documents once, reference them across many calls

See the [Anthropic documentation](https://docs.anthropic.com) for full coverage of these features.

---

## Quick Reference Card

### Claude Code Slash Commands
```
/help          List commands and settings
/clear         Clear conversation history
/compact       Summarize to free context
/cost          Show token usage
/model         Switch model
/init          Generate CLAUDE.md for current project
/review        Review recent changes
/commit        AI-generated commit message
/doctor        Health check and diagnostics
```

### Context Addition (Claude Code)
```
@filename.java          Add specific file
@src/main/java/         Add directory
```

### CLAUDE.md Locations
```
~/.claude/CLAUDE.md           Global (all repos)
<repo-root>/CLAUDE.md         Project (committed to source control)
```

### Model IDs (API)
```
claude-haiku-4-5-20251001     Fast, cheap
claude-sonnet-4-6              Balanced (default)
claude-opus-4-6                Most capable
```

### Superpowers Key Skills
```
/brainstorming                 Design before code
/test-driven-development       TDD loop
/writing-plans                 Spec → phased plan
/executing-plans               Work through a plan
/pr-desc                       Generate PR description
/pr-review                     Review before submitting
/systematic-debugging          Debug with hypotheses
/personal-coach                Workplace + communication
```

### Support
```
Claude Code issues:   github.com/anthropics/claude-code/issues
Anthropic API docs:   docs.anthropic.com
Claude.ai help:       claude.ai/help
```

---

## Learning Path

### Week 1: Claude.ai Fundamentals
- [ ] Create a claude.ai account
- [ ] Try a plain chat: ask a coding question about your stack
- [ ] Create a Project with a system prompt for your main codebase
- [ ] Upload a reference document to a Project
- [ ] Use an Artifact: ask Claude to generate a code snippet and iterate on it
- [ ] Try file upload: paste a PDF or screenshot and ask Claude about it

### Week 2: Claude Code Basics
- [ ] Install Claude Code (`npm install -g @anthropic-ai/claude-code`)
- [ ] Authenticate and run your first session
- [ ] Run `/init` to generate a starter CLAUDE.md
- [ ] Edit CLAUDE.md to add your real project conventions
- [ ] Use `@filename` to add a file to context
- [ ] Try `/compact` when the session gets long
- [ ] Use `/commit` to generate a commit message

### Week 3: Claude Code Advanced + Superpowers
- [ ] Install the Superpowers plugin
- [ ] Use `/brainstorming` for a real feature before writing code
- [ ] Try `/test-driven-development` for one bug fix or small feature
- [ ] Generate a PR description with `/pr-desc`
- [ ] Run `/pr-review` before submitting a PR
- [ ] Connect one MCP (GitHub or Atlassian)
- [ ] Write your first custom skill

### Week 4: API + Mastery
- [ ] Set up the Anthropic Python or TypeScript SDK
- [ ] Make your first API call with a system prompt
- [ ] Build a simple multi-turn conversation loop
- [ ] Try streaming output
- [ ] Experiment with prompt caching on a repeated system prompt
- [ ] Identify one workflow in your team that could be automated with the API

---

## Troubleshooting

### Claude.ai

**Hallucinating facts or API names**
- Verify against primary sources — Claude is confident even when wrong on specifics
- Ask: *"Are you certain about this? What's your confidence level?"*
- For version-specific info, paste the official docs directly into context

**Responses getting worse mid-conversation**
- Context has drifted — start a new conversation
- If you need continuity, ask Claude to summarize the key context and paste it into a new chat

**Project system prompt being ignored**
- Check for contradictions between the system prompt and your in-chat message
- System prompts apply globally — a very long one may be getting truncated

---

### Claude Code

**Claude making unasked-for changes**
- Add to CLAUDE.md: *"Only modify files directly related to the current task. Ask before touching anything else."*
- Be explicit about scope in your prompt

**Context window filling up**
- Run `/compact` proactively (at ~60-70% full, not 100%)
- Start a new session for each new task

**MCP not connecting**
- Check `~/.claude/settings.json` for JSON syntax errors
- Verify the auth token is current
- Run `/doctor` for diagnostic output

**Tool call keeps getting denied**
- Reassess whether the action is necessary
- If it is, approve it explicitly when prompted

---

### Superpowers

**Skill not being auto-invoked**
- The trigger description in the skill didn't match — try invoking manually: `/skill-name`
- Check that the plugin is installed: `/help` should list superpowers skills

**MEMORY.md not loading**
- Verify the file is at the correct path: `~/.claude/projects/<project-hash>/memory/MEMORY.md`
- Check CLAUDE.md for instructions to read MEMORY.md at session start

---

### Claude API

**Rate limit errors**
- Implement exponential backoff: wait 1s, 2s, 4s, 8s between retries
- Check your tier limits in the Anthropic console

**Responses cut off mid-output**
- Increase `max_tokens` — the response hit the limit
- For long outputs, use streaming so partial output is still usable

**Inconsistent responses across calls**
- Temperature defaults to 1 — set to 0 for deterministic outputs
- System prompt drift: ensure the system prompt is identical across calls

---

## Resources

- **Claude.ai**: claude.ai
- **Claude Code documentation**: docs.anthropic.com/claude-code
- **Anthropic API documentation**: docs.anthropic.com
- **Claude Code GitHub (issues + releases)**: github.com/anthropics/claude-code
- **MCP directory**: modelcontextprotocol.io
- **Anthropic cookbook (API examples)**: github.com/anthropics/anthropic-cookbook
- **Superpowers plugin**: see your team's internal documentation

---

*This guide covers Claude Code and Claude.ai as of April 2026. Claude models and features evolve rapidly — check the Anthropic changelog for updates.*

---

*Companion guide: see `Cursor-AI-Learning-Guide.md` for the equivalent guide for Cursor IDE.*
