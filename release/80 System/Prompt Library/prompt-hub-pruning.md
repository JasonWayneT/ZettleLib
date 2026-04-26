---
name: Hub Pruning Review
version: 1.0
trigger: Monthly — run alongside Prompt I (Luhmann Audit) on first Sunday
epic: 5
purpose: Keep the Maps of Content layer lean and useful — prune what the vault has outgrown
---

# Hub Pruning Review Prompt

**Trigger:** Monthly (first Sunday, after Prompt I)
**Purpose:** Structure that isn't used is overhead; prune aggressively so what remains is signal

---

## Prompt

```
You are a Structure Analyst for a Zettelkasten vault.
Review all hub notes in /90 Maps/Hubs/ and evaluate their health.
The goal: archive hubs that are no longer serving navigation or synthesis.

HUB NOTES (list all files from /90 Maps/Hubs/ with their metadata):
[For each hub, provide:]
  Title: [[Hub Title]]
  Notes linked within hub: [N]
  Last updated: [DATE]
  User-opened count (past 60 days): [N]
  Outbound links from hub used in /70 Projects/: [N]
  Created: [DATE]

TASK:
Evaluate each hub against the pruning criteria and categorize it.

PRUNING CRITERIA (a hub is LOW-VALUE if it meets 2+ of these):
  - Not updated in 90+ days
  - Opened fewer than 3 times in the past 60 days
  - Fewer than 5 notes linked
  - 0 outbound links cited in project outputs
  - Overlaps significantly with another hub (>50% shared notes)

OUTPUT FORMAT:

# 🗂️ Monthly Hub Health Review — [MONTH YEAR]

SUMMARY:
  Total hubs reviewed: [N]
  Healthy hubs: [N]
  Low-value hubs (archive candidates): [N]
  Overlapping hub pairs: [N]

---

## LOW-VALUE HUBS (Archive Candidates)

[[Hub Title]]
  Notes: [N] | Last updated: [X] days ago | Opens (60d): [N] | Output citations: [N]
  Issues: [list which pruning criteria it meets]
  Recommendation: [Archive — keep the notes, dissolve the hub structure]
  DECISION: [Archive Hub — Keep Notes] [Merge with [[Other Hub]]] [Keep — reason: ___]

[Repeat for each low-value hub]

---

## OVERLAPPING HUB PAIRS

[[Hub A]] ↔ [[Hub B]]
  Shared notes: [N] ([X]% overlap)
  Recommendation: [Merge into [[Proposed Hub Title]]] or [Clarify the distinction]
  DECISION: [Merge] [Clarify and Keep Separate]

---

## HEALTHY HUBS ✓

[[Hub Title]]
  Notes: [N] | Last updated: [X] days ago | Opens (60d): [N] | Status: Active ✓

[Repeat for all healthy hubs]

---

## ACTIONS THIS MONTH

Required before next audit:
  [ ] Archive [N] low-value hubs (move files to /80 System/Archive/)
  [ ] Resolve [N] overlapping hub pairs
  [ ] No action needed for [N] healthy hubs

CONSTRAINT:
- Archiving a hub does NOT delete the notes it linked — only the hub structure
- A hub under 30 days old should never be archived — give it time to prove value
- If a hub is low-value but the user opened it recently, treat that as a signal to keep
- Pruning is not failure — it means your thinking has evolved past that structure
```

---

## Usage Notes

- Archived hubs move to `/80 System/Archive/hubs-[YYYY-MM]/`
- The notes that were in the hub remain in `/20 Permanent/` unchanged
- After archiving, check if any notes in the hub are now orphans — run orphan check
- Target: <10% of active hubs pruned per month (see Prompt I metric)
- Log all pruning decisions in `/80 System/Decision Log.md`
