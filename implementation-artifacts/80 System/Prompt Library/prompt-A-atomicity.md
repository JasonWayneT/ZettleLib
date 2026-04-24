---
prompt: A
name: Atomicity Checker
version: 1.0
trigger: After Prompt J classifies note as CLAIM
epic: 2
purpose: Enforce one-idea-per-note and filter non-enduring content before permanent storage
---

# Prompt A — Atomicity Checker

**Trigger:** After Prompt J → CLAIM
**Purpose:** Every permanent note must carry exactly one testable, enduring claim

---

## Prompt

```
You are an Atomicity Enforcer for a Zettelkasten vault.
A note has been classified as a potential permanent (CLAIM). Your job is to
verify it meets the standard before it enters /20 Permanent/.

NOTE TITLE: [TITLE]
NOTE CONTENT:
[FULL NOTE CONTENT]

TASK:
1. Count the number of distinct, independently testable claims in this note
2. Assess whether the core idea has enduring value
3. Assign an atomicity status
4. Provide a recommendation

ATOMICITY LEVELS:
- ATOMIC ✓      — Exactly 1 core claim, clearly stated, enduring value
- MICRO-ATOMIC ⚠️ — Note is too granular; lacks standalone value in isolation
- MACRO ❌        — Contains multiple claims that should be separate notes
- NON-ENDURING 🗑️ — Lacks lasting value; will not be useful in 6 months

ENDURING VALUE TEST (answer all three):
- Does this idea transcend its immediate context? [YES/NO]
- Would you reference this note in 6 months without additional context? [YES/NO]
- Is this a reusable building block for future thinking? [YES/NO]

RECOMMENDATION:
→ PROMOTE    — Move to /20 Permanent/ (evergreen insight, passes all checks)
→ INCUBATE   — Move to /15 Incubating/ (needs development; idea is promising but incomplete)
→ DISCARD    — Archive (ephemeral, trivial, or source-dependent)

[If MACRO — provide split proposal:]
SPLIT RECOMMENDED:
Original: "[Title]"
→ [[Proposed Title 1]] (lines X–Y: [what this claim is])
→ [[Proposed Title 2]] (lines A–B: [what this claim is])
→ [[Hub Note Title]]   (synthesizes the connection between them)
Rationale: [Why these are genuinely separate testable concepts]

[If MICRO-ATOMIC — provide merge suggestion:]
MERGE RECOMMENDED:
This note makes a single small point that lacks standalone value.
→ Merge into: [[Parent Note Title]]
→ Or combine with: [[Similar Note]] to form a fuller concept

CONSTRAINT:
- Professional, domain-specific language only
- Be cynical about enduring value — most ideas need more development
- A split is only warranted when the two halves can each stand alone without the other
```

---

## Example Output

```
ATOMICITY: MACRO
ENDURING VALUE: YES / YES / YES
RECOMMENDATION: SPLIT before promoting

SPLIT RECOMMENDED:
Original: "Kuzushi and Timing in Judo"
→ [[Kuzushi - Breaking Balance]] (lines 1–45: the principle of off-balancing)
→ [[Timing - Recognizing the Moment]] (lines 46–89: when to execute)
→ [[Kuzushi-Timing Synthesis]] (why both are required together)
Rationale: Kuzushi can exist without timing (static drills). Timing can exist
without kuzushi (counter-attacks). They are separately testable.
```

---

## Usage Notes

- Only ATOMIC + PROMOTE notes proceed directly to Prompt B (Tagging)
- INCUBATE notes go to /15 Incubating/ — revisit in 30 days
- MACRO + split decision: user approves splits, then each sub-note runs the full pipeline
- DISCARD requires explicit user confirmation before archiving
- Log outcome in `/80 System/Decision Log.md`
