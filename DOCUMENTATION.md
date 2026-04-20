# paridas-bootstrap — Documentation

## What paridas-bootstrap is

A one-time setup tool that creates a personal AI workspace on your machine — a structured folder where your preferences, personas, plans, and knowledge accumulate across every Claude session.

Without it, every Claude session starts cold. With it, Claude knows who you are, how you work, and what you've built up over time.

---

## The three scripts

| Script | When you run it | What it does |
|--------|----------------|--------------|
| `setup.sh` | Once, on a new machine | Creates your workspace, installs the Claude skill, wires up CLAUDE.md |
| `update.sh` | When you want bootstrap updates | Pulls the latest bootstrap from GitHub |
| `sync.sh` | After updating bootstrap | Copies updated commands/personas/guides into your workspace |

---

## What setup.sh actually does

Run `./setup.sh vijayaa` and it:

1. Creates `~/Desktop/ai/vijayaa/` with this structure:
```
vijayaa/
├── PERSONA_vijayaa_GLOBAL.md   ← your voice, style, how you work (built by /create-persona)
├── MEMORY_vijayaa_GLOBAL.md    ← active projects, key people, file map
├── personas/                   ← role-based personas (Debate Coach, Astrologer, etc.)
├── commands/                   ← slash commands you use in Claude
├── plans/                      ← activity logs and methodology, per persona
│   ├── debate-coach/
│   │   └── PLAN_box-lunches-vs-school-lunches.md   ← topic plan (steps taken)
│   └── astrologer/
│       └── PLAN_astrologer.md                      ← ongoing plan (patterns + approach)
├── projects/                   ← deliverables — docs, HTML, analysis outputs
│   ├── debate-coach/           ← topic plan: subfolder per topic
│   │   └── box-lunches-vs-school-lunches/
│   │       ├── DEBATE_TOPIC-BRIEF_box-lunches-vs-school-lunches.md
│   │       └── DEBATE_SCRIPT-FEEDBACK_box-lunches-vs-school-lunches.md
│   ├── astrology/              ← ongoing plan: deliverables directly in folder
│   │   ├── ASTROLOGY_PREDICTIONS_rakesh-2026.md
│   │   └── ASTROLOGY_READING_family-april-2026.md
│   └── chess-coach/            ← ongoing plan: deliverables directly in folder
│       └── chess.html
├── trackers/                   ← progress tracking against goals
├── learnings/                  ← what you captured after completing goals
├── evolution/                  ← how your personas changed over time
└── insights/                   ← usage reports from /insights
```

2. Writes `~/Desktop/ai/sync.sh` — a standalone launcher that works even if you delete the bootstrap repo later

3. **If Claude is installed:**
   - Imports the `ai-ready-setup` skill into `~/.claude/skills/`
   - Appends the bootstrap instructions to `~/.claude/CLAUDE.md`
   - Prompts you to create your first persona

4. **If Claude is not installed:**
   - Prints the curl install command
   - Tells you to re-run setup after installing

---

## What Claude sees every session

`~/.claude/CLAUDE.md` tells Claude to read your PERSONA and MEMORY files at the start of every session. So Claude walks in knowing:
- Your communication style and preferences
- Your active projects and key people
- Where your files live and how you name things

---

## The persona lifecycle

The real value compounds here:

```
/create-persona     → build a role (Debate Coach, Astrologer, Budget Planner, etc.)
/create-plan        → topic plan (one-off goal) or ongoing plan (recurring persona work)

  Topic plan (e.g. Debate Coach):
    plans/debate-coach/PLAN_box-lunches-vs-school-lunches.md  ← step-by-step log
    projects/debate-coach/box-lunches-vs-school-lunches/      ← all deliverables

  Ongoing plan (e.g. Astrologer):
    plans/astrologer/PLAN_astrologer.md    ← methodology + patterns across sessions
    projects/astrology/                    ← all readings, predictions, analyses

/create-tracker     → track overall goal progress
  ↓ tracker complete
  learnings file created, persona updates proposed
/evolve-global-persona → patterns from all your roles → sharpen your global persona
```

Each role you build makes the next session smarter. The global persona becomes a distillation of how you actually work across all contexts.

---

## Keeping things current

Bootstrap ships improved commands and persona examples over time. To get them:

```bash
cd ~/Desktop/ai/paridas-bootstrap && ./update.sh   # pull latest bootstrap
~/Desktop/ai/sync.sh vijayaa                        # sync into your workspace
```

Your own files (personas you built, plans, trackers) are never touched by sync.

---

## First-time checklist

1. Clone the repo: `git clone https://github.com/vmohapatra/paridas-bootstrap ~/Desktop/ai/paridas-bootstrap`
2. Run: `cd ~/Desktop/ai/paridas-bootstrap && ./setup.sh <yourname>`
3. Open Claude Code and run `/create-persona` to build your first role
