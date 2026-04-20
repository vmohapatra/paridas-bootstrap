# /contribute-to-bootstrap

Discover workspace improvements that can be generalized and contributed back to the paridas-bootstrap repo.

---

## When to Use

Run this when you have built something in your workspace — a new command, a new persona structure, a useful CLAUDE.md addition — that would be valuable to other bootstrap users in a generic form.

---

## What Can Be Contributed

| Type | Source in workspace | Destination in bootstrap |
|------|---------------------|--------------------------|
| Commands | `commands/` — files not shipped by bootstrap | `templates/username/commands/` |
| Persona structures | `personas/` — role-based personas (not your global persona) | `templates/username/personas/examples/` |
| CLAUDE.md additions | New sections proven useful across sessions | `templates/CLAUDE.md` |

**Never contributed:** personal personas (`PERSONA_<yourname>_GLOBAL.md`), plans, projects, trackers, learnings, memory files.

---

## Step 1 — Read workspace source

Read `~/.../WORKSPACE/.bootstrap-source` to get:
- `bootstrap_dir` — path to the local bootstrap repo
- `bootstrap_version` — version at last sync (the baseline)

If `.bootstrap-source` is missing, ask the user for the bootstrap repo path.

---

## Step 2 — Discover candidates

**Commands:**
List files in `~/Desktop/ai/<yourname>/commands/` that do NOT exist in `$bootstrap_dir/templates/username/commands/`.

**Personas:**
List files in `~/Desktop/ai/<yourname>/personas/` that:
- Are NOT `PERSONA_<yourname>_GLOBAL.md`
- Do NOT already exist in `$bootstrap_dir/templates/username/personas/examples/`

**CLAUDE.md additions:**
Compare `~/.claude/CLAUDE.md` against `$bootstrap_dir/templates/CLAUDE.md` — identify sections the user added that aren't in the template.

Present all candidates grouped by type. Ask:
> "I found [N] candidates to contribute. Want to review them one at a time?"

---

## Step 3 — Review and generalize each candidate

For each candidate, show:
1. The original file content
2. A proposed generic version with all personal specifics replaced

**Generalization rules:**
- Replace `<yourname>` and any real names with `<yourname>` placeholder
- Replace specific topics, subjects, or contexts with `[topic]`, `[role]`, `[subject]`
- Replace specific people, places, or organizations with generic equivalents
- Keep all structural elements, frameworks, behavioral rules, and output formats intact
- Add footer: `*Contributed from paridas-bootstrap — genericized for reuse*`

Ask after each:
> "Contribute this? (yes / no / edit)"

If **edit**: ask what to change, apply, show result, confirm again.
If **no**: skip and move to next.
If **yes**: queue for contribution.

---

## Step 4 — Write to bootstrap repo

For each approved file:
- **Commands** → write to `$bootstrap_dir/templates/username/commands/<filename>`
- **Personas** → write to `$bootstrap_dir/templates/username/personas/examples/<filename>`
- **CLAUDE.md additions** → append to `$bootstrap_dir/templates/CLAUDE.md` under the appropriate section

Then stage all written files:
```bash
cd $bootstrap_dir
git add templates/username/commands/<files>
git add templates/username/personas/examples/<files>
git add templates/CLAUDE.md   # if applicable
```

---

## Step 5 — Run contribute.sh

```bash
cd $bootstrap_dir
./contribute.sh <yourname> <slug>
```

Where `<slug>` is a short kebab-case description of what's being contributed (e.g. `personal-coach-command`, `chef-persona`).

This creates a branch, commits the staged files, pushes, and opens a draft PR.

---

## Step 6 — Report

Confirm what was contributed:
```
Contributed to paridas-bootstrap:

  commands/
    ✓ personal-coach.md
    ✓ debrief.md

  personas/examples/
    ✓ PERSONA_CHEF.md

Draft PR opened — review and set version bump before merging.
```

---

## Rules

- Never write personal content to the bootstrap repo — generalize first, always
- Never contribute files that already exist in the bootstrap (check before writing)
- Never run contribute.sh until the user has approved every file being contributed
- One contribution session per run — don't batch unrelated files into one PR
- If bootstrap_dir is not a git repo or has uncommitted changes, stop and warn the user

---
*Last updated: 2026-04-19*
