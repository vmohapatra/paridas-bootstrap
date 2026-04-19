# Create Tracker

Generate a progress tracker derived directly from an existing plan file.

---

## When to Use

Invoke with `"Create a tracker for: [topic/plan]"` or `"Track this plan"` when you have:
- A plan file already saved in `plans/` that needs progress tracking
- Just completed `create-plan` and want to set up tracking immediately

---

## How It Works

Reads the corresponding plan file from `~/Desktop/ai/<yourname>/plans/` and generates
a tracker that mirrors its phases exactly. Uses the active persona and global persona for context.
No need to re-specify the persona — it is already loaded.

If no plan file exists yet: say `"No plan file found. Run create-plan first, then I'll build the tracker from it."`

---

## Intake — One Question at a Time

**Q1. Which plan should this tracker follow?**
Detect from session context first (e.g. if `create-plan` was just run, use that plan automatically).
If unclear, ask:
> "Which plan should I track? Give me the topic or filename — e.g. 'box lunches debate' or `DEBATE_PLAN_box-lunches-vs-school-lunches.md`"

**Q2. Is there a target date not already in the plan?**
If the plan already has a target date, skip this question.
If missing, ask:
> "What's the target date or deadline for this?"

---

## Output Structure

Read the plan file first. Derive all phases, actions, and risks from it — do not invent them.

```
# Tracker: [Goal or Topic]

**Plan file:** `plans/[plan-filename].md`
**Persona:** [active persona]
**Started:** [today's date]
**Target:** [deadline from plan]
**Status:** in-progress

---

## Progress

| Date | Phase | What Was Done | Outcome |
|------|-------|---------------|---------|
| [today] | Phase 1 — [name] | [first action from plan] | Pending |
| | Phase 2 — [name] | | Pending |
[one row per phase, derived from the plan]

---

## Current Status

**Active phase:** Phase 1 — [name]
**Next action:** [first specific action from Phase 1 checklist in the plan]
**Blocked on:** None

---

## Decisions Made

| Date | Decision | Why |
|------|----------|-----|
| [today] | [any decisions already made] | [reason] |

---

## Blockers & Risks

| Blocker | Owner | Status |
|---------|-------|--------|
[derived from plan's Risks section]

---

## Outcomes

*Filled in when complete.*

---

## Completion Checklist

When setting status to `complete`:
- [ ] Outcomes section filled in
- [ ] Create `learnings/[DOMAIN]_LEARNINGS_[topic-slug].md`
- [ ] Claude proposes updates to active persona file — review and confirm before applying

---
*Last updated: [today's date]*
```

---

## Naming Convention

Save to: `~/Desktop/ai/<yourname>/trackers/`
Filename must match the corresponding plan file's domain and slug:

- Plan: `DEBATE_PLAN_box-lunches-vs-school-lunches.md`
- Tracker: `DEBATE_TRACKER_box-lunches-vs-school-lunches.md`

---

## After Saving

Confirm the file path, then say:
> "Tracker saved. Update it as you complete each phase — mark status `complete` when done and I'll generate a learnings file and propose persona updates."

---

## Rules

- Always read the plan file before generating the tracker — phases are derived, never invented
- One question at a time — wait for each answer
- Tracker phases must exactly mirror plan phases — no renaming or reordering
- Flag any plan phase with no clear actions as a gap — note it in Blockers & Risks
- If no deadline exists anywhere, flag it as a blocker

---
*Last updated: 2026-04-19*
