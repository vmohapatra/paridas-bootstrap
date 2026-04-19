# Command: Create Tracker

## Trigger
User says: "Create a tracker for: [topic/plan]" or "Track this plan" or
automatically invoked after CREATE-PLAN confirms the plan is saved.

---

## How This Command Works

Reads the corresponding plan file from `~/Desktop/ai/<yourname>/plans/` and generates
a tracker that mirrors its phases. Uses the active persona and global persona for context.
No need to re-specify the persona — it is already loaded.

---

## Phase 1 — Intake (one question at a time)

**Q1. Which plan should this tracker follow?**
Detect from session context first (e.g. if CREATE-PLAN was just run, use that plan).
If unclear, ask:
> "Which plan file should I track? Give me the topic or filename — e.g. 'june budget' or `BUDGET_PLAN_june-2026.md`"

*(Wait for answer. Read the plan file. Then ask Q2.)*

**Q2. Is there a target date not already in the plan?**
> If the plan already has a target date, skip this question and use it.
> If missing: "What's the deadline or target date for this?"

*(Wait for answer if needed, then generate the tracker.)*

---

## Phase 2 — Generate the Tracker

Read the plan file and derive phases, actions, and success criteria from it.
Produce a tracker in this structure:

```
# Tracker: [Goal or Topic]

**Plan file:** `plans/[plan-filename].md`
**Persona:** [active persona]
**Started:** [today's date]
**Target:** [deadline from plan or answer above]
**Status:** in-progress

---

## Progress

| Date | Phase | What Was Done | Outcome |
|------|-------|---------------|---------|
| [today] | Phase 1 — [name] | [first action from plan] | Pending |
| | Phase 2 — [name] | | Pending |
| | Phase 3 — [name] | | Pending |
[one row per phase from the plan]

---

## Current Status

**Active phase:** Phase 1 — [name]
**Next action:** [first specific action from Phase 1 checklist]
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
[derive from plan's Risks section]

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
Filename: `[DOMAIN]_TRACKER_[topic-slug].md`

Must match the domain and slug of the corresponding plan file:
- Plan: `DEBATE_PLAN_topic-name.md`
- Tracker: `DEBATE_TRACKER_topic-name.md`

---

## After Saving

Confirm file path, then say:
> "Tracker saved. Update it as you complete each phase — mark status `complete` when done and I'll generate a learnings file and propose persona updates."

---

## Rules

- Always read the plan file before generating the tracker — derive phases, don't invent them
- One question at a time — wait for each answer
- If no plan file exists yet, say: "No plan file found. Run CREATE-PLAN first, then I'll build the tracker from it."
- Tracker phases must exactly mirror plan phases — no renaming or reordering
- Flag any plan phase with no clear actions as a gap — note it in Blockers & Risks

---
*Contributed from paridas-bootstrap — genericized for reuse*
