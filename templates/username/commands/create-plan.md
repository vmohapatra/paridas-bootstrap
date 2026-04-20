# Create Plan

Start an activity log for a goal and create the project folder for its deliverables.

---

## Two plan types

| Type | When | Plan path | Project path |
|------|------|-----------|--------------|
| **Topic** | One-off goal with a clear deliverable | `plans/<persona>/PLAN_<topic>.md` | `projects/<persona>/<topic>/` |
| **Ongoing** | Recurring persona work (no single topic) | `plans/<persona>/PLAN_<persona>.md` | `projects/<subject-area>/` |

**Topic example:** Debate Coach preparing for "box lunches vs school lunches"
- Plan: `plans/debate-coach/PLAN_box-lunches-vs-school-lunches.md`
- Project: `projects/debate-coach/box-lunches-vs-school-lunches/`

**Ongoing example:** Astrologer working across multiple readings over time
- Plan: `plans/astrologer/PLAN_astrologer.md`
- Project: `projects/astrology/`

---

## When to Use

Invoke with `"Create a plan for: [topic/goal]"` or `"Start plan: [topic/goal]"`.

---

## Intake — One Question at a Time

**Q1. Which persona is driving this plan?**
Detect from session context first. If unclear, ask:
> "Which persona should this plan use? e.g. Debate Coach, Astrologer, Budget Planner"

**Q2. Is this for a specific topic, or ongoing work for this persona?**
> "Is this for a specific topic (e.g. a debate topic, a budget month), or ongoing work
> you'll keep adding to over time (e.g. astrology readings, language lessons)?"

**Q3. (Topic only) What is the specific topic?**
Skip if ongoing.

---

## Plan log format — Topic

Save to: `~/Desktop/ai/<yourname>/plans/<persona-slug>/PLAN_<topic-slug>.md`

```
# Plan: [Topic]

**Persona:** [persona name]
**Topic:** [specific topic]
**Started:** [today's date]
**Status:** in-progress | complete
**Project folder:** `projects/<persona-slug>/<topic-slug>/`

---

## Session Log

| Date | Step | Deliverable |
|------|------|-------------|
| [today] | [first step taken] | [filename or —] |
```

---

## Plan log format — Ongoing

Save to: `~/Desktop/ai/<yourname>/plans/<persona-slug>/PLAN_<persona-slug>.md`

```
# Plan: [Persona Name] — Ongoing

**Persona:** [persona name]
**Started:** [today's date]
**Status:** active
**Project folder:** `projects/<subject-area>/`

---

## Approach & Patterns

[Running record of methodology, frameworks used, and patterns observed across sessions.
Updated as new patterns emerge — not a step-by-step log.]

---

## Session Log

| Date | Session focus | Deliverable | Pattern noted |
|------|---------------|-------------|---------------|
| [today] | [what this session covered] | [filename or —] | [any new pattern or approach used] |
```

---

## Project folder

Create immediately when the plan starts.

- **Topic:** `~/Desktop/ai/<yourname>/projects/<persona-slug>/<topic-slug>/`
- **Ongoing:** `~/Desktop/ai/<yourname>/projects/<subject-area>/`

All deliverables for this goal go here — docs, HTML, analysis files, prediction records.
Never save deliverables directly to `plans/`.

---

## Deliverable naming

`<DOMAIN>_<TYPE>_<topic-slug>.<ext>`

Examples:
- `DEBATE_TOPIC-BRIEF_box-lunches-vs-school-lunches.md`
- `DEBATE_SCRIPT-FEEDBACK_box-lunches-vs-school-lunches.md`
- `ASTROLOGY_PREDICTIONS_rakesh-2026.md`
- `ASTROLOGY_READING_family-april-2026.md`
- `BUDGET_ANALYSIS_june-2026.md`

---

## After saving

Confirm both paths, then proceed:
> "Plan log created at `plans/astrologer/PLAN_astrologer.md`
> Project folder ready at `projects/astrology/`
> I'll log each session and note patterns as we work."

---

## Updating an ongoing plan

When returning to an ongoing persona in a new session:
1. Read the existing plan — load the Approach & Patterns section
2. Add a new row to Session Log
3. Update Approach & Patterns if anything new was observed

---

## Rules

- One question at a time — wait for each answer
- Create the project folder immediately, even if no deliverables exist yet
- Deliverables always go in the project folder, never in plans/
- Topic plans: log every step as it happens
- Ongoing plans: update patterns section when methodology evolves, not just when deliverables are created

---
*Last updated: 2026-04-19*
