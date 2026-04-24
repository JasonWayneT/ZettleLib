# ZettleLib Workflow Guide

This guide walks through the complete ZettleLib workflow — from capturing a note to monthly vault health reviews. Each phase maps to a specific prompt in the Prompt Library.

---

## The Note Processing Pipeline

```
Capture → Triage (J) → Atomicity (A) → Tagging (B) → Linking (C) → Dialectic (G) → Hub Tracking (D) → Done
```

### Phase 1: Capture

**What you do:** Write a note in `/00 Inbox/`. No formatting, no tagging, no linking. Just capture the thought.

**Philosophy:** Writing and organizing are separate cognitive modes. Don't mix them.

**Time cost:** 0–5 seconds

---

### Phase 2: Triage (Prompt J)

**What the AI does:** Classifies your inbox note into one of four categories:

| Category | Destination | What happens next |
|---|---|---|
| DELETE | Archived with reason | Nothing — ephemeral thought removed |
| TASK | Task manager | Actionable item exits the vault |
| SOURCE | `/10 Literature/` | Kept as source-bound reference |
| CLAIM | Continues to Phase 3 | Original insight enters the pipeline |

**Your decision:** Accept or override the classification.

**Expected rate:** Only 20–30% of inbox items should become CLAIMs.

**Time cost:** 5–15 seconds per note

---

### Phase 3: Atomicity Check (Prompt A)

**What the AI does:** Verifies the CLAIM carries exactly one testable, enduring idea.

| Assessment | Meaning | Action |
|---|---|---|
| ATOMIC ✓ | One claim, enduring value | Proceeds to tagging |
| MICRO-ATOMIC ⚠️ | Too granular, no standalone value | Merge into a parent note |
| MACRO ❌ | Multiple claims bundled | Split into separate notes |
| NON-ENDURING 🗑️ | Won't matter in 6 months | Archive or incubate |

**Your decision:** Accept the assessment, approve splits/merges, or override.

**Time cost:** 30–60 seconds

---

### Phase 4: Semantic Tagging (Prompt B)

**What the AI does:**
1. Assigns 1–3 tags from the Master Tag List
2. Proposes new tags with confidence scores if needed
3. Checks for synonym drift in existing tags

**Your decision:** Approve tags. Approve or reject new tag proposals.

**After approval:** New approved tags are added to `/80 System/Master Tag List.md`.

**Time cost:** 10–20 seconds

---

### Phase 5: Link Discovery (Prompt C)

**What the AI does:**
1. Finds up to 3 direct connections (shared domain)
2. Finds up to 2 weak signal connections (cross-domain)
3. Each link includes: target note + relation verb + one-sentence rationale + confidence

**Relation verbs:** extends, contradicts, applies, exemplifies, refines, supports, analogizes, inverts, parallels

**Your decision:** Accept, reject, or modify each proposed link.

**Time cost:** 20–40 seconds

---

### Phase 6: Dialectic Check (Prompt G)

**What the AI does:** Compares the new note against existing permanent notes for:
- **Contradictions** — creates synthesis scaffolds (you write the resolution)
- **Evolutions** — suggests updating older parent notes with forward references
- **Duplicates** — recommends merge or clarification

**Your decision:** Create synthesis scaffolds, dismiss, or defer.

**Time cost:** 15–30 seconds (or more if creating synthesis)

---

### Phase 7: Hub Tracking (Prompt D)

**What the AI does:** Checks if any tag cluster has reached the hub creation threshold (varies by vault size). If yes, proposes a hub structure.

**Your decision:** Create hub, defer, or dismiss.

**Time cost:** 15–30 seconds

---

### Phase 8: Completion

**What happens automatically:**
1. Note frontmatter is updated with all approved metadata
2. All decisions are logged in `/80 System/Decision Log.md`
3. Master Tag List is updated if new tags were approved
4. Hub file is created if approved

**Total pipeline time:** 90 seconds – 3 minutes per note (vs 5–10 minutes manual)

---

## Daily Maintenance

Run once daily (morning recommended). Say: **"daily review"**

### Serendipity Engine (Prompt E)
- Surfaces 3 non-obvious connections between older notes and recent ones
- Ignores direct links and shared tags — looks for structural parallels
- Minimum confidence: 0.60

### Elaboration Suggester (Prompt F)
- Identifies permanent notes stable >60 days with 0 child notes
- Suggests Narrow / Broaden / Challenge directions
- Goal: prevent good ideas from stagnating

**Time cost:** 5–10 minutes

---

## Weekly Governance

Run every Sunday. Say: **"weekly review"**

**Covers:**
1. Pending tag proposals — approve, merge, or reject
2. Tag utility warnings — tags used in notes but never in outputs
3. Orphan alerts — permanent notes with 0 links after 7+ days
4. Weekly metrics — creation rate, conversion rate, atomic pass rate

**Time cost:** Under 30 minutes

---

## Monthly Audit

Run first Sunday of each month. Say: **"monthly audit"**

### Luhmann Health Audit (Prompt I)
Six metrics scored 0–100:
1. **Atomicity** — % of notes with exactly one testable claim (target: >85%)
2. **Connectivity** — % of notes with 3+ bidirectional links (target: >70%)
3. **Emergence** — new hub notes as % of new permanent notes (target: >5%)
4. **Surprise** — cross-domain connections made (target: >10/month)
5. **Output** — % of permanent notes cited in projects (target: >50% per year)
6. **Overall Health** — weighted composite (target: >70)

### Hub Pruning Review
- Archive hubs that haven't been updated in 90+ days and are rarely opened
- Merge overlapping hubs
- Verify healthy hubs are still serving navigation and synthesis

**Time cost:** 30–45 minutes

---

## Writing Projects

When ready to write. Say: **"outline: [topic]"**

### Outline Generator (Prompt H)
- Searches vault for all relevant permanent notes
- Builds structured outline with per-section word estimates
- Identifies gaps (concepts referenced but not written as standalone notes)
- Provides readiness assessment

**After outline approval:**
1. Create project folder in `/70 Projects/[project-name]/`
2. Save outline as `outline.md`
3. Create empty `draft.md`
4. Write gap notes if any are marked "Critical"
5. Draft using wikilinks to cite permanent notes throughout

---

## Git Workflow

**Before every processing session:**
```bash
git add -A && git commit -m "Pre-processing snapshot"
```

**After every processing session:**
```bash
git add -A && git commit -m "Processed [note name] — [summary]"
```

**To rollback a bad decision:**
```bash
git log --oneline -10          # Find the commit before the bad session
git revert [commit-hash]       # Reverse that specific session
```
