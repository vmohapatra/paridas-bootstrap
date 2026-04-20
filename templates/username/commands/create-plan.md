# Create Plan

Start a session log for a goal and create the project folder for its deliverables.

---

## Two things get created

| What | Where | Purpose |
|------|-------|---------|
| Plan log | `plans/<persona-slug>/PLAN_<topic-slug>.md` | Activity log — every step taken, linked to outputs |
| Project folder | `projects/<persona-slug>/<topic-slug>/` | Where all deliverables for this goal live |

---

## When to Use

Invoke with `"Create a plan for: [topic/goal]"` or `"Start plan: [topic/goal]"`.

---

## Intake — One Question at a Time

**Q1. Which persona is driving this plan?**
Detect from session context first. If unclear, ask:
> "Which persona should this plan use? e.g. Debate Coach, Mandarin Teacher — or leave blank to use the global persona."

**Q2. What is the specific goal or topic?**
> Be specific — vague goals produce vague logs.

---

## Plan Log Format

Save to: `~/Desktop/ai/<yourname>/plans/<persona-slug>/PLAN_<topic-slug>.md`

```
# Plan: [Topic]

**Persona:** [persona name]
**Topic:** [specific goal or topic]
**Started:** [today's date]
**Status:** in-progress
**Project folder:** `projects/<persona-slug>/<topic-slug>/`

---

## Session Log

| Date | Step | Deliverable |
|------|------|-------------|
| [today] | [first step taken] | [filename in project folder, or —] |
```

---

## Project Folder

Create immediately when the plan starts:
`~/Desktop/ai/<yourname>/projects/<persona-slug>/<topic-slug>/`

All deliverables for this goal — topic briefs, feedback docs, analysis files, HTML outputs —
go here. Never save deliverables directly to `plans/`.

---

## Logging steps

Each time the persona takes an action in this session, append a row to the Session Log:

```
| 2026-04-19 | Generated topic brief with pro/con breakdown | DEBATE_TOPIC-BRIEF_box-lunches.md |
| 2026-04-19 | Assessed student opening speech | DEBATE_SCRIPT-FEEDBACK_box-lunches.md |
| 2026-04-19 | Suggested rebuttal structure | — |
```

If the step produced a file, link it by filename. If it was advice or analysis with no output file, use `—`.

---

## Naming conventions

**Persona slug:** lowercase kebab-case from the persona name
- `Debate Coach` → `debate-coach`
- `Mandarin Teacher` → `mandarin-teacher`

**Topic slug:** lowercase kebab-case from the topic
- `Box Lunches vs School Lunches` → `box-lunches-vs-school-lunches`

**Deliverable filenames:** `<DOMAIN>_<TYPE>_<topic-slug>.<ext>`
- `DEBATE_TOPIC-BRIEF_box-lunches-vs-school-lunches.md`
- `DEBATE_SCRIPT-FEEDBACK_box-lunches-vs-school-lunches.md`
- `BUDGET_ANALYSIS_june-2026.md`
- `MANDARIN_EXERCISE_tones-practice.html`

---

## After saving

Confirm both paths:
> "Plan log created at `plans/debate-coach/PLAN_box-lunches-vs-school-lunches.md`
> Project folder ready at `projects/debate-coach/box-lunches-vs-school-lunches/`
> I'll log each step here as we work."

Then proceed with the goal. Log every step as it happens.

---

## Rules

- One question at a time — wait for each answer
- Create the project folder immediately, even if no deliverables exist yet
- Log every step — including advice and analysis that produced no file
- Deliverables always go in the project folder, never in plans/
- Keep the log up to date throughout the session, not just at the end

---
*Last updated: 2026-04-19*
