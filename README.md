# paridas-bootstrap

A portable AI workspace bootstrap — get a consistent, structured working environment
on any device in minutes.

> **Before running setup.sh, read [CONSENT.md](CONSENT.md).** Setup requires explicit agreement to the data use notice. If you do not agree, do not proceed.

---

## What this repo is

`paridas-bootstrap` provisions your personal AI workspace under `~/Desktop/ai/<yourname>/`.
It creates the directory layout, starter persona and memory files, a global `~/.claude/CLAUDE.md`,
and a library of commands and persona examples that Claude Code uses to maintain consistent
context about who you are and how you work — across every machine and every session.

Once set up, your workspace compounds over time: personas sharpen, plans and trackers capture
execution, learnings accumulate, and a global persona evolves from the roles you actually use.

---

## How it works

```
Clone bootstrap repo
        ↓
  ./setup.sh <name>          Creates workspace, writes sync launcher, kicks off persona creation
        ↓
  ~/Desktop/ai/sync.sh       Standalone launcher — keeps workspace current even if bootstrap repo is gone
        ↓
  Bootstrap pulls from GitHub → syncs files into workspace → creates workspace if missing
```

**Three scripts, three jobs:**

| Script | Job |
|--------|-----|
| `setup.sh` | One-time workspace creation |
| `update.sh` | Keep the bootstrap repo current with GitHub |
| `sync.sh` | Keep your workspace current with the bootstrap repo |

---

## First-time setup

```bash
git clone https://github.com/vmohapatra/paridas-bootstrap ~/Desktop/ai/paridas-bootstrap
cd ~/Desktop/ai/paridas-bootstrap
chmod +x setup.sh
./setup.sh <yourname>
```

Replace `<yourname>` with the name you want for your workspace folder (e.g. `vijayaa`, `rparida`).

**What setup does:**
1. Creates `~/Desktop/ai/<yourname>/` with the full directory structure
2. Copies and personalises PERSONA, MEMORY, and CLAUDE.md starter files
3. Writes a `.bootstrap-source` marker recording the repo origin and version
4. Installs a standalone `~/Desktop/ai/sync.sh` launcher (works even if the bootstrap repo is later deleted)
5. Installs the `ai-ready-setup` Claude Code skill if Claude Code is present
6. If Claude Code is installed — prompts for your first role and launches the persona creation workflow

---

## Keeping everything current

### Update the bootstrap repo

```bash
cd ~/Desktop/ai/paridas-bootstrap
./update.sh
```

Checks the remote VERSION, shows what commits have landed, and pulls on confirmation.

### Sync your workspace

```bash
~/Desktop/ai/sync.sh <yourname>
```

Copies all bootstrap-managed files (commands, persona examples, learning guides) into your workspace.
Your custom files — additional commands, personas you've built, plans, trackers — are never touched.
Your workspace is always a superset of what bootstrap provides.

**If the bootstrap repo is deleted locally:** the standalone launcher re-clones it automatically before syncing.

**If your workspace doesn't exist yet:** sync runs setup first, then syncs.

---

## What gets created

```
~/Desktop/ai/
├── sync.sh                             ← standalone sync launcher (created by setup.sh)
├── learning-guides/
│   ├── Claude-AI-Learning-Guide.md
│   ├── Claude-Professional-OS-Guide.md
│   └── Cursor-AI-Learning-Guide.md
└── <yourname>/
    ├── .bootstrap-source               ← repo origin, version, setup date
    ├── .bootstrap-version              ← last synced bootstrap version
    ├── PERSONA_<yourname>_GLOBAL.md    ← your global persona (fill in)
    ├── MEMORY_<yourname>_GLOBAL.md     ← session memory + file map (fill in)
    ├── insights/                       ← AI usage insights reports
    ├── learnings/                      ← session and goal learnings
    ├── personas/                       ← role-based personas
    ├── plans/                          ← activity logs (steps taken per goal, per persona)
    │   └── <persona-slug>/             ← e.g. debate-coach/
    │       └── PLAN_<topic-slug>.md
    ├── projects/                       ← deliverables (docs, HTML, analysis outputs)
    │   └── <persona-slug>/             ← e.g. debate-coach/
    │       └── <topic-slug>/           ← e.g. box-lunches-vs-school-lunches/
    │           └── DOMAIN_TYPE_topic.md
    ├── commands/                       ← commands (bootstrap + your own)
    ├── trackers/                       ← sprint, goal, and metric trackers
    └── evolution/                      ← persona change history over time

~/.claude/
└── CLAUDE.md                           ← global Claude Code instructions
```

---

## Commands

All commands live in `commands/` and are invoked inside a Claude Code session with `/command-name`.

| Command | What it does |
|---------|-------------|
| `/create-persona` | Structured Q&A intake → writes a role-based persona file |
| `/create-plan` | Intake → generates a phased plan file in `plans/` |
| `/create-tracker` | Reads a plan → generates a matching tracker in `trackers/` |
| `/articulate` | Takes rough input → produces short + full clean written versions |
| `/visualize-evolution` | Reads trackers and evolution files → generates an HTML progress dashboard |
| `/evolve-global-persona` | Reads all role personas → proposes updates to your global persona |
| `/contribute-to-bootstrap` | Discovers workspace improvements, generalizes them, and opens a draft PR back to bootstrap |

