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
chmod +x setup.sh
./setup.sh <yourname>
```

Replace `<yourname>` with the name you want for your workspace folder
(e.g. `vijayaa`, `rparida`).

### Option B — Claude Code skill

If you already have Claude Code installed:
1. Copy `claude-code/skills/ai-ready-setup/` to `~/.claude/skills/`
2. Open a Claude Code session in any repo
3. Run: `/ai-ready-setup`

---

## What gets created

Running either setup path produces:

```
~/Desktop/ai/
├── learning-guides/
│   ├── Claude-AI-Learning-Guide.md
│   ├── Claude-Professional-OS-Guide.md
│   └── Cursor-AI-Learning-Guide.md
└── <yourname>/
    ├── PERSONA_<yourname>_GLOBAL.md    ← fill in your communication style
    ├── MEMORY_<yourname>_GLOBAL.md     ← session memory + command reference
    ├── insights/                       ← AI usage insights reports
    ├── learnings/                      ← personal case library
    ├── personas/                       ← role-based personas Claude can embody
    ├── plans/                          ← implementation and strategy plans
    ├── commands/                       ← custom commands built over time
    ├── trackers/                       ← sprint, goal, and metric trackers
    └── evolution/                      ← persona change history over time
~/.claude/
└── CLAUDE.md                           ← global Claude Code instructions
```

---

## After Setup

### 1. Fill in your persona file
Open `~/Desktop/ai/<yourname>/PERSONA_<yourname>_GLOBAL.md` and fill in:
- Your communication style and tone
- How you review PRs and what you flag
- Your strengths and recurring gaps
- Your current professional focus

### 2. Personalise your memory file
Open `~/Desktop/ai/<yourname>/MEMORY_<yourname>_GLOBAL.md` and:
- Add your active projects and repos
- List key colleagues and link their persona files
- Replace all `[placeholder]` values

### 3. Review `~/.claude/CLAUDE.md`
Sections marked `[CUSTOMIZE]` need your values:
- Your build tool and lint commands
- Priority persona files to load at session start

### 4. Start using Claude Code
Each session Claude will:
- Auto-load your memory and persona files
- Apply your communication style to all output
- Prompt you at session end to capture learnings

---

## Templates

| File | Purpose |
|------|---------|
| `templates/PERSONA_USERNAME_GLOBAL.md` | Communication voice, working style, reviewer patterns |
| `templates/MEMORY_USERNAME_GLOBAL.md` | Session memory, file map, custom commands, CLAUDE.md starter |
| `templates/CLAUDE.md` | Standalone CLAUDE.md starter — copy to `~/.claude/CLAUDE.md` |
| `templates/username/` | Empty directory scaffold with `.gitkeep` |
| `templates/commands/CREATE-PERSONA.md` | Command: intake → write a role-based persona via structured Q&A |
| `templates/commands/CREATE-PLAN.md` | Command: intake → generate a phased plan file in `plans/` |
| `templates/commands/CREATE-TRACKER.md` | Command: read a plan → generate a matching tracker in `trackers/` |

---

## Supported platforms

| Platform | Setup method |
|----------|-------------|
| macOS | `./setup.sh` or `/ai-ready-setup` skill |
| Windows (Git Bash) | `./setup.sh` |
| WSL (Ubuntu/Debian) | `./setup.sh` |
| Linux | `./setup.sh` |

---

## Updating

To get new learning guides or template improvements:

```bash
git pull
# re-run setup — existing filled files are skipped, only new files are created
./setup.sh yourname
```
---

## Repo Structure
```
paridas-bootstrap/
├── README.md                       ← you are here
├── setup.sh                        ← cross-platform bootstrap script
├── .gitignore
├── learning-guides/                ← guides shipped with the repo
│   ├── Claude-AI-Learning-Guide.md
│   ├── Claude-Professional-OS-Guide.md
│   └── Cursor-AI-Learning-Guide.md
├── templates/
│   ├── PERSONA_USERNAME_GLOBAL.md
│   ├── MEMORY_USERNAME_GLOBAL.md
│   ├── CLAUDE.md                   ← standalone CLAUDE.md starter
│   ├── commands/                   ← ready-to-use command files
│   │   ├── CREATE-PERSONA.md       ← structured Q&A → persona file
│   │   ├── CREATE-PLAN.md          ← intake → phased plan in plans/
│   │   └── CREATE-TRACKER.md       ← plan → matching tracker in trackers/
│   └── username/                   ← empty directory scaffold
│       ├── insights/.gitkeep
│       ├── learnings/.gitkeep
│       ├── personas/.gitkeep
│       ├── plans/.gitkeep
│       ├── commands/.gitkeep
│       ├── trackers/.gitkeep
│       └── evolution/.gitkeep
└── claude-code/
    └── skills/
        └── ai-ready-setup/
            └── SKILL.md            ← Claude Code skill
```

