---
name: ai-ready-setup
description: Use when setting up a new device or environment with the user's personal AI workspace. Triggers on "/ai-ready-setup" or "make this device ai ready" or "set up my ai folder".
---

# AI Ready Setup

Sets up the AI workspace directory with learning guides and a reusable template structure.
The `templates/` folder is a blueprint — copy `templates/username/` to `$AI_BASE/<yourname>/` when onboarding a real user.

**Supported platforms:** macOS, Windows (Git Bash / WSL), Linux

## What Gets Created

```
~/Desktop/ai/
├── learning-guides/
│   ├── Claude-AI-Learning-Guide.md
│   ├── Claude-Professional-OS-Guide.md
│   └── Cursor-AI-Learning-Guide.md
└── templates/
    ├── PERSONA_USERNAME_GLOBAL.md
    ├── MEMORY_USERNAME_GLOBAL.md
    └── username/
        ├── insights/
        ├── learnings/
        ├── personas/
        ├── plans/
        ├── commands/
        ├── trackers/
        └── evolution/
```

---

## Step 1 — Detect OS and resolve base directory

```bash
OS_TYPE=$(uname -s 2>/dev/null || echo "Windows")

case "$OS_TYPE" in
  Darwin)
    # macOS
    AI_BASE=~/Desktop/ai
    ;;
  MINGW*|MSYS*|CYGWIN*)
    # Windows — Git Bash or Cygwin; ~/Desktop maps to C:\Users\<you>\Desktop
    AI_BASE=~/Desktop/ai
    ;;
  Linux)
    # WSL (Windows Subsystem for Linux) or native Linux
    if grep -qi microsoft /proc/version 2>/dev/null; then
      # WSL — use the Windows Desktop via /mnt/c
      WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
      AI_BASE=/mnt/c/Users/$WIN_USER/Desktop/ai
    elif [ -d ~/Desktop ]; then
      AI_BASE=~/Desktop/ai
    else
      AI_BASE=~/ai
    fi
    ;;
  Windows)
    # PowerShell fallback (uname not available)
    AI_BASE=~/Desktop/ai
    ;;
esac

echo "Platform: $OS_TYPE"
echo "AI base directory: $AI_BASE"
```

Use `$AI_BASE` for all subsequent paths.

---

## Step 2 — Create directory structure

```bash
mkdir -p $AI_BASE/learning-guides
mkdir -p $AI_BASE/templates/username/insights
mkdir -p $AI_BASE/templates/username/learnings
mkdir -p $AI_BASE/templates/username/personas
mkdir -p $AI_BASE/templates/username/plans
mkdir -p $AI_BASE/templates/username/commands
mkdir -p $AI_BASE/templates/username/trackers
mkdir -p $AI_BASE/templates/username/evolution
```

Add `.gitkeep` to each empty subdirectory so the structure survives a git commit:

```bash
for dir in insights learnings personas plans commands trackers evolution; do
  touch $AI_BASE/templates/username/$dir/.gitkeep
done
```

---

## Step 3 — Copy learning guides

**Check if the paridas-bootstrap repo was cloned first** (guides will be right there):
```bash
REPO_DIR=""

# Check if this skill is running from within the cloned repo
SKILL_DIR="$(dirname "$0")"
if [ -f "$SKILL_DIR/../../../learning-guides/Claude-AI-Learning-Guide.md" ]; then
  REPO_DIR="$(cd "$SKILL_DIR/../../.." && pwd)"
fi

# If not found via skill path, search common locations
if [ -z "$REPO_DIR" ]; then
  SEARCH_PATHS="$HOME/Desktop $HOME/Documents $HOME/Dev $HOME/workspace $HOME/code $HOME/ai"
  [ -d /mnt/c/Users ] && SEARCH_PATHS="$SEARCH_PATHS $(ls -d /mnt/c/Users/*/Desktop /mnt/c/Users/*/Documents 2>/dev/null)"
  GUIDE_PATH=$(find $SEARCH_PATHS -maxdepth 5 -name "Claude-AI-Learning-Guide.md" 2>/dev/null | head -1)
  [ -n "$GUIDE_PATH" ] && REPO_DIR=$(dirname "$GUIDE_PATH")
fi
```

**If `$REPO_DIR` is set:**
```bash
cp "$REPO_DIR/learning-guides/"*.md $AI_BASE/learning-guides/
```

**If `$REPO_DIR` is empty:** create `$AI_BASE/learning-guides/README.md`:
```markdown
# Learning Guides

Clone the paridas-bootstrap repo and re-run, or place these files here manually:
- Claude-AI-Learning-Guide.md
- Claude-Professional-OS-Guide.md
- Cursor-AI-Learning-Guide.md
```

---

## Step 4 — Create PERSONA_USERNAME_GLOBAL.md

