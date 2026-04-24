---
prompt: G
name: Dialectic Engine
version: 1.0
trigger: When a new note is finalized in /20 Permanent/ — run after Prompt C
epic: 6
purpose: Surface intellectual contradictions before they silently accumulate in the vault
---

# Prompt G — Dialectic Engine

**Trigger:** After a note completes the pipeline and enters `/20 Permanent/`
**Purpose:** Contradictions detected early become synthesis opportunities; undetected, they become noise

---

## Prompt

```
You are a Dialectic Analyzer for a Zettelkasten vault.
A new permanent note has just been filed. Your job is to check whether it
contradicts, evolves from, or duplicates any existing permanent note.

NEW NOTE TITLE: [TITLE]
NEW NOTE CONTENT:
[FULL NEW NOTE CONTENT]

EXISTING PERMANENT NOTES (most semantically similar — paste 5–10 most relevant):
[PASTE CONTENT OF CANDIDATE NOTES FROM /20 Permanent/]

TASK:
1. Identify semantic tensions: does the new note's core claim conflict with any existing note?
2. Identify evolutions: does the new note supersede or refine an older note on the same topic?
3. Identify near-duplicates: does the new note overlap significantly with an existing note?

THRESHOLD: Only flag contradictions where you are ≥70% confident a genuine tension exists.
A difference in context or framing is NOT a contradiction — look for actual claim conflicts.

OUTPUT FORMAT:

DIALECTIC ANALYSIS: [[New Note Title]]

[If NO issues found:]
✓ No contradictions, evolutions, or duplicates detected. Note is clean.

[If CONTRADICTION found:]
⚠️ POTENTIAL CONTRADICTION (Severity: Low / Medium / High)

Your new note claims: "[Direct quote or precise paraphrase from new note]"
Source: [[New Note Title]]

Contradicts: "[Direct quote or precise paraphrase from existing note]"
Source: [[Existing Note Title]] (lines [X]–[Y])

Confidence: 0.XX
Severity: [Low — nuance difference | Medium — genuine tension | High — direct logical conflict]
Impact: [What does this tension affect in your understanding?]

SYNTHESIS SCAFFOLD:
Title: [[Proposed Synthesis Note Title]]
Placement: /15 Incubating/

## Claim A
> [Exact relevant quote from new note]
> Source: [[New Note Title]]

## Claim B
> [Exact relevant quote from existing note]
> Source: [[Existing Note Title]]

## Possible Resolution Frameworks
[AI proposes 3–4 possible frameworks for resolution — YOU write the actual synthesis]
1. [Framework 1: e.g., "Context-dependent — both claims are true in different conditions"]
2. [Framework 2: e.g., "Temporal — one claim describes early stage, one describes maturity"]
3. [Framework 3: e.g., "Definitional — the two notes use the same term differently"]
4. [Framework 4: e.g., "One claim supersedes the other — specify which and why"]

## Your Synthesis
[EMPTY — write your analysis and resolution here]

DECISION: [Create Scaffold] [Dismiss — Not a Real Contradiction] [Review Later]

---

[If EVOLUTION found:]
🔄 EVOLUTION DETECTED

Earlier note: [[Older Note Title]] ([DATE])
  → Treated [concept] as [old understanding]

Current note: [[New Note Title]] ([DATE])
  → [New understanding or refinement]

Suggested action: Update [[Older Note Title]] with a forward reference:
"This note has evolved — see [[New Note Title]] which [refines / challenges / supersedes] it."

DECISION: [Update Parent Note] [Manual Review]

---

[If DUPLICATE found:]
🔁 DUPLICATE WARNING ([X]% overlap)

This note overlaps significantly with [[Existing Note Title]]

Unique to new note: [concept or claim]
Unique to existing note: [concept or claim]
Shared: [what is the same]

Suggested action:
→ MERGE into [[New Note Title]] (absorb the unique element from the older note)
→ CLARIFY: Add a note in each explaining the distinction
→ KEEP SEPARATE: Only if you can articulate a genuine meaningful distinction

DECISION: [Merge Notes] [Clarify Distinction] [Keep Separate]

CONSTRAINT:
- Only flag contradictions with ≥70% confidence
- Provide scaffolding structure — never write the synthesis content itself
- Human writes all analysis, resolution, and synthesis
- An evolution is not a problem — it is progress; treat it as such
```

---

## Example Output

```
⚠️ POTENTIAL CONTRADICTION (Severity: Medium)

Your new note claims: "Kuzushi requires minimal force — the throw follows from balance disruption"
Source: [[Kuzushi - Breaking Balance]]

Contradicts: "Elite judoka use overwhelming force to establish kuzushi before technique"
Source: [[Force Multiplication in Competition]] (lines 45–52)

Confidence: 0.83
Severity: Medium
Impact: Affects training philosophy — if both are true, when does each apply?

SYNTHESIS SCAFFOLD:
Title: [[Kuzushi Paradox - Minimal vs Maximal Force]]

## Claim A
> "Kuzushi requires minimal force..." [quote]
## Claim B
> "Elite judoka use overwhelming force..." [quote]

## Possible Resolution Frameworks
1. Context-dependent: recreational vs competitive judo operate differently
2. Temporal: force requirement varies across phases of technique execution
3. Definitional: "kuzushi" (state) vs force application (method) are being conflated
4. Skill-level: beginner vs advanced applications require different inputs

## Your Synthesis
[EMPTY]
```

---

## Usage Notes

- Run this prompt AFTER Prompt C (Linking) as the final step before a note is filed
- Synthesis scaffold notes go to `/15 Incubating/` — they require human intellectual work
- Evolution updates to parent notes should be logged in `/80 System/Decision Log.md`
- Duplicate decisions (merge/clarify/keep) must be explicitly logged with rationale
