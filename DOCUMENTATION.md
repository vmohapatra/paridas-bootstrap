# paridas-bootstrap — Documentation

## What paridas-bootstrap is

A one-time setup tool that creates a personal AI workspace on your machine — a structured folder where your preferences, personas, plans, and knowledge accumulate across every Claude session.

Without it, every Claude session starts cold. With it, Claude knows who you are, how you work, and what you've built up over time.

---

## Repo structure

```
paridas-bootstrap/
├── setup.sh                    ← one-time workspace creator
├── sync.sh                     ← syncs bootstrap files into user workspace
├── update.sh                   ← pulls latest bootstrap from GitHub
├── VERSION                     ← semver (e.g. 0.0.2-SNAPSHOT)
├── CHANGELOG.md                ← auto-updated by PR workflow
├── DOCUMENTATION.md            ← this file
├── README.md                   ← repo overview
├── templates/
│   ├── CLAUDE.md               ← global Claude Code instructions template
│   ├── PERSONA_USERNAME_GLOBAL.md
│   ├── MEMORY_USERNAME_GLOBAL.md
│   ├── sync-launcher.sh        ← template for ~/Desktop/ai/sync.sh
│   └── username/               ← everything synced into user workspace
│       ├── commands/           ← 6 slash commands
│       ├── personas/examples/  ← worked persona examples
│       ├── plans/
│       ├── projects/
│       ├── trackers/
│       ├── learnings/
│       ├── evolution/
│       └── insights/
├── claude-code/
│   └── skills/
│       └── ai-ready-setup/
│           └── SKILL.md        ← Claude Code skill
└── .github/
    ├── PULL_REQUEST_TEMPLATE.md
    └── workflows/
        └── version-bump.yml    ← auto version bump on PR merge
```

---

## The three scripts

| Script | When you run it | What it does |
|--------|----------------|--------------|
| `setup.sh` | Once, on a new machine | Creates your workspace, installs the Claude skill, wires up CLAUDE.md |
| `update.sh` | When you want bootstrap improvements | Pulls the latest bootstrap from GitHub |
| `sync.sh` | After updating bootstrap | Copies updated commands/personas/guides into your workspace |

### setup.sh

Run `./setup.sh <yourname>` and it:

1. Creates `~/Desktop/ai/<yourname>/` with this structure:
```
<yourname>/
├── PERSONA_<yourname>_GLOBAL.md   ← your voice, style, how you work
├── MEMORY_<yourname>_GLOBAL.md    ← active projects, key people, file map
├── personas/                      ← role-based personas
├── commands/                      ← slash commands
├── plans/                         ← activity logs and methodology, per persona
│   ├── debate-coach/
│   │   └── PLAN_box-lunches-vs-school-lunches.md  ← topic plan (steps taken)
│   └── chess-coach/
│       └── PLAN_chess-coach.md                    ← ongoing plan (patterns + approach)
├── projects/                      ← deliverables — docs, HTML, analysis outputs
│   ├── debate-coach/
│   │   └── box-lunches-vs-school-lunches/         ← topic plan: subfolder per topic
│   │       ├── DEBATE_TOPIC-BRIEF_box-lunches-vs-school-lunches.md
│   │       └── DEBATE_SCRIPT-FEEDBACK_box-lunches-vs-school-lunches.md
│   └── chess-coach/                               ← ongoing plan: deliverables in folder
│       └── chess.html
├── trackers/                      ← progress tracking against goals
├── learnings/                     ← captured after completing goals
├── evolution/                     ← how your personas changed over time
└── insights/                      ← usage reports from /insights
```

2. Writes `~/Desktop/ai/sync.sh` — a standalone launcher that survives bootstrap repo deletion (re-clones if missing)
3. Writes `.bootstrap-source` in the workspace (records repo URL, version, setup date)
4. **If Claude is installed:** imports skills → appends `templates/CLAUDE.md` to `~/.claude/CLAUDE.md` → prompts for first persona
5. **If Claude is not installed:** prints curl install command, tells user to re-run

### sync.sh

- Compares workspace `.bootstrap-version` against repo `VERSION` — exits if already current
- Syncs: commands, persona examples, learning guides, Claude skills
- Never touches user files (personas, plans, projects, trackers)
- Creates workspace from scratch if missing (calls `setup.sh` first)

