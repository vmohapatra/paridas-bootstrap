# Claude as Your Professional OS — Advanced Workflow Patterns

*Eight patterns for using Claude as a persistent thinking partner across your professional life — not just a coding assistant.*

These patterns go beyond "ask Claude a question." They treat Claude as a system you configure and maintain over time, where each session builds on the last. None of this requires code. All of it applies to knowledge workers, engineers, managers, and anyone with complex recurring professional relationships.

---

## Table of Contents

1. [The Persona File Pattern](#1-the-persona-file-pattern)
2. [The Debrief → Track → Update Loop](#2-the-debrief--track--update-loop)
3. [The Learning File Case Library](#3-the-learning-file-case-library)
4. [The 3-Variant Draft Pattern](#4-the-3-variant-draft-pattern)
5. [Behavioral Analysis as a Distinct Mode](#5-behavioral-analysis-as-a-distinct-mode)
6. [Skills as Encoded Discipline](#6-skills-as-encoded-discipline)
7. [The Propose-Before-Execute Contract](#7-the-propose-before-execute-contract)
8. [MEMORY.md as a Thinking Partner Across Time](#8-memorymd-as-a-thinking-partner-across-time)

---

  What's in it:

  ┌────────────────────────────────────┬─────────────────────────────────────────────────────────┐
  │              Pattern               │                     What it covers                      │
  ├────────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ 1. Persona File Pattern            │ Structure, what to include, how to wire it to CLAUDE.md │
  ├────────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ 2. Debrief → Track → Update Loop   │ The 4-step loop, file naming, what a debrief produces   │
  ├────────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ 3. Learning File Case Library      │ Folder structure, file types, synthesis prompts         │
  ├────────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ 4. 3-Variant Draft Pattern         │ A/B/C format, when to use each, the no-hedging rule     │
  ├────────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ 5. Behavioral Analysis Mode        │ One-sentence driver, evidence, practical implications   │
  ├────────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ 6. Skills as Encoded Discipline    │ Rigid vs flexible, skill template, category table       │
  ├────────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ 7. Propose-Before-Execute Contract │ Reversibility principle, what triggers a pause          │
  ├────────────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ 8. MEMORY.md Across Time           │ What to save vs not, maintenance discipline             │
  └────────────────────────────────────┴─────────────────────────────────────────────────────────┘

---

## 1. The Persona File Pattern

### What it is

A structured profile for each recurring person in your professional life — your manager, key peers, stakeholders, reviewers — that Claude reads before any interaction involving them.

The file answers: *How does this person operate? What do they respond to? What backfires? What should I know before I walk into a meeting with them?*

### Why it works

Without a persona file, Claude answers every question about a person from scratch, with no continuity. With one, Claude brings accumulated understanding to every coaching session, draft, or analysis involving that person — and improves it over time.

### What to put in a persona file

```
## [Person's Name] — [Role / Relationship]

### How they operate
- Decision-making style (data-driven, intuition-led, consensus-seeking)
- Communication preferences (direct, indirect, formal, async vs sync)
- What they care about most (delivery speed, quality, visibility, relationships)
- What they respond well to (specific evidence, peer validation, framing)

### What backfires
- Language or approaches that reliably cause friction
- Topics or framing that triggers defensiveness
- Common misreads (what looks like X but is actually Y)

### Patterns observed
- Behavioral patterns confirmed across multiple interactions
- How they behave under pressure vs at ease
- Known triggers and de-escalation moves

### Stay Prepared
- What to know before any meeting with this person
- What questions they're likely to ask
- What materials to have ready
```

### How to use it

Add to your global CLAUDE.md:
```
Before responding to any question involving [person's name],
read ~/ai/personas/PERSONA_[NAME].md first.
```

Claude will read the file and apply the context before producing any output — coaching advice, draft messages, analysis, or prep.

### What makes a good persona file

- **Evidence-based, not speculative.** Record what actually happened, not what you think they meant.
- **Updated after significant interactions.** The file should get sharper over time, not stale.
- **Behavioral, not emotional.** "Opens confrontationally, backs down with calm factual response" is useful. "Is difficult and political" is not.
- **Forward-looking.** The goal is to anticipate, not to vent.

---

## 2. The Debrief → Track → Update Loop

### What it is

After any significant professional interaction — a hard meeting, a tense conversation, a performance review, a conflict — run a structured debrief with Claude that extracts patterns, updates the relevant persona file, and sets a forward posture.

This turns one-off events into accumulated intelligence.

### Why it works

Most professional learning evaporates. You have a difficult meeting, you process it informally, and a week later the details are gone. The debrief loop captures patterns while they're fresh and routes them into the right file so they're available the next time you need them.

### The loop

**Step 1 — Debrief prompt:**
```
Here's what happened in today's [meeting/conversation/review].
[Paste notes or describe the interaction.]

What does this reveal about [person]'s pattern?
What's new that I haven't seen before?
What should I expect next, and what should I prepare?
```

**Step 2 — Extract patterns:**
Claude identifies what's new vs what confirms existing patterns.
New patterns go into the persona file. Confirmed patterns get reinforced.

**Step 3 — Set forward posture:**
Claude states: what to expect next, what to prepare, what to watch for.
This becomes the opening of the next prep session with that person.

**Step 4 — Update the file:**
Add new patterns to the persona file. Date them. Note the source interaction.

### What a debrief produces

- New behavioral patterns observed (add to persona file)
- Confirmation or correction of existing patterns (update or remove from file)
- Forward posture: what the event signals about what comes next
- Any file updates needed (persona, learnings, MEMORY.md)

### File naming for debrief records

```
YYYY-MM-DD-[person]-[type].md

Types:
  sync-prep       preparation before a meeting
  debrief         what happened and what it reveals
  decision        a decision made and its reasoning
  conflict        a conflict arc and how it resolved
```

---

## 3. The Learning File Case Library

### What it is

A personal case library — a folder of dated files capturing significant professional events, decisions, and interactions. Not a diary. A structured reference you can search, summarize, and build on.

### Why it works

Professionals make the same mistakes and face the same dynamics repeatedly because they don't have a system for retaining what they learned. The case library gives you a searchable record of: what happened, what it revealed, and what you'd do differently.

### Folder structure

```
~/ai/learnings/
  2024-03-15-manager-promo-conversation-debrief.md
  2024-04-02-peer-conflict-resolution-decision.md
  2024-05-10-stakeholder-sync-prep.md

~/ai/insights/
  2024-Q1-insights-report.md
  2024-Q2-insights-report.md
```

**Key distinction:** Learnings are case-specific. Insights reports are synthesized patterns across cases. Keep them separate.

### What goes in a learning file

```markdown
# [Event name] — [Date]

**Type:** debrief / sync-prep / decision / conflict
**People:** [who was involved]

## What happened
[Factual account — what was said, what was decided]

## What it reveals
[Behavioral patterns, motivations, dynamics]

## What worked
[What approach landed well and why]

## What to do differently
[What you'd change with hindsight]

## Forward posture
[What to expect next, what to prepare]
```

### How to use the library

Ask Claude to synthesize across files:
```
Read my learnings from the past 3 months about [person/topic].
What patterns are consistent? What's evolved? What should I prepare for?
```

Or use it for prep:
```
I have a 1:1 with [person] tomorrow.
Read the relevant learnings and persona file and tell me what to be ready for.
```

---

## 4. The 3-Variant Draft Pattern

### What it is

For any professional communication — a Slack message, email, PR comment, performance feedback, response to criticism — always produce three variants:

- **Variant A — Direct, no hedging.** The point, stated once, cleanly. No qualifiers, no preamble.
- **Variant B — Direct, softer framing.** Same substance as A. Observation framing, collegial tone. Changes how it lands, not what it says.
- **Variant C — Blunt.** Minimum words. No framing. The shortest possible version that makes the point.

### Why it works

Producing one draft and iterating toward "better" is a trap — you optimize within the framing of the first draft. Producing three forces you to see the same message from different angles, and the contrast makes the right choice obvious.

Variant B is not a weaker version of A — it's a different delivery of the same position. "Softer framing, same substance" is the discipline.

### How to invoke it

```
Draft a response to this message. Give me three variants:
A — direct and precise, no hedging
B — same substance, softer framing
C — blunt, minimum words

Message: [paste message here]
```

### What makes a good variant

- **No hedging in any variant.** "I think", "maybe", "sort of" don't appear in A, B, or C. Mark genuine uncertainty explicitly ("not confirmed yet") rather than softening with filler.
- **One ask per message.** One clear request lands better than a pile-on.
- **Match the weight of the original.** A one-line Slack message gets a one-line reply. Don't over-respond.
- **No preamble, no pleasantries.** Lead with the point.

### When to use which variant

| Situation | Recommended variant |
|-----------|-------------------|
| Peer you have strong rapport with | A or C |
| Someone senior you need to influence | B |
| Documentation, tickets, PR comments | A |
| High-stakes conflict | B (softer landing, same position) |
| Quick async Slack | C |

You pick, blend, or use A/B as a starting point. The comparison is what makes you choose better.

---

## 5. Behavioral Analysis as a Distinct Mode

### What it is

A specific way of using Claude to read someone's behavior — not to vent, not to get validation, but to get a clean analytical read: *What is actually driving this? What does it mean practically?*

### Why it works

When someone does something unexpected, frustrating, or confusing, the instinct is to react emotionally or to assign the most flattering or most threatening interpretation. Behavioral analysis forces a different question: *What is the most plausible explanation given all the evidence?*

A good behavioral read is more useful than validation or commiseration. It tells you what to expect next and what moves are available.

### How to invoke it

```
What do you make of [person]'s behavior in this situation?

[Describe what happened — specific actions, words, sequence of events]

Read their persona file first: ~/ai/personas/PERSONA_[NAME].md
```

### What a good behavioral analysis looks like

1. **One-sentence driver.** "This is not about X — it's about Y." Name the most plausible motivation directly.
2. **Evidence.** "The tell is: they did X even though Y would have served the stated goal." Specific, not general.
3. **Practical implications.** What to expect next. What counter-moves are available.
4. **No moralizing.** The analysis doesn't judge — it reads. A clear read is more useful than a hedged one.

### When to use it vs coaching

| Use behavioral analysis | Use coaching |
|------------------------|--------------|
| "What is driving their behavior?" | "How should I respond?" |
| "Is this genuine or strategic?" | "What should I say?" |
| "What will they do next?" | "How do I handle this situation?" |

You often need both — analyze first, then coach.

### On ambiguous evidence

If the evidence genuinely supports two readings, name both and say which is more likely and why. Don't collapse ambiguity artificially. Don't leave it unresolved either — pick the more likely read and flag the uncertainty explicitly.

---

## 6. Skills as Encoded Discipline

### What it is

Skills are structured workflow prompts that encode the discipline you want to follow — the process you'd apply if you were at your best, not just your fastest.

The insight: under pressure, you skip steps. Skills make skipping harder by making the steps explicit and automatically triggered.

### Why it works

A skill for "brainstorm before coding" doesn't just remind you to brainstorm — it runs the brainstorming process end to end, asks the right questions, and won't proceed to implementation until the design is approved. The discipline is in the skill, not in your willpower.

### What makes a good skill

**Encode the full process, not just the reminder.** A skill that says "remember to write tests first" is weak. A skill that runs the TDD loop — writes failing test, confirms it fails for the right reason, writes minimum code, confirms green, refactors — is strong.

**Rigid vs flexible:**
- **Rigid skills** (TDD, debugging, verification before completion) — follow exactly. These exist because the discipline breaks down under pressure.
- **Flexible skills** (communication style, code review approach) — adapt principles to context.

**Trigger description matters.** Claude uses the description to decide when to auto-invoke. Be specific about what situations should trigger the skill.

### Skill categories worth building

| Category | Examples |
|----------|---------|
| **Process discipline** | Brainstorm before building, TDD loop, verify before claiming done |
| **Communication** | 3-variant draft, upward framing, conflict response |
| **Review** | PR self-review, code review checklist, design review |
| **Professional workflows** | Debrief template, prep template, decision framework |
| **Personal coaching** | Behavioral analysis, career decision framework |

### A minimal skill template

```markdown
---
name: skill-name
description: Use when [specific trigger situation]. Triggers on phrases like "[example]" and "[example]".
---

## What This Skill Does
[One paragraph — what it accomplishes and why it matters]

## Process
1. [First step — specific and actionable]
2. [Second step]
3. [Continue until the workflow is complete]

## What Good Output Looks Like
[Describe what the end state should be — makes it easier to verify]
```

---

## 7. The Propose-Before-Execute Contract

### What it is

An explicit set of rules — written in your CLAUDE.md — that define when Claude must stop and propose an approach before taking action, versus when it can proceed autonomously.

### Why it works

The default behavior of capable AI agents is to proceed efficiently. That's useful for low-stakes reversible actions. It's dangerous for high-stakes or hard-to-reverse ones. The contract makes the boundary explicit so you don't discover it after something goes wrong.

### What triggers a pause

Define your own list. Common categories:

```markdown
## Propose Before Execute

Before doing any of the following, state the approach and wait for confirmation:

- Dependency or version upgrades (propose version and migration path first)
- Changes affecting more than [N] files
- Changes to shared infrastructure or configuration
- Creating new branches (confirm branch name and base branch)
- Any destructive operation (deleting files, dropping data, resetting state)
- Anything visible to others (commits, pushes, messages, PR comments)
```

### The key principle

**Reversibility determines autonomy.** The more irreversible an action, the more it warrants a pause. Editing a local file: proceed. Pushing to a shared branch: propose first. Sending a message: always confirm.

### What the proposal should include

When Claude proposes an approach, it should state:
- **What** it's about to do
- **Why** (the reasoning)
- **Risks** (what could go wrong)
- **Alternatives considered** (if relevant)

This isn't bureaucracy — it's the minimum information needed to give informed approval.

---

## 8. MEMORY.md as a Thinking Partner Across Time

### What it is

A persistent memory file that Claude reads at the start of every session. Where persona files track other people, MEMORY.md tracks your own working context — patterns you've confirmed, decisions you've made, conventions you've established, and things you don't want to re-explain every session.

### Why it works

Without persistent memory, every Claude session starts from zero. You re-explain your stack, your preferences, your context. With MEMORY.md, the session starts informed — Claude already knows what matters.

More importantly: knowledge accumulated in one session doesn't evaporate. Debugging insights, reviewer patterns, architectural decisions, communication learnings — they compound over time instead of resetting.

### Structure

```markdown
# MEMORY.md

## Last Updated
[Date]

## What This Project / Context Is
[One paragraph — what you're working on and why it matters]

---

## Key Patterns (confirmed across multiple sessions)
- [Pattern name]: [what you've confirmed is true and reliable]

## Architecture / Key Files
- [File or component]: [what it does and why it matters]

## Conventions Established
- [Convention]: [why it was decided]

## Recurring Problems + Solutions
- [Problem]: [solution that worked]

## What NOT to Save
- Session-specific task state
- Speculative conclusions from one interaction
- Anything that duplicates CLAUDE.md
```

### What to save vs not

| Save | Don't save |
|------|-----------|
| Confirmed patterns (seen 2+ times) | Current task details |
| Key decisions and their reasoning | In-progress work state |
| Reviewer/collaborator patterns | Speculative conclusions |
| Solutions to recurring problems | Things that duplicate CLAUDE.md |
| Important file paths and architecture | Session summaries |

**The test:** Would this still be relevant in three months? If yes, save it. If it's specific to the current task, don't.

### Maintenance discipline

- **Update after sessions where something new was confirmed.** One or two bullets, not a full rewrite.
- **Remove entries that turn out to be wrong.** Incorrect memory is worse than no memory.
- **Keep it concise.** MEMORY.md loads into every session — if it grows too long, it crowds out working context. Link to topic-specific files for detail.

---

## Putting It Together

These eight patterns compose. A typical professional workflow using all of them:

```
Before a high-stakes meeting:
  → Read relevant persona file (Pattern 1)
  → Ask Claude to prep based on past learnings (Pattern 3)
  → If you need to send something beforehand: 3-variant draft (Pattern 4)

After the meeting:
  → Run a debrief (Pattern 2)
  → Extract new patterns → update persona file (Pattern 2)
  → Add a learning file to the case library (Pattern 3)
  → Update MEMORY.md if anything significant was confirmed (Pattern 8)

If something unexpected happened:
  → Behavioral analysis to understand it clearly (Pattern 5)
  → Coaching to decide how to respond (use personal-coach skill, Pattern 6)
  → Draft the response: 3 variants (Pattern 4)

Before any significant action (code, communication, decision):
  → Propose-before-execute check (Pattern 7)
  → If building something new: brainstorming skill before any implementation (Pattern 6)
```

The investment is front-loaded — setting up persona files and MEMORY.md takes time. The return compounds: every session gets faster, more accurate, and more useful than the last.

---

*This guide documents workflow patterns observed in practice. The patterns are tool-agnostic — they apply to Claude Code, Claude.ai, or any AI assistant that supports persistent context and custom instructions.*