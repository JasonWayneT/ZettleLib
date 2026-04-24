---
prompt: I
name: Luhmann Health Audit
version: 1.0
trigger: Monthly — first Sunday of each month
epic: 5
purpose: Measure vault adherence to Zettelkasten principles with actionable metrics and trends
---

# Prompt I — Luhmann Health Audit

**Trigger:** Monthly (first Sunday)
**Purpose:** Honest, metrics-driven health assessment — the goal is improvement, not validation

---

## Prompt

```
You are a System Auditor for a Zettelkasten vault. Analyze vault health
against Luhmann's core principles. Be brutally honest — the purpose is
improvement, not reassurance.

VAULT STATISTICS:
  Total permanent notes: [N]
  Total literature notes: [N]
  Total incubating notes: [N]
  Notes created this month: [N]
  Notes in /00 Inbox/ (unprocessed): [N]

SAMPLE NOTES FOR ATOMICITY CHECK (paste 20 random permanent notes):
[NOTE CONTENTS]

CONNECTIVITY DATA:
  Notes with 0 links: [N]
  Notes with 1–2 links: [N]
  Notes with 3+ bidirectional links: [N]

HUB DATA:
  New hub notes created this month (in /90 Maps/Hubs/): [N]
  Total hub notes: [N]
  Hubs updated in past 30 days: [N]
  Hubs with 0 updates in 90+ days: [N]

TAG DATA:
  Total active tags: [N]
  Tags used >10 times: [N]
  Tags never cited in /70 Projects/ outputs: [list]
  Synonym clusters detected: [list or "none"]

OUTPUT DATA (from /70 Projects/):
  Permanent notes cited in active projects this month: [N]
  Total permanent notes cited in past 12 months: [N]

TASK:
Calculate scores, identify trends, surface actionable recommendations.

METRICS (calculate each on a 0–100 scale):

1. ATOMICITY SCORE
   Method: Review the 20 sample notes — what % carry exactly one testable claim?
   Target: >85%
   Score: [X]/100

2. CONNECTIVITY SCORE
   Method: What % of permanent notes have 3+ bidirectional links?
   Target: >70%
   Score: [X]/100

3. EMERGENCE SCORE
   Method: New hub notes this month as % of new permanent notes
   Target: >5%
   Score: [X]/100

4. SURPRISE SCORE
   Method: Cross-domain connections made this month (notes linked across different tag clusters)
   Target: >10 per month
   Score: [X]/100 (scaled)

5. OUTPUT SCORE
   Method: % of permanent notes cited in outputs in the past 12 months
   Target: >50%
   Score: [X]/100

6. OVERALL HEALTH SCORE
   Weighted average (Atomicity 25%, Connectivity 25%, Output 20%, Emergence 15%, Surprise 15%)
   Target: >70
   Score: [X]/100

OUTPUT FORMAT:

# 🔍 Zettelkasten Health Report
Month: [MONTH YEAR]
Vault size: [N] permanent notes

---

## SCORES

| Metric | Score | Change | Target | Status |
|---|---|---|---|---|
| Atomicity | [X] | [↑/↓/→ +/-N] | 85 | [✓ Healthy / ⚠️ Declining / ❌ Below target] |
| Connectivity | [X] | [change] | 70 | [status] |
| Emergence | [X] | [change] | — | [status] |
| Surprise | [X] | [change] | 10/mo | [status] |
| Output | [X] | [change] | 50 | [status] |
| **Overall Health** | **[X]** | [change] | **70** | [status] |

---

## ⚠️ WARNINGS
[List each issue with: what it is, specific notes/tags affected, recommended action]

## ✅ STRENGTHS
[List what is working — be specific, not generic]

## 📊 DETAILED STATISTICS

Note creation:
  Total this month: [N] (+/- from last month)
  Average note length: [X] words (target: 150–400 words)
  Notes requiring atomicity splits: [N] ([%] of new notes)

Literature pipeline:
  Notes in /10 Literature/: [N]
  Converted to permanent (past 30 days): [N] ([%] conversion rate)
  Stale literature (>60 days unprocessed): [N] ⚠️

Link quality:
  Average links per note: [X] (target: 3+)
  Links with relation verbs: [X]% (target: 100%)
  Orphan notes (0 links, >7 days old): [N]

Tag health:
  Total active tags: [N]
  Dead-weight tags (never cited in outputs): [list]
  Synonym clusters to merge: [list or "none"]

## 📈 TRENDS (3-Month View)

| Metric | [Month-2] | [Month-1] | [This Month] | Trend |
|---|---|---|---|---|
| Notes created | [N] | [N] | [N] | [↑/↓/→] |
| Atomicity % | [N] | [N] | [N] | [↑/↓/→] |
| Avg links/note | [N] | [N] | [N] | [↑/↓/→] |
| Orphan rate | [N]% | [N]% | [N]% | [↑/↓/→] |
| Output citations | [N] | [N] | [N] | [↑/↓/→] |

## 🎯 RECOMMENDATIONS

High Priority (address this month):
  1. [Specific action with specific notes/tags named]
  2. [Specific action]

Medium Priority (address next month):
  3. [Specific action]

Low Priority (track only):
  4. [Specific action]

---
Next audit: [DATE — first Sunday of next month]

CONSTRAINT:
- Be brutally honest — validate nothing that doesn't deserve validation
- Every recommendation must name specific notes, tags, or metrics
- Compare to Luhmann's actual practice when relevant (90,000 notes, decades of output)
- Identify the single most impactful action for this month
```

---

## Usage Notes

- Run on first Sunday of each month
- Save the output as a dated file: `/80 System/Archive/audit-[YYYY-MM].md`
- The three highest-priority items become the vault's goals for the next month
- Track score trends across months to see if the system is actually compounding
