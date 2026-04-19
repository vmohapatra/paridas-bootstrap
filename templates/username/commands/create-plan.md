# Create Plan

Generate a structured plan tied to an active persona and a specific goal.

---

## When to Use

Invoke with `"Create a plan for: [topic/goal]"` or `"Generate plan: [topic/goal]"` when you have:
- A new topic or goal to prepare for under an active persona
- A task that needs phases, actions, and success criteria before work starts

---

## How It Works

Uses the active persona from session context and the global persona at
`~/Desktop/ai/<yourname>/PERSONA_<yourname>_GLOBAL.md`.
No need to re-specify the persona — it is already loaded.

---

## Intake — One Question at a Time

Ask these questions one at a time. Wait for each answer before asking the next.

**Q1. Which persona is driving this plan?**
Detect from session context first. If unclear, ask:
> "Which persona should this plan use? e.g. Debate Coach, Mandarin Teacher — or leave blank to use the global persona."

**Q2. What is the specific goal or topic?**
> Be specific — vague goals produce vague plans.

**Q3. What is the target date or deadline?**
> If none, note it in the plan and flag it as a risk.

---

## Output Structure

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

---

## Phase Breakdown

### Phase 1 — [Name]
- [ ] [specific action]
- [ ] [specific action]

### Phase 2 — [Name]
- [ ] [specific action]

---

## Success Criteria
- [measurable outcome]

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

Derive `[DOMAIN]` from the active persona. Use lowercase kebab-case for the slug.

Examples:
- `DEBATE_PLAN_box-lunches-vs-school-lunches.md`
- `MANDARIN_PLAN_hsk1-prep.md`
- `BUDGET_PLAN_june-2026.md`

---

## After Saving

Confirm the file path, then ask:
> "Plan saved. Want me to create a tracker for this now?"

If yes — run the `create-tracker` command with this plan as the source.

---

## Rules

- One question at a time — wait for each answer before proceeding
- Derive phases from the persona's natural workflow — don't use generic phase names
- If deadline is missing, flag it as a risk in the plan
- If the user is unsure of phases, suggest the standard phases for that persona type

---
*Last updated: 2026-04-19*
