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
| `templates/username/commands/create-persona.md` | Command: intake → write a role-based persona via structured Q&A |
| `templates/username/commands/create-plan.md` | Command: intake → generate a phased plan file in `plans/` |
| `templates/username/commands/create-tracker.md` | Command: read a plan → generate a matching tracker in `trackers/` |
| `templates/username/commands/articulate.md` | Command: rough input → short + full clean written version |
| `templates/username/commands/visualize-evolution.md` | Command: generate HTML dashboard from trackers and evolution files |

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

Run the updater to check for and pull the latest version:

```bash
cd ~/Desktop/ai/paridas-bootstrap
./update.sh
```

The updater will:
1. Show the local and remote version
2. List commits that have landed since your version
3. Ask for confirmation before pulling
4. Leave your workspace files (`~/Desktop/ai/<yourname>/`) untouched

After updating the bootstrap repo, sync your workspace to pick up new templates and commands:

```bash
./sync.sh <yourname>
```

`sync.sh` copies all bootstrap-managed files (commands, persona examples, learning guides) into your workspace. Your custom files — additional commands, personal personas, plans, trackers — are never touched. Your workspace always ends up as a superset of what bootstrap provides.
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
│   └── username/                   ← scaffold synced into user workspace
│       ├── commands/               ← all commands (synced by sync.sh)
│       │   ├── create-persona.md
│       │   ├── create-plan.md
│       │   ├── create-tracker.md
│       │   ├── articulate.md
│       │   └── visualize-evolution.md
│       ├── personas/
│       │   └── examples/           ← worked persona examples (synced to personas/)
│       ├── insights/.gitkeep
│       ├── learnings/.gitkeep
│       ├── plans/.gitkeep
│       ├── trackers/.gitkeep
│       └── evolution/.gitkeep
└── claude-code/
    └── skills/
        └── ai-ready-setup/
            └── SKILL.md            ← Claude Code skill
```