### The persona lifecycle

```
/create-persona          Build a role-based persona (Debate Coach, Budget Planner, etc.)
        ↓
/create-plan             Plan a goal using that persona
        ↓
/create-tracker          Track execution against the plan
        ↓
  tracker complete       Learnings file created → persona updates proposed → evolution file updated
        ↓
/evolve-global-persona   Cross-cutting patterns from all role personas → global persona sharpened
```

---

## Persona examples

Two worked examples are shipped and synced into your `personas/` folder:

| File | What it demonstrates |
|------|---------------------|
| `PERSONA_DEBATE-COACH.md` | Elementary school debate coaching — EALI structure, topic briefs, script feedback, evidence banks |
| `PERSONA_MANDARIN-TEACHER.md` | Early childhood Mandarin — tone-first sequence, spaced repetition, HSK 1 milestone |

These show the full persona structure: framework, output types, failure modes, reference banks, and sample invocations.

---

## Templates

| File | Purpose |
|------|---------|
| `templates/PERSONA_USERNAME_GLOBAL.md` | Global persona starter — communication voice, working style, reviewer patterns |
| `templates/MEMORY_USERNAME_GLOBAL.md` | Session memory starter — file map, active projects, key people, custom commands |
| `templates/CLAUDE.md` | Standalone CLAUDE.md starter — copy to `~/.claude/CLAUDE.md` |
| `templates/sync-launcher.sh` | Source for the standalone sync launcher written to `~/Desktop/ai/sync.sh` |
| `templates/username/commands/` | All command files (synced to your `commands/` folder) |
| `templates/username/personas/examples/` | Worked persona examples (synced to your `personas/` folder) |
| `templates/username/plans/SAMPLE-plan.md` | Plan file structure reference |
| `templates/username/trackers/SAMPLE-tracker.md` | Tracker file structure reference |
| `templates/username/learnings/SAMPLE-learning-debrief.md` | Learnings file structure reference |
| `templates/username/evolution/SAMPLE-EVOLUTION_ROLE.md` | Evolution file structure reference |
| `templates/username/insights/SAMPLE-insights-report.md` | Insights report structure reference |

---

## Supported platforms

| Platform | Setup method |
|----------|-------------|
| macOS | `./setup.sh` |
| Windows (Git Bash) | `./setup.sh` |
| WSL (Ubuntu/Debian) | `./setup.sh` |
| Linux | `./setup.sh` |

---

## Versioning

The repo uses semantic versioning in `VERSION`. The current version is `0.0.1-SNAPSHOT` (beta).

Every PR must include a version bump — the GitHub Actions workflow reads the checked bump type
(patch / minor / major / none) from the PR body and automatically increments `VERSION` and
updates `CHANGELOG.md` in the branch before merge.

---

## Contributing

All changes go via a branch and PR — direct pushes to main are blocked.

When opening a PR, the template will prompt for:
- **Description** — why this change is being made
- **Summary** — what it does
- **What Changed** — files and specifics
- **Version Bump** — patch / minor / major / none

The version bump workflow runs automatically and commits the updated `VERSION` and `CHANGELOG.md` to the branch.

---

## Repo structure

```
paridas-bootstrap/
├── README.md
├── CHANGELOG.md
├── VERSION
├── setup.sh                            ← one-time workspace creation
├── update.sh                           ← keep bootstrap repo current with GitHub
├── sync.sh                             ← keep workspace current with bootstrap repo
├── .gitignore
├── .github/
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── workflows/
│       └── version-bump.yml            ← auto version bump + changelog on PR
├── learning-guides/
│   ├── Claude-AI-Learning-Guide.md
│   ├── Claude-Professional-OS-Guide.md
│   └── Cursor-AI-Learning-Guide.md
├── templates/
│   ├── PERSONA_USERNAME_GLOBAL.md
│   ├── MEMORY_USERNAME_GLOBAL.md
│   ├── CLAUDE.md
│   ├── sync-launcher.sh                ← source for ~/Desktop/ai/sync.sh
│   └── username/                       ← synced into user workspace by sync.sh
│       ├── commands/
│       │   ├── create-persona.md
│       │   ├── create-plan.md
│       │   ├── create-tracker.md
│       │   ├── articulate.md
│       │   ├── visualize-evolution.md
│       │   └── evolve-global-persona.md
│       ├── personas/
│       │   └── examples/
│       │       ├── PERSONA_DEBATE-COACH.md
│       │       └── PERSONA_MANDARIN-TEACHER.md
│       ├── plans/SAMPLE-plan.md
│       ├── trackers/SAMPLE-tracker.md
│       ├── learnings/SAMPLE-learning-debrief.md
│       ├── evolution/SAMPLE-EVOLUTION_ROLE.md
│       └── insights/SAMPLE-insights-report.md
└── claude-code/
    └── skills/
        └── ai-ready-setup/
            └── SKILL.md
```
