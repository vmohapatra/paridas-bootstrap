---
name: ai-ready-setup
description: Use when setting up a new device or environment with the user's personal AI workspace. Triggers on "/ai-ready-setup" or "make this device ai ready" or "set up my ai folder".
---

# AI Ready Setup

Sets up a personal AI workspace by running the paridas-bootstrap setup script.
This skill is the Claude Code entry point — it requires the bootstrap repo to be cloned first.

**Supported platforms:** macOS, Windows (Git Bash / WSL), Linux

---

## Prerequisites

The paridas-bootstrap repo must be cloned locally before this skill runs:

```bash
git clone https://github.com/vmohapatra/paridas-bootstrap ~/Desktop/ai/paridas-bootstrap
```

If the repo is not found, instruct the user to clone it first and then re-run `/ai-ready-setup`.

---

## What This Skill Does

Delegates to `setup.sh` in the bootstrap repo. Do not reimplement the setup logic here —
`setup.sh` is the authoritative source. Run it and report the outcome.

---

## Step 1 — Locate the bootstrap repo

```bash
REPO_DIR=~/Desktop/ai/paridas-bootstrap

if [ ! -d "$REPO_DIR" ]; then
  echo "Bootstrap repo not found at $REPO_DIR"
  echo "Clone it first: git clone https://github.com/vmohapatra/paridas-bootstrap $REPO_DIR"
  exit 1
fi
```

---

## Step 2 — Ask for username

Ask the user:
> "What username should I use for your workspace folder? (e.g. vijayaa, rparida)"

Store as `YOURNAME`.

---

## Step 3 — Run setup.sh

```bash
cd "$REPO_DIR"
chmod +x setup.sh
./setup.sh "$YOURNAME"
```

`setup.sh` will first display the data use notice from `CONSENT.md` — the user presses Enter to accept or Ctrl+C to exit. Then it handles everything:
- OS detection and AI_BASE resolution
- Directory structure creation under `~/Desktop/ai/<yourname>/`
- PERSONA, MEMORY, and CLAUDE.md file creation from templates
- `.bootstrap-source` marker written with repo origin and version
- Standalone `~/Desktop/ai/sync.sh` launcher installed
- Claude Code skill installation (skipped — already running)
- Persona creation kickoff (if Claude Code detected — it is, since this skill is running)

---

## Step 4 — Report outcome

After `setup.sh` completes, confirm:

```
Workspace created at ~/Desktop/ai/<yourname>/

  ├── PERSONA_<yourname>_GLOBAL.md    ← fill in your communication style
  ├── MEMORY_<yourname>_GLOBAL.md     ← replace [placeholders] with your values
  ├── commands/                       ← create-persona, create-plan, create-tracker, articulate, visualize-evolution, evolve-global-persona, contribute-to-bootstrap
  ├── personas/                       ← PERSONA_DEBATE-COACH.md and PERSONA_MANDARIN-TEACHER.md as examples
  ├── plans/
  ├── projects/
  ├── trackers/
  ├── learnings/
  ├── insights/
  └── evolution/

~/.claude/CLAUDE.md                   ← review [CUSTOMIZE] sections for your stack
~/Desktop/ai/sync.sh                  ← run this any time to keep your workspace current
```

---

## Keeping the workspace current

After initial setup, the user keeps their workspace current with two commands:

```bash
# 1. Pull latest bootstrap from GitHub
cd ~/Desktop/ai/paridas-bootstrap && ./update.sh

# 2. Sync updated files into workspace
~/Desktop/ai/sync.sh <yourname>
```

The standalone `sync.sh` launcher works even if the bootstrap repo is later deleted —
it re-clones automatically before syncing.

---

## Available commands (in Claude Code sessions)

Once set up, the user can invoke these in any Claude Code session:

| Command | What it does |
|---------|-------------|
| `/create-persona` | Structured Q&A → writes a role-based persona file |
| `/create-plan` | Intake → generates a phased plan in `plans/` |
| `/create-tracker` | Reads a plan → generates a matching tracker in `trackers/` |
| `/articulate` | Rough input → short + full clean written versions |
| `/visualize-evolution` | Reads trackers and evolution files → HTML progress dashboard |
| `/evolve-global-persona` | Reads all role personas → proposes global persona updates |
| `/contribute-to-bootstrap` | Generalizes new workspace commands/personas and opens a draft PR back to bootstrap |