### update.sh

- Fetches remote `VERSION`, shows commits since local version
- Pulls on user confirmation, then directs to run `sync.sh`

---

## The 6 commands

| Command | What it does |
|---------|-------------|
| `/create-persona` | Q&A intake (5 questions, one at a time) → writes a structured persona file to `personas/` |
| `/create-plan` | Detects topic vs ongoing → creates activity log in `plans/<persona>/` and project folder in `projects/<persona>/` |
| `/create-tracker` | Reads a plan → generates a matching tracker in `trackers/` |
| `/articulate` | Takes rough input → produces short + full clean written versions |
| `/visualize-evolution` | Reads trackers + evolution files → generates a self-contained HTML dashboard |
| `/evolve-global-persona` | Reads all role personas → proposes updates to global persona (waits for confirmation before writing) |

---

## What Claude sees every session

`~/.claude/CLAUDE.md` tells Claude to read your PERSONA and MEMORY files at the start of every session. So Claude walks in knowing:
- Your communication style and preferences
- Your active projects and key people
- Where your files live and how you name things

---

## The persona lifecycle

```
/create-persona     → build a role (Debate Coach, Chess Coach, Budget Planner, etc.)
/create-plan        → topic plan (one-off goal) or ongoing plan (recurring persona work)

  Topic plan:
    plans/<persona>/PLAN_<topic>.md      ← step-by-step log
    projects/<persona>/<topic>/          ← deliverables in a topic subfolder

  Ongoing plan:
    plans/<persona>/PLAN_<persona>.md    ← methodology + patterns across sessions
    projects/<persona>/                  ← deliverables directly in folder

/create-tracker     → track overall goal progress
  ↓ tracker complete
  learnings file created, persona updates proposed
/evolve-global-persona → patterns from all your roles → sharpen your global persona
```

Each role you build makes the next session smarter. The global persona becomes a distillation of how you actually work across all contexts.

---

## Example workspace walkthrough

**Setup — new machine:**
```bash
./setup.sh alex
```
Claude is installed → skill imported, CLAUDE.md updated, prompted for first persona.

Alex says **"Chess Coach"** → `/create-persona` runs, asks 5 questions, writes:
`personas/PERSONA_CHESS-COACH.md`

**Session 1:**
Claude starts → reads `CLAUDE.md` → reads `MEMORY_alex_GLOBAL.md` and `PERSONA_alex_GLOBAL.md` → confirms what's loaded.

Alex runs `/create-plan` → Claude detects ongoing work → creates:
- `plans/chess-coach/PLAN_chess-coach.md`
- `projects/chess-coach/`

Claude builds `chess.html`, logs each step in the plan, saves the deliverable to `projects/chess-coach/chess.html`.

**Session 2 — new topic:**
Alex runs `/create-plan` for a debate topic → Claude detects topic plan → creates:
- `plans/debate-coach/PLAN_box-lunches-vs-school-lunches.md`
- `projects/debate-coach/box-lunches-vs-school-lunches/`

Deliverables (topic brief, script feedback) go into the project subfolder. Each step logged.

**Over time:**
Trackers complete → learnings captured → `/evolve-global-persona` reads all role personas → proposes changes to `PERSONA_alex_GLOBAL.md` → Alex confirms → evolution file updated.

**New machine:**
```bash
git clone https://github.com/vmohapatra/paridas-bootstrap ~/Desktop/ai/paridas-bootstrap
./setup.sh alex
```
Same workspace structure, same CLAUDE.md, same skill. Claude picks up exactly where it left off.

---

## Keeping things current

```bash
cd ~/Desktop/ai/paridas-bootstrap && ./update.sh   # pull latest bootstrap
~/Desktop/ai/sync.sh <yourname>                     # sync into your workspace
```

Your own files — personas, plans, projects, trackers — are never touched by sync.

---

## First-time checklist

1. Clone the repo: `git clone https://github.com/vmohapatra/paridas-bootstrap ~/Desktop/ai/paridas-bootstrap`
2. Run: `cd ~/Desktop/ai/paridas-bootstrap && ./setup.sh <yourname>`
3. Open Claude Code and run `/create-persona` to build your first role
