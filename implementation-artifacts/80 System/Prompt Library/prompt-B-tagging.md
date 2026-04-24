---
prompt: B
name: Semantic Tagging & Deduplication
version: 1.0
trigger: After Prompt A → ATOMIC + PROMOTE
epic: 2
purpose: Prevent tag drift and enforce a canonical taxonomy across the vault
---

# Prompt B — Semantic Tagging & Deduplication

**Trigger:** After Prompt A confirms ATOMIC + PROMOTE
**Purpose:** Tag from a controlled taxonomy; detect and prevent synonym drift

---

## Prompt

```
You are a Taxonomy Architect for a Zettelkasten vault.
A note has passed atomicity check and is ready for tagging.

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

TAGGING RULES:
- Hard cap: maximum 3 tags per note (prefer 2)
- Always prefer an EXISTING tag over a new one — even if the wording differs slightly
- Prefer domain-specific over generic: "#ashi-waza" not "#footwork"
- New tag confidence below 0.60 → flag for manual review, do not auto-propose
- Check: does this new concept co-occur heavily with an existing tag? If yes, it may be redundant

OUTPUT FORMAT:

YAML FRONTMATTER BLOCK:
---
tags: [existing-tag-1, existing-tag-2]
proposed_new_tags:
  - tag: "[new-tag-name]"
    confidence: 0.XX
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
```

---

## Example Output

```
YAML FRONTMATTER BLOCK:
---
tags: [judo, leverage]
proposed_new_tags:
  - tag: "biomechanics"
    confidence: 0.67
    justification: "Analyzes body mechanics in off-balancing — distinct from #movement"
    cooccurrence_check: "Co-occurs with #judo in ~80% of cases — may be redundant"
---

EXISTING TAGS USED:
- #judo: Core domain of this note
- #leverage: Meta-principle the note articulates

NEW TAG PROPOSALS: biomechanics (0.67 — flagged for manual review)

DEDUPLICATION CHECK: No synonym clusters detected in current Master Tag List
```

---

## Usage Notes

- After approval, apply tags to note frontmatter and proceed to Prompt C (Linking)
- Approved NEW tags → add to `/80 System/Master Tag List.md` immediately
- Deduplication suggestions → queue for Sunday weekly governance review
- Log tagging decisions in `/80 System/Decision Log.md`
