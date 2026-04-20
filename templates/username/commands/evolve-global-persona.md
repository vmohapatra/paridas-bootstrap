# /evolve-global-persona

Read all persona files the user has built and synthesize cross-cutting patterns
into proposed updates for their global persona file.

---

## When to Use

- After accumulating 3+ role-based personas
- When the global persona feels generic compared to how you actually work
- Periodically — the global persona should compound over time, not stay static

---

## Instructions

### Step 1 — Read all source files

Read every `.md` file in `~/Desktop/ai/<yourname>/personas/` except files
that are clearly examples (e.g. prefixed with `PERSONA_DEBATE-COACH`,
`PERSONA_MANDARIN-TEACHER` — shipped examples, not the user's own work).

Read `~/Desktop/ai/<yourname>/PERSONA_<yourname>_GLOBAL.md`.

### Step 2 — Identify cross-cutting patterns

Across all role personas, extract patterns that appear in 2 or more:

- **Communication style** — tone, sentence length, directness, formality
- **Feedback approach** — how critique is delivered, what gets flagged first
- **Output structure** — recurring formats, section ordering, naming conventions
- **Failure modes** — what this person consistently guards against
- **Standards** — non-negotiables that appear across roles (e.g. "always cite sources", "lead with the point")
- **What they avoid** — patterns explicitly listed as anti-patterns across roles

### Step 3 — Compare against global persona

For each pattern found:
- If already in the global persona and accurate → skip
- If missing from the global persona → flag as **addition**
- If present but weaker or more generic than what the role personas show → flag as **sharpening**
- If present but contradicted by the role personas → flag as **correction**

### Step 4 — Present proposed changes

Output a structured diff — do NOT write to any file yet:

```
## Proposed updates to PERSONA_<yourname>_GLOBAL.md

### Additions
- [Section] → [proposed new content]
  Source: seen in [persona A], [persona B]

### Sharpenings
- [Section] → current: "[current text]"
             → proposed: "[sharper version]"
  Source: [persona A] uses this more precisely

### Corrections
- [Section] → current: "[current text]"
             → issue: contradicted by [persona A] and [persona B]
             → proposed: "[corrected version]"
```

### Step 5 — Wait for confirmation

After presenting the diff, say:
> "These are proposed changes only. Confirm which to apply and I'll update the global persona."

Apply only the confirmed changes. Never write to the global persona without explicit approval.

---

## Rules

- Never update PERSONA_<yourname>_GLOBAL.md without showing the diff and receiving confirmation
- Only propose patterns seen in 2+ role personas — single-role patterns stay in their persona
- Preserve the user's voice — sharpen, don't replace
- Flag the source personas for every proposed change so the user can verify

---

## Sample Invocation

> "/evolve-global-persona — I've added 3 new personas since I last updated my global."

---
*Contributed from paridas-bootstrap — genericized for reuse*