**If `$REPO_DIR` is set**, copy and personalise from the repo template:
```bash
sed "s/<yourname>/$YOURNAME/g; s/USERNAME/$YOURNAME/g" \
  "$REPO_DIR/templates/PERSONA_USERNAME_GLOBAL.md" \
  > $AI_BASE/templates/PERSONA_USERNAME_GLOBAL.md
```

**If `$REPO_DIR` is empty**, write inline to `$AI_BASE/templates/PERSONA_USERNAME_GLOBAL.md`:

```markdown
# Persona: USERNAME — Communication Voice and Working Style

## Overview
[One paragraph describing this person's professional context, role, and primary objectives.]

## Communication Style
- **Tone:** [e.g. direct, precise, no hedging, softer framing]
- **Default register:** [e.g. professional but collegial]
- **Lead with:** [e.g. the point first, no preamble]
- **Avoid:** [e.g. over-offering information, prompting action from recipients]

<!-- Optional sections for software engineers — remove if not applicable -->

## As a Reviewer
- **What I flag:** [recurring things I catch and comment on]
- **Comment style:** [e.g. file:line first, one sentence, technically precise]
- **Approval pattern:** [when I approve vs request changes]

## As a PR Author
- **PR description structure:** [level of detail, sections always included]
- **How I respond to feedback:** [e.g. one evidence-backed response then stop]

<!-- End optional sections -->

## Strengths to Preserve
- [What's working well — don't change these]

## Gaps to Watch
- [Recurring patterns that need attention]

## Current Phase
[Current professional focus or development stage]

---
*Last updated: YYYY-MM-DD*
```

---

## Step 5 — Create MEMORY_USERNAME_GLOBAL.md

**If `$REPO_DIR` is set**, copy and personalise from the repo template:
```bash
sed "s/<yourname>/$YOURNAME/g; s/USERNAME/$YOURNAME/g" \
  "$REPO_DIR/templates/MEMORY_USERNAME_GLOBAL.md" \
  > $AI_BASE/templates/MEMORY_USERNAME_GLOBAL.md
```

**If `$REPO_DIR` is empty**, write inline to `$AI_BASE/templates/MEMORY_USERNAME_GLOBAL.md`:

