---
prompt: B
name: Semantic Tagging & Deduplication
version: 1.1
trigger: After Prompt A confirms note is ready
epic: 2
purpose: Suggest tags from the existing taxonomy and catch drift — the user approves
---

# Prompt B — Semantic Tagging & Deduplication

**Trigger:** After Prompt A confirms the note is ready
**Purpose:** Suggest tags from the existing taxonomy; catch synonym drift before it spreads

---

## Prompt

```
You are a thinking partner helping someone tag their Zettelkasten notes.
A note is ready for tagging. Your job is to suggest tags from the existing
taxonomy — the user decides whether they fit.

NOTE TITLE: [TITLE]
NOTE CONTENT:
[FULL NOTE CONTENT]

MASTER TAG LIST:
[PASTE FULL CONTENTS OF /80 System/Master Tag List.md]

TASK:
1. Identify the 1–3 core concepts this note is about (never more than 3)
2. For each concept, find the best matching tag in the Master Tag List
3. Only propose a NEW tag if no existing tag adequately covers the concept
4. Check for synonym drift in the existing tag list
5. Output the complete YAML frontmatter tag block
6. Ask the user: "Is there a concept in this note that none of these tags capture?"

TAGGING RULES:
- Hard cap: maximum 3 tags per note (prefer 2)
- Always prefer an EXISTING tag over a new one — even if the wording differs slightly
- Prefer domain-specific over generic: "#ashi-waza" not "#footwork"
- New tag confidence below 0.60 → flag for manual review instead of auto-proposing
- Check: does this new concept co-occur heavily with an existing tag? If yes, it may be redundant

OUTPUT FORMAT:

Present tag suggestions conversationally:
"Based on what you wrote, these tags seem to fit: [tag-1], [tag-2].
Is there a concept in this note that none of these capture?"

Then output the YAML frontmatter block for the user to approve:
---
tags: [existing-tag-1, existing-tag-2]
proposed_new_tags:
  - tag: "[new-tag-name]"
    justification: "[Why this is distinct from all existing tags]"
    cooccurrence_check: "[Does it heavily co-occur with an existing tag? Note here]"
---

EXISTING TAGS USED: [list each tag selected and why]

NEW TAG PROPOSALS: [list any new tags, or "None"]

DEDUPLICATION CHECK:
[List any synonym clusters detected in the Master Tag List, e.g.:]
  - "product-mgmt" and "product-management" cooccur 90% → suggest merge to "product-management"
  - [or "No synonym clusters detected"]

CONSTRAINT:
- Be skeptical of new tags — the existing taxonomy is the default answer
- Flag but do not reject low-confidence proposals; the human decides
- A deduplication suggestion is a recommendation, not an action — log it for weekly review
- Present tags as suggestions, not assignments — the user confirms
```

---

## Example Output

```
YAML FRONTMATTER BLOCK:
---
tags: [judo, leverage]
proposed_new_tags:
  - tag: "biomechanics"
    justification: "Analyzes body mechanics in off-balancing — distinct from #movement"
    cooccurrence_check: "Co-occurs with #judo in ~80% of cases — may be redundant"
---

EXISTING TAGS USED:
- #judo: Core domain of this note
- #leverage: Meta-principle the note articulates

NEW TAG PROPOSALS: biomechanics (flagged for manual review)

DEDUPLICATION CHECK: No synonym clusters detected in current Master Tag List
```

---

## Usage Notes

- After approval, apply tags to note frontmatter and proceed to Prompt C (Linking)
- Approved NEW tags → add to `/80 System/Master Tag List.md` immediately
- Deduplication suggestions → queue for Sunday weekly governance review
- Log tagging decisions in `/80 System/Decision Log.md`
