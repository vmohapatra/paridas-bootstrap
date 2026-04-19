# paridas-bootstrap

A personal AI workspace bootstrap — get a consistent, structured working environment
on any device in minutes.

---

## What this repo is

`paridas-bootstrap` is a portable setup kit that creates your personal AI workspace
under `~/Desktop/ai/<yourname>/`. It provisions the directory layout, starter persona
and memory files, and a global `~/.claude/CLAUDE.md` so Claude Code (and other AI
tools) have consistent context about who you are and how you work — no matter which
machine you're on.

---

## Setup paths

### Option A — shell script (no Claude Code required)

Works on macOS, Windows (Git Bash), WSL, and Linux.

```bash
git clone <this-repo> ~/Desktop/ai/paridas-bootstrap
cd ~/Desktop/ai/paridas-bootstrap
./setup.sh <yourname>
```

Replace `<yourname>` with the name you want for your workspace folder
(e.g. `vijay`, `rparida`).

### Option B — Claude Code skill

If you already have Claude Code installed, run the bundled skill from inside
this repo:

```
/ai-ready-setup
```

The skill reads your name from the conversation and drives the same setup
steps interactively.

---

## What gets created

Running either setup path produces:

```
~/Desktop/ai/<yourname>/
├── insights/          ← AI session debrief reports
├── learnings/         ← distilled learning notes
├── personas/          ← role-specific persona files
├── plans/             ← project plans and outlines
├── commands/          ← custom slash-command definitions
├── trackers/          ← progress and habit trackers
└── evolution/         ← role-evolution snapshots
```

Plus two root-level files:

| File | Purpose |
|------|---------|
| `~/Desktop/ai/<yourname>/PERSONA_<YOURNAME>_GLOBAL.md` | Tells AI tools who you are, your background, communication style, and working preferences |
| `~/Desktop/ai/<yourname>/MEMORY_<YOURNAME>_GLOBAL.md` | Running log of key decisions, context, and things you want AI tools to remember across sessions |

And a global Claude Code config:

| File | Purpose |
|------|---------|
| `~/.claude/CLAUDE.md` | Workspace-level instructions loaded by Claude Code on every session |

---

## After setup — first three things to do

1. **Fill in your PERSONA file** — open `PERSONA_<YOURNAME>_GLOBAL.md` and describe
   yourself: role, domain expertise, communication preferences, and any working
   norms you want AI tools to respect.

2. **Fill in your MEMORY file** — open `MEMORY_<YOURNAME>_GLOBAL.md` and seed it
   with the context that matters most right now: current projects, recent decisions,
   open questions.

3. **Review CLAUDE.md** — open `~/.claude/CLAUDE.md` and tweak the default
   Claude Code instructions to match your workflow.

---

## Supported platforms

| Platform | Setup method |
|----------|-------------|
| macOS | `./setup.sh` or `/ai-ready-setup` skill |
| Windows (Git Bash) | `./setup.sh` |
| WSL (Ubuntu/Debian) | `./setup.sh` |
| Linux | `./setup.sh` |

---

## Repo layout

```
paridas-bootstrap/
├── README.md                              ← you are here
├── setup.sh                               ← cross-platform setup script
├── .gitignore
├── learning-guides/                       ← documentation and how-to guides
├── templates/
│   ├── PERSONA_USERNAME_GLOBAL.md         ← persona template
│   ├── MEMORY_USERNAME_GLOBAL.md          ← memory template
│   ├── CLAUDE.md                          ← CLAUDE.md template
│   └── username/
│       ├── insights/
│       ├── learnings/
│       ├── personas/
│       ├── plans/
│       ├── commands/
│       ├── trackers/
│       └── evolution/
└── claude-code/
    └── skills/
        └── ai-ready-setup/
            └── SKILL.md                   ← Claude Code skill definition
```