```markdown
# Session Memory — Global (USERNAME)

## Last Updated
YYYY-MM-DD

---

## File Map

<!-- Replace <yourname> with your actual username throughout this file -->

| Path | Purpose | Naming Convention |
|------|---------|-------------------|
| `~/Desktop/ai/<yourname>/PERSONA_<yourname>_GLOBAL.md` | Primary lens: communication voice, working style, team navigation | — |
| `~/Desktop/ai/<yourname>/MEMORY_<yourname>_GLOBAL.md` | Session memory, file map, custom commands, CLAUDE.md reference | — |
| `~/Desktop/ai/<yourname>/learnings/` | Personal case library | `YYYY-MM-DD-person-type.md` |
| `~/Desktop/ai/<yourname>/insights/` | Insights reports only | `YYYY-MM-DD-insights-report.md` |
| `~/Desktop/ai/<yourname>/personas/` | Persona files for named individuals | `PERSONA_NAME.md` |
| `~/Desktop/ai/<yourname>/plans/` | Implementation and strategy plans | — |
| `~/Desktop/ai/<yourname>/commands/` | Custom commands built over time | — |
| `~/Desktop/ai/<yourname>/trackers/` | Ongoing trackers (sprints, goals, metrics) | — |
| `~/Desktop/ai/<repo-name>/` | Repo-specific plans, review and implement instructions | — |

---

## Folder Guide

### insights/
**Purpose:** Periodic AI usage analysis — what's working, friction patterns, feature suggestions.
**Naming:** `YYYY-MM-DD-insights-report.md`
**Source:** Output from `/insights` command in Claude Code. One file per report run.

### learnings/
**Purpose:** Living learning record for a goal — created at any point during execution, not just on completion. Captures incremental observations as they happen, and is finalised when the tracker closes. Every entry covers four dimensions: what went well, what held good, what was the gap, what can be done better. Also used for ad-hoc debriefs on situations, decisions, or interactions.
**Naming:** `YYYY-MM-DD-[goal-or-usecase]-learnings.md` (mirrors plan/tracker name) or `YYYY-MM-DD-[learning-pattern-name]-[type].md` for ad-hoc entries
**Types (ad-hoc):** `debrief` · `decision` · `conflict` · `career`
**Example:** `2026-04-01-oidc-consent-flow-learnings.md` · `2026-04-18-difficult-conversation-debrief.md`

### personas/
**Purpose:** Role-based personas Claude can embody — each defines a distinct voice, style, and set of nuances the user wants applied. The same user can invoke multiple personas for different contexts (coaching, creative work, debate, professional comms).
**Naming:** `PERSONA_[ROLE].md`
**Example:** `PERSONA_MOM.md` · `PERSONA_DEBATE-COACH.md` · `PERSONA_CHEF.md`
**Usage:** Invoke by name in a session — Claude loads the file and applies that persona's style throughout.

### plans/
**Purpose:** Living planning documents for a definitive goal or usecase — created before execution begins and updated throughout. Captures phases, pivots, notes, and strategies as the goal evolves. One plan per goal; the single source of truth for all planning decisions around it.
**Naming:** `YYYY-MM-DD-[goal-or-usecase]-plan.md`
**Example:** `2026-04-01-oidc-consent-flow-plan.md` · `2026-04-15-career-strategy-q2-plan.md`

### commands/
**Purpose:** Custom commands the user builds over time — one file per command, invoked as a slash command in Claude.
**Naming:** `[command-name].md`
**Example:** `articulate.md` · `summarise.md` · `personal-coach.md`

### trackers/
**Purpose:** Progress tracking for active plans — one tracker per plan, created when execution begins. Records status, decisions made, blockers, and outcomes against the plan's goals.
**Naming:** `YYYY-MM-DD-[goal-or-usecase]-tracker.md` (mirrors the corresponding plan file name)
**Example:** `2026-04-01-oidc-consent-flow-tracker.md` · `2026-04-15-career-strategy-q2-tracker.md`

---

## Active Projects

| Project | Repo | Status | Notes |
|---------|------|--------|-------|
| | | | |

---

## Key People

| Person | Role | Persona File | Notes |
|--------|------|-------------|-------|
| | | | |

---

## Known Repos

| Repo | Plans Path |
|------|-----------|
| [repo-name] | `~/Desktop/ai/[repo-name]/` |

---

## Cross-Repo Patterns (confirmed 2+ repos)

- [Pattern]: [what's confirmed and reliable]

---

## Custom Commands

**Development workflow**
- `/writing-plans` — produce a durable plan file in `plans/` before any implementation begins
- `/analyze-code-flow` — trace a named feature end-to-end through the codebase

**Session management**
- `/session-close` — end-of-session wrap: update-plans → sync-plans → prompt for learnings capture
- `/update-plans` — update repo-specific plan files with session learnings (trigger: code reviewed, PR raised, patterns found)
- `/sync-plans` — re-synthesise global files in `~/Desktop/ai/<yourname>/` from all repo sources

**Communication and coaching**
- `/personal-coach` — structured coaching for workplace, career, or communication situations
- `/debrief` — post-event debrief: extract patterns → update persona/learnings files
- `/analyze-person <name>` — load persona file for named individual, run behavioral analysis
- `/suggest-response` — paste a Slack message, PR comment, or thread; get a suggested response
- `/summarize-thread` — structured context summary of any Slack/PR/Jira thread
- `/rephrase tone: <descriptor>` — rephrase a draft; produces 2-3 variants; tone specified inline

---

## MCP Servers (add as configured)

<!-- Format:
### [Service Name] (configured YYYY-MM-DD)
- **MCP server**: [URL or command]
- **Auth**: [how to authenticate]
- **Register**: `claude mcp add ...`
- **Tools exposed**: [list of tool names]
-->

---

## Tooling (add as installed)

<!-- Format:
### [Tool Name] (installed YYYY-MM-DD)
- **Install**: [install command]
- **Auth**: [auth steps]
- **Common usage**: [example commands]
-->

---

## What NOT to Save Here

- Session-specific task state
- In-progress work details
- Speculative conclusions from a single session
- Anything that duplicates CLAUDE.md

---

## CLAUDE.md Starter Template

Copy the block below into `~/.claude/CLAUDE.md` on any new device.
Replace every `<yourname>` with your actual username.
Sections marked `CUSTOMIZE` need your own values filled in.

---

### Session Start

    At the start of every session:
    1. Read `~/Desktop/ai/<yourname>/MEMORY_<yourname>_GLOBAL.md` and follow the instructions there.
    2. Determine the current repo name from the working directory. If a file exists at
       `~/Desktop/ai/<yourname>/<repo-name>/MEMORY.md`, read it and follow those too.
    3. Read all relevant persona, plan, and instruction files from `~/Desktop/ai/<yourname>/`
       and any files in the current repo's `.claude/` directory.
    4. Confirm which persona and plan files you've loaded before proceeding with any task.

### Session Close — Learnings Capture

    At the end of any session with 5+ messages, proactively ask:
    "Should I update relevant files under ~/Desktop/ai/<yourname>/ with learnings so far?"

### Goal Completion — Learnings and Persona Update

    When a tracker file is marked complete:
    1. Create the corresponding learnings file in `learnings/`
    2. Identify which persona files are referenced and what should change
    3. Present a summary of proposed additions or corrections to each persona file
    4. Wait for explicit confirmation before writing any changes to persona or memory files
    Never update PERSONA or MEMORY files without showing the proposed changes and receiving approval first.

### After a Plan Is Created

    After any implementation plan is created, proceed in this order without prompting:
    1. Implement the plan
    2. Review the resulting changes before finalizing
    Multi-phase plans: stop after each phase, show a summary, wait for confirmation.

### PR Reviews

    When reviewing any PR:
    - Show file/line references FIRST, then summary — never lead with a summary
    - Rephrase all comments to match my persona tone: concise, technically precise, restrained
    - Never over-offer information or prompt action from the recipient
    - Read persona files before forming any opinion on a reviewer's comment

### Persona-Aware Responses

    Whenever a named individual is mentioned (Slack drafts, PR reviews, coaching, meeting prep),
    read ~/Desktop/ai/<yourname>/personas/PERSONA_<NAME>.md before responding.
    Apply their known operating style before producing any output.
    [CUSTOMIZE: list priority personas and their file paths here]

### Writing and Communication Style

    - Short draft first — expand only if asked
    - No preamble, no pleasantries — lead with the point
    - Match the weight of the original — a one-line message gets a one-line reply
    - Don't over-offer information or prompt action from the recipient

### Communication Analysis

    When analyzing interpersonal dynamics (PR threads, Slack, meetings):
    - Do NOT assume roles or intent — ask if ambiguous
    - Never frame deliberate strategic behavior as a gap or mistake
    - Name the most plausible driver, support with evidence, state practical implications

### File Handling

    - Global AI files live in ~/Desktop/ai/<yourname>/ with repo-specific subfolders
    - Repo-specific first — write to ~/Desktop/ai/<yourname>/<repo-name>/ for repo context
    - Global only for cross-repo patterns (confirmed across 2+ repos)
    - Use simple folder names — no nested org paths
    - Verify the target path exists before writing any file
    - When in doubt about scope, ask before writing

### Git Operations

    - Only make local file changes unless explicitly asked for commits or pushes
    - Never git commit unless explicitly asked
    - Never push to main/master under any circumstances

### Broad Operations — Propose Before Execute

    Before executing any of the following, state the approach and wait for confirmation:
    - Dependency or version upgrades
    - Multi-file refactors affecting more than 3 files
    - Changes to shared infrastructure (config files, settings)
    - Branch or worktree creation

### Task Switching

    When interrupted mid-task with a new instruction, switch immediately without finishing
    the previous task. Resume only if explicitly asked.

### Build & Lint
    [CUSTOMIZE: fill in your stack]
    - Build tool: [e.g. Maven / Gradle / npm / cargo]
    - Format command: [e.g. mvn ktlint:format / npm run lint:fix]
    - Field ordering rules: [e.g. alphabetize GraphQL fields]
```

