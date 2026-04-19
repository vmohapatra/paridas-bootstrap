# Command: Create Persona

## Trigger
User says: "Create persona for: [role]" or "New persona: [role]"

---

## Phase 1 — Role Intake

When a role is provided, do NOT write the persona yet.

Ask one question at a time. Wait for the answer before asking the next. Adapt each question and its example to the specific role given.

**Question sequence:**

**Q1. Who is the audience?**
e.g. Age group, experience level, context (school / home / workplace)
> _Adapt: For a budget planner — "Who is in the household and what's their financial starting point?" For a language tutor — "How old are the students and what's their level?"_

*(Wait for answer, then ask Q2.)*

**Q2. What framework or method does this persona follow?**
e.g. A specific curriculum, philosophy, or structured approach
> _Adapt: For a budget planner — "50/30/20, zero-based, envelope method?" For a language tutor — "Comprehensible input, spaced repetition, grammar-first?"_
> If the user is unsure, suggest the best fit based on their Q1 answer.

*(Wait for answer, then ask Q3.)*

**Q3. What does this persona produce?**
List the output types — plans, feedback, drills, reviews, reports, scripts?
> _Adapt examples to the role. If user says "all of them", list the likely outputs for that role and confirm._

*(Wait for answer, then ask Q4.)*

**Q4. What tone and style?**
e.g. Strict and structured / warm and encouraging / Socratic / no-nonsense coach
> _Adapt: For a budget planner — "Strict accountability or non-judgmental and practical?" For a coach — "Direct and challenging or supportive and exploratory?"_

*(Wait for answer, then ask Q5.)*

**Q5. What are the top 3 failure modes to catch?**
What does bad output from this persona look like?
> _Adapt: For a budget planner — "No emergency fund before investing, ignoring irregular expenses, vague goals?" For a writing coach — "Vague feedback, rewriting instead of coaching, ignoring the author's voice?"_
> If user is unsure, suggest the 3 most common failure modes for that role and ask them to confirm or swap.

*(Wait for answer, then proceed to Phase 2.)*

---

## Phase 2 — Fine-Tune (optional)

After Q5 is answered, ask this only if a reference bank would meaningfully improve the persona:

> "One more thing — should this persona include a reference bank (benchmarks, rules, or data it always cites)? If yes, give me 3 examples of what should be in it."

Skip this if the role clearly doesn't need one or if the user has already provided enough reference material in their answers.

---

## Phase 3 — Write the Persona

Once all answers are received:

1. Write to `~/Desktop/ai/<yourname>/personas/PERSONA_[ROLE-SLUG].md`
2. Include all sections:
   - Overview (role, audience, what it optimises for)
   - Framework (the method/structure this persona follows)
   - Output types and their structure
   - Voice and Style
   - How This Persona Operates (behavioral rules)
   - Reference bank (if applicable)
   - Common Failure Modes table
   - When to Invoke / When NOT to Invoke
   - 3–4 Sample Invocations
3. Confirm file written and prompt: *"Persona is ready. Share something for me to work on and I'll show you how it runs."*

---

## Rules

- Ask one question at a time — never bundle multiple questions in one message
- Never write the persona before all Phase 1 answers are received
- Never ask more than 5 questions in Phase 1 — prioritise ruthlessly
- One follow-up maximum in Phase 2
- Adapt question examples to the specific role — don't use generic placeholders
- If the user skips a question, make a reasonable judgment call and note the assumption in the persona's Overview
- If the user seems unsure on any question, offer 2–3 options to choose from rather than waiting for them to generate an answer from scratch

---
*Contributed from paridas-bootstrap — genericized for reuse*
