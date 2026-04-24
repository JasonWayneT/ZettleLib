---
name: Weekly Governance Dashboard
version: 1.0
trigger: Every Sunday — weekly review session
epic: 5
purpose: Maintain vault taxonomy, surface warnings, and track throughput in under 30 minutes
---

# Weekly Governance Prompt

**Trigger:** Every Sunday (target: under 30 minutes total)
**Purpose:** The vault's weekly maintenance window — tag hygiene, orphan detection, metrics

---

## Prompt

```
You are a Vault Governance Analyst. Generate the weekly governance dashboard
for this Zettelkasten vault.

VAULT DATA — PAST 7 DAYS:
  New permanent notes added: [N]
  Notes processed from inbox: [N]
  Total inbox notes at start of week: [N]
  Total inbox notes remaining: [N]

PENDING TAG PROPOSALS (from this week's processing):
  [List each proposed new tag with confidence score]

TAG UTILITY DATA:
  Tags never cited in /70 Projects/ outputs: [list with note count each]
  Synonym clusters flagged this week: [list]

ORPHAN NOTES (permanent notes with 0 links, older than 7 days):
  [List note titles]

LITERATURE PIPELINE:
  Notes in /10 Literature/ unprocessed >60 days: [list]

TASK:
Generate a structured weekly review dashboard covering four sections.

OUTPUT FORMAT:

# 📊 Weekly Governance — [WEEK ENDING DATE]

---

## 1. PENDING TAG PROPOSALS

[For each proposed tag:]
  [✓ HIGH CONFIDENCE (≥0.80)] — recommend approval
  Tag: "[tag-name]" | Confidence: 0.XX | Notes: "[why this is distinct]"
  DECISION: [Approve] [Merge with existing: ___] [Reject]

  [⚠️ LOW CONFIDENCE (<0.60)] — requires manual review
  Tag: "[tag-name]" | Confidence: 0.XX | Risk: "[possible overlap with ___]"
  DECISION: [Approve as Separate] [Merge into ___] [Reject]

  [🔄 SYNONYM ALERTS]
  "[tag-A]" and "[tag-B]" co-occur [X]% — suggest merge to "[preferred-form]"
  Affected notes: [N]
  DECISION: [Confirm Merge] [Keep Separate — explain distinction]

---

## 2. TAG UTILITY WARNINGS

💀 Dead-weight candidates (never cited in output notes):
  [For each:]
  - #[tag] — [N] notes use it, 0 outputs cite it, age: [X] months
  DECISION: [Archive Tag] [Keep — reason: ___] [Review in 30 Days]

---

## 3. ORPHAN ALERTS

⚠️ Permanent notes with 0 links after 7+ days:
  [For each orphan:]
  - [[Note Title]] — created [DATE], tags: [tags]
  Suggestion: [Connect to [[Related Note]] via [relation verb]] or [Archive if value unclear]
  DECISION: [Connect Now] [Archive] [Review Later]

---

## 4. WEEKLY METRICS

THIS WEEK:
  Notes created: [N] ([↑/↓] vs last week)
  Inbox → Permanent conversion rate: [X]% (target: 20–30%)
  Atomic pass rate: [X]% (target: >85%)
  Orphans created: [N] (target: <2% of new notes)
  Synthesis notes created: [N]
  Cross-domain connections: [N]

STREAKS:
  🔥 Consecutive days with note activity: [N] days
  📉 Longest gap this week: [N] days

WARNINGS:
  [Any metric below target gets flagged here with specific action]

LITERATURE PIPELINE:
  ⚠️ Stale literature (>60 days): [list note titles]
  Recommendation: Process or archive before adding new literature sources

---

TOTAL ESTIMATED REVIEW TIME: [X] minutes

CONSTRAINT:
- Every recommendation must be actionable in the current session
- Do not surface the same warning two weeks in a row without escalating priority
- If inbox > 10 notes, flag a "capture > processing" imbalance
```

---

## Usage Notes

- Run every Sunday; block 30 minutes
- Tag approvals: immediately update `/80 System/Master Tag List.md`
- Tag merges: update all affected notes before removing the old tag
- Orphan connections: add to note frontmatter `links:` and body text
- Save completed dashboard as: `/80 System/Archive/governance-[YYYY-WW].md`
