# Command: Create Plan

## Trigger
User says: "Create a plan for: [topic/goal]" or "Generate plan: [topic/goal]"

---

## How This Command Works

Uses the active persona (from current session context) and the global persona at
`~/Desktop/ai/<yourname>/PERSONA_<yourname>_GLOBAL.md` to generate a structured plan.
No need to re-specify the persona — it is already loaded.

---

## Phase 1 — Intake (one question at a time)

Do NOT generate the plan yet. Ask these questions one at a time, waiting for each answer.

**Q1. Which persona is driving this plan?**
Detect from session context first. If unclear, ask:
> "Which persona should this plan use? e.g. Debate Coach, Language Tutor, Budget Planner — or leave blank to use the global persona."

*(Wait for answer, then ask Q2.)*

**Q2. What is the specific goal or topic?**
> e.g. "Prepare for the project presentation on May 10" or "Plan June household budget"
> Be specific — vague goals produce vague plans.

*(Wait for answer, then ask Q3.)*

**Q3. What is the target date or deadline?**
> e.g. "Presentation is on May 10" or "No deadline — ongoing"
> If no deadline, note it in the plan and flag it as a risk.

*(Wait for answer, then generate the plan.)*

---

## Phase 2 — Generate the Plan

Use the answers above to produce a plan in this structure:

```
# Plan: [Goal or Topic]

**Persona:** [active persona]
**Goal:** [specific outcome]
**Started:** [today's date]
**Target:** [deadline or "ongoing"]
**Status:** not-started

---

## Phases

| Phase | Name | What it covers |
|-------|------|----------------|
| 1 | [phase name] | [description] |
| 2 | [phase name] | [description] |
| ... | | |

---

## Phase Breakdown

### Phase 1 — [Name]
- [ ] [specific action]
- [ ] [specific action]
- [ ] [specific action]

### Phase 2 — [Name]
- [ ] [specific action]
...

---

## Success Criteria
- [what done looks like — measurable where possible]
- [what done looks like]

---

## Risks
- [known risk and mitigation]

---
*Created: [date] | Persona: [persona name]*
```

---

## Naming Convention

Save to: `~/Desktop/ai/<yourname>/plans/`
Filename: `[DOMAIN]_PLAN_[topic-slug].md`

Examples:
- `DEBATE_PLAN_topic-name.md`
- `BUDGET_PLAN_june-2026.md`
- `LEARNING_PLAN_hsk1-prep.md`

Derive `[DOMAIN]` from the active persona. Use lowercase kebab-case for the topic slug.

---

## After Saving

Confirm file path, then ask:
> "Plan saved. Want me to create a tracker for this now?"

If yes — invoke CREATE-TRACKER command with this plan as the source.

---

## Rules

- One question at a time — wait for each answer
- Derive phases from the persona's natural workflow — don't use generic phase names
- If deadline is missing, flag it as a risk in the plan
- If the user says "all phases" or is unsure, suggest the standard phases for that persona type

---
*Contributed from paridas-bootstrap — genericized for reuse*
