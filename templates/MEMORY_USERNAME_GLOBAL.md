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
| `~/Desktop/ai/<yourname>/evolution/` | Evolution history for each persona file | `EVOLUTION_[NAME].md` |
| `~/Desktop/ai/<repo-name>/` | Repo-specific plans, review and implement instructions | — |

---

## Folder Guide

### insights/
**Purpose:** Periodic AI usage analysis — what's working, friction patterns, feature suggestions.
**Naming:** `YYYY-MM-DD-insights-report.md` (written notes) · `YYYY-MM-DD-insights-report.html` (visual report)
**Source:** Run `/insights` in Claude Code. Copy the generated HTML from `~/.claude/usage-data/report.html` to this folder with the dated name. Save a companion `.md` for written observations and action items. One pair of files per report run.

### learnings/
**Purpose:** Living learning record for a goal — created at any point during execution, not just on completion. Captures incremental observations as they happen, and is finalised when the tracker closes. Every entry covers four dimensions: what went well, what held good, what was the gap, what can be done better. Also used for ad-hoc debriefs on situations, decisions, or interactions.
**Naming:** `YYYY-MM-DD-[goal-or-usecase]-learnings.md` (mirrors plan/tracker name) or `YYYY-MM-DD-[learning-pattern-name]-[type].md` for ad-hoc entries
**Types (ad-hoc):** `debrief` · `decision` · `conflict` · `career`
**Example:** `2026-04-01-oidc-consent-flow-learnings.md` · `2026-04-18-difficult-conversation-debrief.md`
**Closing section:** Every finalised learnings file ends with an **Optimised Prompt** section — Claude analyses the full session and suggests the most efficient prompt for this goal type: minimal tokens, right context front-loaded, output scope bounded. Reuse it next time the same goal type arises.

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

### evolution/
**Purpose:** Tracks how each persona file changes over time — both the global persona (`PERSONA_<yourname>_GLOBAL.md`) and any role-based personas (`PERSONA_[ROLE].md`). One file per persona. Each file contains a dated evolution log and periodic snapshots of the persona content, enabling retrospection on how your voice, gaps, and strategies have shifted.
**Naming:** `EVOLUTION_[NAME].md` — mirrors the persona filename without the `PERSONA_` prefix
**Example:** `EVOLUTION_<yourname>_GLOBAL.md` · `EVOLUTION_DEBATE-COACH.md` · `EVOLUTION_MOM.md`
**Created:** When a persona file is first substantively updated after initial setup. Updated whenever a persona file changes.

---

## Active Projects

| Project | Repo | Status | Notes |
|---------|------|--------|-------|
| | | | |
| | | | |

---

## Key People

| Person | Role | Persona File | Notes |
|--------|------|-------------|-------|
| | | | |
| | | | |

---

## Known Repos

| Repo | Plans Path |
|------|-----------|
| [repo-name] | `~/Desktop/ai/[repo-name]/` |
| | |

---

## Cross-Repo Patterns (confirmed 2+ repos)

- [Pattern]: [what's confirmed and reliable]

---

## Custom Commands

<!-- Add a row here whenever you create a new command file in commands/ -->

**Writing and communication**
- `/articulate` — rewrite any text with the main point first; produces Short and Full variants

**Reporting and visualisation**
- `/visualize-evolution` — generate an HTML dashboard from `trackers/` and `evolution/` files; saved as `YYYY-MM-DD-visual-report.html`

---

## MCP Servers (add as configured)

<!-- Document any MCP servers you connect to Claude Code here -->
<!-- Format:
### [Service Name] (configured YYYY-MM-DD)
- **MCP server**: [URL or command]
- **Auth**: [how to authenticate]
- **Register**: `claude mcp add ...`
- **Tools exposed**: [list of tool names]
-->

---

## Tooling (add as installed)

<!-- Document any CLI tools or dev utilities you use with Claude here -->
<!-- Format:
### [Tool Name] (installed YYYY-MM-DD)
- **Install**: [install command]
- **Auth**: [auth steps]
- **Common usage**: [example commands]
- **Full setup guide**: [path to guide file if exists]
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
    5. After confirmed persona changes are written, update the corresponding evolution file in `evolution/`:
       - Add a row to the Evolution Log table
       - Add a new dated snapshot if the changes are substantial
    6. Generate the Optimised Prompt section at the end of the learnings file:
       - Analyse the full session: goal, prompts used, correction rounds, token waste
       - Produce one ready-to-use prompt that front-loads context, omits what persona/memory files already cover, and scopes the output explicitly
       - Note what the original prompts got wrong and why the suggested prompt is more efficient
    Never update PERSONA, MEMORY, or evolution files without showing the proposed changes and receiving approval first.

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

---
*Last updated: YYYY-MM-DD*