---

## Step 6 — Confirm and report

Print a summary:

```
AI workspace ready at $AI_BASE

  learning-guides/
    ✓ Claude-AI-Learning-Guide.md        [copied / placeholder — see README]
    ✓ Claude-Professional-OS-Guide.md    [copied / placeholder — see README]
    ✓ Cursor-AI-Learning-Guide.md        [copied / placeholder — see README]

  templates/
    ✓ PERSONA_USERNAME_GLOBAL.md
    ✓ MEMORY_USERNAME_GLOBAL.md
    └── username/
        ✓ insights/    (.gitkeep)
        ✓ learnings/   (.gitkeep)
        ✓ personas/    (.gitkeep)
        ✓ plans/       (.gitkeep)
        ✓ commands/    (.gitkeep)
        ✓ trackers/    (.gitkeep)
        ✓ evolution/   (.gitkeep)

To onboard yourself or a new user:
  1. Copy templates/username/          →  $AI_BASE/<yourname>/
  2. Copy PERSONA_USERNAME_GLOBAL.md   →  $AI_BASE/<yourname>/PERSONA_<yourname>_GLOBAL.md
     Fill in your communication style, reviewer patterns, and working style
  3. Copy MEMORY_USERNAME_GLOBAL.md    →  $AI_BASE/<yourname>/MEMORY_<yourname>_GLOBAL.md
     Replace all <yourname> placeholders with your actual name throughout
  4. Add to ~/.claude/CLAUDE.md under the session-start block:

     At the start of every session:
     1. Read `$AI_BASE/<yourname>/MEMORY_<yourname>_GLOBAL.md` and follow the instructions there.
     2. Determine the current repo name from the working directory. If a file exists at
        `$AI_BASE/<yourname>/<repo-name>/MEMORY.md`, read it and follow those instructions too.
```
