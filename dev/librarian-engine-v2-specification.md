# Librarian Engine V2: Complete System Specification

**An Autonomous Knowledge Management System for Zettelkasten**

---

**Version:** 1.0 (Final Draft for Review)  
**Date:** April 22, 2026  
**Status:** Ready for Implementation  
**Philosophy:** AI = Socratic Partner, Human = Intellectual Lead
**Implementation:** Pure Instruction Layer (Markdown Configs) + LLM CLI/Local Server

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Why This System Exists](#why-this-system-exists)
3. [System Architecture](#system-architecture)
4. [The Prompt Library](#the-prompt-library)
5. [Note Metadata Schema](#note-metadata-schema)
6. [Core Workflow](#core-workflow)
7. [Advanced Features](#advanced-features)
8. [Technical Implementation](#technical-implementation)
9. [Success Metrics](#success-metrics)
10. [Rollout Plan](#rollout-plan)
11. [Philosophy & Design Principles](#philosophy-and-design-principles)
12. [Appendix: Key Changes from Initial Design](#appendix-key-changes-from-initial-design)

---

## Executive Summary

We're building a **Socratic knowledge management system** that implements the Zettelkasten method using an LLM instruction layer to eliminate manual filing friction while preserving—and enhancing—the core thinking benefits of the original method.

### Core Philosophy

**AI handles retrieval and Socratic questioning. Human handles intellectual decisions.**

### Key Innovation

Unlike static note-taking apps or "automated" classifiers, this system acts as a thinking partner that asks targeted questions to help users discover atomicity, connections, and contradictions.

### Implementation Approach

- **Platform:** Obsidian (vault interface) + LLM Instruction Files (configs)
- **AI Model:** Gemini 1.5 Pro/Flash, Claude 3.5, or local Llama 3/Gemma 2
- **Cost:** $0/month (local or free-tier API)
- **Time Saved:** ~15 hours/month on organizational overhead
- **Time Invested:** ~2 hours/month on synthesis and review

---

## Why This System Exists

### The Problem with Traditional Zettelkasten

- **Manual overhead kills momentum:** Luhmann spent hours filing cards. Most people quit after 50 notes.
- **Tag drift is inevitable:** "Product," "Product-Mgmt," "ProductManagement" all mean the same thing, but your vault doesn't know that.
- **Link rot compounds:** Orphaned notes accumulate. Connection opportunities go unnoticed.
- **Discovery requires memory:** You can't remember which notes relate to your current thought.

### The Problem with Automated Systems

- **Over-automation removes thinking:** If AI does everything, you're just hoarding, not learning.
- **No epistemological rigor:** Apps don't distinguish between fleeting thoughts and validated insights.
- **False confidence:** Systems that auto-tag without oversight create noise, not structure.

### Our Solution

A **state-aware taxonomy system** that:

1. Facilitates filing decisions through Socratic questioning
2. Guides atomicity discovery and prevents bloated notes
3. Surfaces non-obvious connections across conceptual domains
4. Tracks idea evolution from fleeting → permanent → published
5. Maintains a "Parked Questions Index" for unresolved inquiries
6. Ensures context preservation via "Processing Summaries"
7. Maintains audit trails so AI actions are reversible via Git

**Cost:** $0/month using local Gemma 4 models  
**Time saved:** ~15 hours/month on organizational overhead  
**Time invested:** ~2 hours/month on governance and review

---

## System Architecture

### File System Structure

```
/Personal Vault
├── 00 Inbox/                    # Fleeting notes (raw capture)
├── 10 Literature/               # Source-based notes (books, articles)
├── 15 Incubating/              # Ideas under active development
├── 20 Permanent/               # THE WIKI (Atomic, evergreen notes)
│   ├── Judo/
│   ├── Product Management/
│   └── Zettelkasten/
├── 70 Projects/                # Active writing projects (essays, articles)
│   ├── judo-product-article/
│   │   ├── outline.md
│   │   ├── draft.md
│   │   └── linked-notes/
├── 80 System/                  
│   ├── Master Tag List.md      # AI-maintained canonical taxonomy
│   ├── Prompt Library/         # Versioned prompts for Gemma
│   ├── Decision Log.md         # Audit trail of all AI actions
│   ├── Archive/
│   │   └── tags-[YYYY-MM].md  # Historical taxonomy snapshots
│   └── rollback.sh            # Emergency restoration script
└── 90 Maps/                    
    ├── Indexes/                # Thin entry points (navigation)
    │   ├── Judo.md
    │   └── Product.md
    └── Hubs/                   # Thick synthesis notes (thinking)
        ├── Judo Principles Applied Elsewhere.md
        └── Decision-Making Frameworks.md
```

### Design Principles

#### Folder Organization
- **00 Inbox:** Promiscuous capture, no friction
- **10 Literature:** Source-bound notes (retain context from books, articles)
- **15 Incubating:** Ideas being actively developed (not yet permanent)
- **20 Permanent:** Atomic, self-contained claims (the core system)
- **70 Projects:** Temporary outputs that pull from permanent notes
- **80 System:** AI infrastructure and governance tools
- **90 Maps:** Emergent structure (indexes and hubs)

#### Maps of Content (MOCs) Philosophy
- **Indexes:** Thin entry points for navigation ("Start here: [[Note A]], [[Note B]]")
- **Hubs:** Thick synthesis that connects themes and generates insights
- **Creation threshold:** Evidence-based, not aspirational
- **Pruning:** Monthly review to archive unused hubs

---

## The Prompt Library

All prompts are optimized for Gemma 4's `<|think|>` architecture and stored as versioned markdown files in `/80 System/Prompt Library/`.

### Prompt J: Triage Classifier (NEW - Entry Gate)

**Trigger:** When a note enters `/00 Inbox/`  
**Purpose:** Prevent collector's fallacy by forcing fate decisions

```markdown
<|think|>
You are a Triage Specialist. Analyze this inbox note.

**Context:**
- Note content: [First 200 words]
- Source: [If available]
- Creation context: [Time of day, related notes if any]

**Task:**
Classify this note into ONE category:

1. DELETE - Ephemeral thought with no enduring value
   - Examples: random observations, passing moods, already-captured ideas
   
2. TASK - Actionable item that belongs in task manager
   - Examples: "Call dentist," "Review contract," "Schedule meeting"
   
3. SOURCE NOTE - Keep in /10 Literature/ (source-bound reference)
   - Examples: Book highlights, article summaries, external quotes
   
4. CLAIM - Promote to /20 Permanent/ (self-contained insight)
   - Examples: Original thoughts, synthesized ideas, atomic claims

**Output Format:**
CLASSIFICATION: [DELETE | TASK | SOURCE | CLAIM]

CONFIDENCE: [0.0-1.0]

REASONING: [One sentence explanation]

ACTION:
[If DELETE: "Archive with note: reason"]
[If TASK: "Move to task manager with context: X"]
[If SOURCE: "File in /10 Literature/ under: category"]
[If CLAIM: "Proceed to atomicity check"]

**Constraint:** 
Be cynical about claims. Most captures are tasks or ephemeral thoughts.
Only 20-30% of inbox items should become permanent notes.
```

**Example Output:**
```
CLASSIFICATION: SOURCE

CONFIDENCE: 0.91

REASONING: Contains highlights from Ahrens' book with page numbers

ACTION: File in /10 Literature/Books/ as "Literature Note - Ahrens Smart Notes.md"
```

---

### Prompt A: Atomicity Checker (Quality Gate)

**Trigger:** After triage passes note to CLAIM category  
**Purpose:** Enforce "one idea per note" rule and filter non-enduring content

```markdown
<|think|>
You are an Atomicity Enforcer. Analyze the provided note.

**Task:**
1. Count the number of distinct, testable claims in this note
2. Assess whether this idea has enduring value beyond immediate context
3. Determine atomicity status

**Atomicity Levels:**
- ATOMIC ✓ (1 core claim, enduring value)
- MICRO-ATOMIC ⚠️ (Note too granular, lacks standalone value)
- MACRO ❌ (Multiple claims, requires split)
- NON-ENDURING 🗑️ (Lacks lasting value, should not be permanent)

**Output Format:**

ATOMICITY: [ATOMIC | MICRO-ATOMIC | MACRO | NON-ENDURING]

ENDURING VALUE ASSESSMENT:
- Does this idea transcend its immediate context? [YES/NO]
- Will you reference this in 6 months? [YES/NO]
- Is this a reusable building block for thinking? [YES/NO]

RECOMMENDATION:
→ PROMOTE to Permanent (evergreen insight)
→ INCUBATE (needs development)
→ DISCARD (ephemeral/trivial)

[If MACRO, provide split suggestions:]
SPLIT RECOMMENDED:
Original: "[Title]"
→ [[Proposed Title 1]] (lines X-Y: concept description)
→ [[Proposed Title 2]] (lines A-B: concept description)
→ [[Hub Note Title]] (synthesizes connection)

Rationale: [Why these are separate testable concepts]

[If MICRO-ATOMIC:]
MERGE RECOMMENDED:
This note makes a single small point that's not useful in isolation.
→ Merge into parent: [[Parent Note Title]]
→ Or combine with [[Similar Note]] into fuller concept

**Constraint:** 
Professional, domain-specific terminology only. No generic abstractions.
Be cynical about enduring value. Most ideas need more development.
```

**Example Output:**
```
ATOMICITY: MACRO

ENDURING VALUE ASSESSMENT:
- Transcends context? YES
- Reference in 6 months? YES
- Reusable building block? YES

RECOMMENDATION: SPLIT before promoting

SPLIT RECOMMENDED:
Original: "Kuzushi and Timing in Judo"
→ [[Kuzushi - Breaking Balance]] (the principle of off-balancing)
→ [[Timing - Recognizing the Moment]] (when to execute technique)
→ [[Kuzushi-Timing Synthesis]] (why both are required together)

Rationale: These are separate testable concepts. Kuzushi can exist without 
timing (static drills). Timing can exist without kuzushi (counter-attacks). 
The synthesis note explains their interdependence.
```

---

### Prompt B: Semantic Tagging & Deduplication (Taxonomy Management)

**Trigger:** After atomicity check passes  
**Purpose:** Prevent tag drift and synonyms

```markdown
<|think|>
You are a Taxonomy Architect. Review the note and "Master Tag List.md"

**Instructions:**
1. Identify the core concepts (max 3 tags per note, prefer 2)
2. Compare to existing tags in Master Tag List
3. If concept matches existing tag (even with different wording), use EXISTING tag
4. If concept is genuinely new and necessary, propose NEW tag with confidence score

**Output Format:**
YAML frontmatter block:
---
tags: [existing-tag-1, existing-tag-2]
proposed_new_tags:
  - tag: "biomechanics"
    confidence: 0.92
    justification: "Used in 3 notes, distinct from #movement-analysis"
    cooccurrence_check: "Appears with #judo in 80% of cases - might be redundant?"
  - tag: "flow-state"
    confidence: 0.45
    justification: "Might merge with #deep-work - flag for review"
---

EXISTING TAGS ANALYSIS:
Similar notes found:
- [[Tai-sabaki]] (0.89 similarity) - uses tags: #judo, #movement
- [[Kazushi vs Kuzushi]] (0.76 similarity) - uses tags: #judo, #terminology

DEDUPLICATION CHECK:
Potential synonym clusters detected:
- "product-mgmt" and "product-management" cooccur 90% → suggest merge
- "biomechanics" and "movement-analysis" cooccur 65% → review overlap

**Constraint:** 
- Be cynical about new tags
- Prefer domain-specific over generic (e.g., "#ashi-waza" not "#footwork")
- Flag low-confidence (<0.6) proposals for manual review
- Hard cap at 3 tags per note
```

---

### Prompt C: Link Discovery Engine with Relation Verbs (UPDATED)

**Trigger:** After tagging complete  
**Purpose:** Prevent orphan notes and surface connections with semantic meaning

```markdown
<|think|>
You are a Connection Architect. Find linking opportunities for "[Note Title]"

**Task:**
1. Identify up to 3 DIRECT connections (shared concepts/tags)
2. Identify up to 2 WEAK SIGNALS (cross-domain analogies, structural parallels)
3. For EVERY connection, provide:
   - Target note title
   - Relation verb (from controlled vocabulary)
   - Rationale (one sentence explaining WHY this link matters)
   - Confidence score

**Relation Vocabulary:**
DIRECT RELATIONS:
- extends: Builds upon the concept
- contradicts: Challenges or opposes the claim
- applies: Uses the principle in a specific context
- exemplifies: Provides concrete instance of abstract concept
- refines: Adds nuance or precision to the idea
- supports: Provides evidence for the claim

CROSS-DOMAIN RELATIONS:
- analogizes: Structural parallel across different domains
- inverts: Mirror-image relationship
- parallels: Similar pattern in different context

**Output Format:**

DIRECT CONNECTIONS (High Confidence):

→ [[Decision Making Under Pressure]]
  Relation: applies
  Rationale: "Kuzushi timing principles apply to decision windows under stress"
  Confidence: 0.91
  Suggested link text: "The timing sensitivity in kuzushi [[applies to decision-making under pressure]]"

→ [[Flow State in Combat]]
  Relation: exemplifies
  Confidence: 0.87
  Rationale: "Recognizing kuzushi moment is example of flow-state pattern recognition"
  Suggested link text: "Kuzushi recognition [[exemplifies flow-state awareness]]"

WEAK SIGNALS (Cross-Domain):

→ [[Minimum Viable Product]]
  Relation: analogizes
  Confidence: 0.68
  Rationale: "Both rely on 'smallest effective intervention' principle"
  Bridge concept: "Leverage points"
  Suggested connector note: "[[Leverage Points Across Domains]]"
  
**LINK BUDGET ENFORCEMENT:**
Max 3 direct + 2 weak signals per note
Current weekly link average: [X links/note]
⚠️ Warning if approaching >5 links/note (prevents overlinking)

**Constraint:** 
- Prioritize surprising over obvious connections
- Every link MUST have a relation verb and rationale
- No link without explicit semantic meaning
- Reject keyword-only matches (require content-level connection)
```

**Example Output:**
```
DIRECT CONNECTIONS:

→ [[Decision Making Under Pressure]]
  Relation: applies
  Rationale: "Kuzushi timing principles map directly to recognizing decision windows"
  Confidence: 0.91

→ [[Flow State Research]]
  Relation: supports
  Rationale: "Provides neuroscience evidence for pattern recognition in kuzushi"
  Confidence: 0.84

WEAK SIGNALS:

→ [[Minimum Viable Product]]
  Relation: analogizes
  Confidence: 0.67
  Rationale: "Both concepts use smallest effective intervention for maximum impact"
  Suggested connector: [[Leverage Principles Across Domains]]

LINK BUDGET STATUS:
Recommending 3 links for this note ✓
Weekly average: 2.3 links/note ✓
Graph density: Healthy
```

---

### Prompt D: MOC Integration (UPDATED - Evidence-Based)

**Trigger:** Daily batch process OR when traversal threshold met  
**Purpose:** Create structure only when proven needed through actual usage

```markdown
<|think|>
You are a System Architect analyzing hub creation opportunities.

**Context:**
- Total vault size: [N permanent notes]
- Tag cluster: #[tag-name]
- Notes in cluster: [count]
- Manual links within cluster: [count]
- User queries mentioning cluster: [count this month]
- Last hub update: [date]

**Hub Creation Thresholds (Vault-Size Adaptive):**

BEGINNER VAULT (<50 notes):
- Min notes in cluster: 3
- Min traversals: 2
- Rationale: Early structure provides motivation

GROWING VAULT (50-200 notes):
- Min notes in cluster: 5
- Min traversals: 3
- Rationale: Balanced structure emergence

MATURE VAULT (200+ notes):
- Min notes in cluster: 7
- Min traversals: 5
- Rationale: Proven necessity only

**Task:**
1. Evaluate if hub creation threshold is met
2. If yes, suggest hub structure
3. If no, track progress toward threshold

**Output Format:**

[If threshold MET:]
🌱 HUB CREATION RECOMMENDED

Cluster: #judo
Stats: 5 notes, 4 traversals, 3 queries this month
Threshold: EXCEEDED (Growing vault: need 5 notes + 3 traversals)

Proposed Hub: [[Judo Techniques Hub]]

SUGGESTED STRUCTURE:
# Judo Techniques Hub

## Foundational Principles
- [[Kuzushi - Breaking Balance]] - Off-balancing before force
- [[Tai-sabaki - Body Movement]] - Positioning and angles

## Applications
- [[Kuzushi in Ne-waza]] - Ground techniques
- [[Competition Timing Strategies]] - Tournament application

## Cross-Domain Connections
- See [[Leverage Points Hub]] for meta-patterns

PLACEMENT: /90 Maps/Hubs/

[Create Hub] [Wait for More Notes] [Never Suggest This Cluster]

---

[If threshold NOT MET:]
📊 HUB TRACKING

Cluster: #product-strategy
Current: 4 notes, 2 traversals
Threshold: Need 5 notes + 3 traversals (Growing vault)
Progress: 80% of notes, 67% of traversals

Suggestion: Continue tracking. Hub creation recommended after 1 more note 
and 1 more manual link between notes in this cluster.

**Integration Suggestion (for existing hubs):**
TARGET: [[Judo Techniques Hub]] > Foundational Principles
SUMMARY: "Breaking balance before applying force"
INSERTION: "- [[Kuzushi - Breaking Balance]] - Breaking balance before applying force"
POSITION: After [[Tai-sabaki]], before [[Kazushi Disambiguation]]

**Constraint:** 
- Do not alter existing MOC structure without permission
- Only suggest insertion point
- Prefer permissive creation + aggressive pruning over strict gatekeeping
```

---

### Prompt E: Serendipity Engine (Surprise Connections)

**Trigger:** Daily or on "Surprise Me" command  
**Purpose:** Generate non-obvious insights

```markdown
<|think|>
You are a Pattern Recognition Engine. Find unexpected connections.

**Task:**
Randomly select 3 notes written >30 days ago. For each:
1. Find the LEAST obvious connection to recent notes (last 7 days)
2. Ignore direct links and shared tags
3. Look for:
   - Structural parallels (both describe feedback loops)
   - Conceptual inversions (centralization vs decentralization)
   - Cross-domain analogies (judo → product strategy)

**Output Format:**

SURPRISE CONNECTION #1:

[[Ashi-waza - Foot Techniques]] (written 2023-11-12)
↔ 
[[Minimum Viable Product]] (written 2024-03-15)

Pattern Type: Cross-domain analogy
Similarity: Structural parallel

Insight: Both emphasize "smallest effective intervention"
- Ashi-waza: Minimal foot contact to maximum effect
- MVP: Minimal features to maximum learning

Confidence: 0.68

Suggested Action: 
Create connector note: [[Leverage Points Across Domains]]
This would synthesize the meta-pattern of minimal intervention for maximum impact

Bridge Concepts: leverage, efficiency, economy of force

[Explore This Connection] [Dismiss] [Remind in 30 Days]

---

SURPRISE CONNECTION #2:

[[Kuzushi - Breaking Balance]] (written 2024-01-15)
↔
[[Negotiation Tactics]] (written 2024-03-18)

Pattern Type: Conceptual parallel
Similarity: Both involve creating instability before action

Insight: Mental kuzushi = breaking someone's argumentative stance
- Physical: Disrupt balance before throw
- Verbal: Disrupt assumptions before persuasion

Confidence: 0.71

Evidence: Both require timing, both create "openings", both use minimal force

[Create Synthesis Note] [Dismiss] [Flag for Later Review]

**Constraint:** 
- Only suggest connections with confidence >0.6
- Prefer surprising over obvious
- Maximum 3 suggestions per day (avoid overload)
```

---

### Prompt F: Elaboration Suggester (Idea Evolution)

**Trigger:** Notes stable >60 days with 0 child notes  
**Purpose:** Prevent stagnation, encourage branching

```markdown
<|think|>
You are an Elaboration Coach. This note has been stable without evolution.

**Current State:**
- Title: [Note Title]
- Created: [Date]
- Last modified: [Date]
- Tags: [List]
- Inbound links: [Count]
- Outbound links: [Count]
- Revisions: [Count]
- Child notes: 0 ⚠️
- Times opened: [Count]

**Task:** 
Suggest 3 elaboration directions using the "Narrow-Broaden-Challenge" framework:

**Output Format:**

📊 STAGNATION DETECTED

Note: [[Kuzushi - Breaking Balance]]
Age: 180 days
Status: Stable (no changes in 120 days)
Child notes: 0 (opportunity for growth)

ELABORATION SUGGESTIONS:

1. NARROWING (Apply to Specific Context):
   Question: "How does kuzushi apply in ne-waza (ground techniques)?"
   Proposed note: [[Kuzushi in Ne-waza]]
   Value: Tests if principle holds in different domain
   Difficulty: Medium (requires research or experience)

2. BROADENING (Connect to Higher Abstraction):
   Question: "Is kuzushi a specific instance of 'leverage points' in systems?"
   Proposed note: [[Leverage Points - Meta Pattern]]
   Value: Reveals cross-domain applicability
   Difficulty: High (requires synthesis across domains)

3. CHALLENGING (Test Limits):
   Question: "Are there effective judo throws without kuzushi?"
   Proposed note: [[Counter: Kuzushi Exceptions in Competition]]
   Value: Strengthens understanding by exploring boundaries
   Difficulty: Low (observation-based)

RECOMMENDED STARTING POINT: 
Challenge pathway - easiest to validate and adds immediate value

[Create Narrowing Note] [Create Broadening Note] [Create Challenge Note] 
[Remind in 30 Days] [Mark as Complete (No Evolution Needed)]

**Constraint:** 
- Each suggestion must be genuinely new question
- Not rephrasing existing content
- Should spark new thinking, not just reorganization
```

---

### Prompt G: Dialectic Engine (Contradiction Detector)

**Trigger:** When new note enters Permanent folder  
**Purpose:** Surface intellectual contradictions and evolution

```markdown
<|think|>
You are a Dialectic Analyzer. Compare "[New Note]" to existing vault.

**Task:**
1. Find semantically similar notes (cosine similarity >0.7)
2. Identify potential contradictions, evolutions, or duplicates
3. For contradictions, create synthesis scaffolding (structure only, human writes content)

**Output Format:**

DIALECTIC ANALYSIS: [[Kuzushi - Breaking Balance]]

Similar notes found: 3

---

POTENTIAL CONTRADICTION (Severity: Medium)

This note claims: "Kuzushi requires minimal force"
Source: [[Kuzushi - Breaking Balance]] (lines 23-27)

Contradicts: "Elite judoka use overwhelming force for kuzushi"
Source: [[Force Multiplication in Competition]] (lines 45-52)

Confidence: 0.83
Impact: Affects understanding of competition vs practice applications

SUGGESTED ACTION: Create synthesis note with scaffolding

---

SYNTHESIS NOTE SCAFFOLD:

Title: [[Kuzushi Paradox - Minimal vs Maximal Force]]
Status: Incubating (requires your analysis)

## Claim A: Minimal Force
> [AI extracts relevant quote from [[Kuzushi - Breaking Balance]]]
> Context: Foundational technique training
> Date: 2024-01-15

## Claim B: Maximal Force
> [AI extracts relevant quote from [[Force Multiplication in Competition]]]
> Context: Elite competition analysis
> Date: 2024-03-15

## Possible Resolution Frameworks
[AI suggests, YOU analyze]:
1. Distinction between kuzushi (state) vs force application (method)
2. Context-dependent: recreational vs competitive judo
3. Temporal: force requirements in different phases of technique
4. Skill level: beginner vs advanced applications

## Your Synthesis
[EMPTY - Write your analysis here]

Did this resolve the contradiction?
[ ] Yes - Contradiction resolved, archive this note
[ ] No - One claim supersedes the other, update parent
[ ] Partial - Both valid in different contexts, keep as permanent tension

[Create This Scaffold] [Dismiss Contradiction] [Flag for Later Review]

---

EVOLUTION DETECTED:

Earlier: [[Initial Thoughts on Kuzushi]] (2023-05-12)
  → Treated kuzushi as synonymous with kazushi
  
Current: [[Kuzushi - Breaking Balance]] (2024-01-15)
  → Distinguishes kuzushi (state) from kazushi (action)

Suggested action: Update [[Initial Thoughts on Kuzushi]] with:
"This note has evolved into [[Kuzushi - Breaking Balance]] which 
refines the distinction between state and action."

[Auto-Update Parent Note] [Manual Review]

---

DUPLICATE WARNING (85% overlap):

This note overlaps significantly with [[Balance Breaking Principles]]

Overlap analysis:
- Shared concepts: 12/14 (86%)
- Unique to this note: "timing sensitivity" (1 concept)
- Unique to other note: "application in randori" (1 concept)

Suggested action: 
MERGE → Combine into [[Kuzushi - Breaking Balance]]
OR CLARIFY → Explain distinction in both notes

[Merge Notes] [Clarify Distinction] [Keep Separate]

**Constraint:** 
- Only flag contradictions with >70% confidence
- Provide scaffolding, not completed synthesis
- Human writes all analysis and resolution
```

---

### Prompt H: Outline Generator (Output Bridge)

**Trigger:** User initiates writing project  
**Purpose:** Transform Zettelkasten into published output

```markdown
<|think|>
You are a Publication Architect. User wants to write about "[Topic]"

**Task:**
1. Search vault for relevant Permanent Notes
2. Identify narrative structure based on note relationships
3. Find conceptual gaps (referenced but unwritten)
4. Generate outline with note links

**Output Format:**

📝 PUBLICATION OUTLINE

Topic: "Applying Judo Principles to Product Strategy"

VAULT SEARCH RESULTS: 12 relevant permanent notes found

---

PROPOSED STRUCTURE:

## I. Introduction: The Leverage Metaphor
**Core Argument:** Product strategy can learn from judo's economy of force

Supporting Notes:
- [[Kuzushi - Breaking Balance]] - Foundational concept
- [[Leverage Points - Meta Pattern]] - Cross-domain framework

**Estimated Length:** 300-400 words

---

## II. Timing and Opportunity Recognition
**Core Argument:** Market windows parallel kuzushi moments

Supporting Notes:
- [[Timing - Recognizing the Moment]] - When to act
- [[Market Windows in Product Launch]] - Application

🔴 GAP DETECTED: "False timing signals in market analysis"
- Referenced in [[Market Windows]] but no dedicated note exists
- Suggested: Create [[False Signals in Market Timing]]

**Estimated Length:** 500-600 words

---

## III. Minimal Effective Force
**Core Argument:** MVP thinking as ashi-waza

Supporting Notes:
- [[Minimum Viable Product]] - Product concept
- [[Ashi-waza - Foot Techniques]] - Judo technique
- [[Economy of Force Principles]] - Bridge concept

**Estimated Length:** 400-500 words

---

## IV. Synthesis and Application
**Core Argument:** Strategic framework for product leaders

Supporting Notes:
- [[Control Through Constraint - Meta Pattern]] - Overarching principle

🔴 GAP DETECTED: "When maximum force is appropriate (Iliadis case study)"
- Referenced but not analyzed
- Would strengthen argument by showing boundaries

**Estimated Length:** 300-400 words

---

DETECTED GAPS (Concepts Referenced But Not Written):
1. "False timing signals in competitive analysis"
2. "When maximum force beats minimal force"
3. "Competitive dynamics vs cooperative leverage"

TOTAL ESTIMATED LENGTH: 1,800-2,200 words

READINESS ASSESSMENT:
- Core argument: Well-supported ✓
- Evidence base: Strong (12 notes) ✓
- Gaps: 3 minor gaps (can write or skip)
- Narrative flow: Clear ✓

NEXT STEPS:
[Write Gap Notes First] [Start Draft with Current Notes] [Revise Outline]

**Constraint:** 
- Only include Permanent (evergreen) notes, not Incubating
- Flag all gaps where concept is referenced but undefined
- Provide realistic word counts based on note density
```

---

### Prompt I: The Luhmann Audit (System Health Check)

**Trigger:** Monthly automated report  
**Purpose:** Measure adherence to Zettelkasten principles

```markdown
<|think|>
You are a System Auditor. Analyze vault health against Luhmann's principles.

**Metrics to Calculate:**

1. ATOMICITY: % of notes with single testable claim
   - Method: Sample 20 random notes, manual review
   - Target: >85%

2. CONNECTIVITY: % of notes with 3+ bidirectional links
   - Method: Graph analysis
   - Target: >70%

3. EMERGENCE: # of synthesis/hub notes created this month
   - Method: Count new notes in /90 Maps/Hubs/
   - Target: >5% of new permanent notes

4. SURPRISE: # of cross-domain connections (notes linked across different tag clusters)
   - Method: Analyze links between different top-level tags
   - Target: >10 per month

5. OUTPUT: # of notes cited in /70 Projects/ this month
   - Method: Search project files for wikilinks
   - Target: >50% of permanent notes cited in past year

6. QUALITY: Average note health score (weighted by links, revisions, visits)
   - Method: Composite calculation
   - Target: >0.70

**Output Format:**

# 🔍 Zettelkasten Health Report
**Month:** March 2024
**Vault Size:** 347 permanent notes

---

## SCORES (0-100 scale)

| Metric | Score | Change | Target | Status |
|--------|-------|--------|--------|--------|
| Atomicity | 87 | ↑ +5 | 85 | ✓ Healthy |
| Connectivity | 73 | ↓ -3 | 70 | ⚠️ Declining |
| Emergence | 12 new hubs | ↑ +4 | 5 | ✓ Excellent |
| Surprise | 8 connections | → 0 | 10 | ⚠️ Below target |
| Output | 23 notes cited | ↑ +7 | 15 | ✓ Strong |
| Overall Health | 82/100 | ↑ +2 | 70 | ✓ Healthy |

---

## ⚠️ WARNINGS

**Connectivity Declining:**
- 4 notes created this month have 0 links (orphans)
- Orphan notes: [[Note A]], [[Note B]], [[Note C]], [[Note D]]
- Action: Review and connect, or archive if no value

**Surprise Connections Below Target:**
- Only 8 cross-domain connections this month (need 10)
- Siloed tags detected: #productivity appears 15x but never crosses domains
- Suggestion: Run Serendipity Engine more frequently

**Tag Bloat:**
- Tag "#productivity" used in 15 notes but never cited in outputs
- Dead weight tags detected: 3
- Action: Review for archival or merging

---

## ✅ STRENGTHS

**Strong Emergence:**
- 12 new synthesis notes (5% of new notes) exceeds target
- Hub creation rate healthy

**Output Integration:**
- 23 notes cited in 2 active projects
- 67% of permanent notes cited in past year (exceeds 50% target)

**Atomicity Improving:**
- Split enforcement working (87% pass rate, up from 82%)
- Only 2 notes flagged for complexity this month

---

## 📊 DETAILED STATISTICS

**Note Creation:**
- Total permanent notes: 347 (+25 this month)
- Average note length: 287 words (target: 150-400) ✓
- Notes requiring atomicity splits: 2 (8% of new notes) ✓

**Literature Pipeline:**
- Notes in /10 Literature/: 12
- Converted to Permanent (30 days): 5 (42% conversion)
- Stale literature (>60 days): 3 ⚠️

Pattern: You're capturing sources faster than processing them.
Recommendation: Temporary moratorium on new literature until backlog <5.

**Link Quality:**
- Average links per note: 4.2 ✓
- Links with relation verbs: 89% ✓
- Orphan notes (0 links): 4 (1% - healthy) ✓

**Tag Health:**
- Total active tags: 47
- Tags used >10 times: 12
- Tags never cited in outputs: 3 ⚠️
  - #productivity (15 notes, 0 outputs)
  - #random-thoughts (8 notes, 0 outputs)
  - #reading-notes (6 notes, 0 outputs)

---

## 📈 TRENDS (3-Month View)

| Metric | Jan | Feb | Mar | Trend |
|--------|-----|-----|-----|-------|
| Notes created | 18 | 22 | 25 | ↑ Growing |
| Atomicity % | 82 | 84 | 87 | ↑ Improving |
| Avg links/note | 3.8 | 4.1 | 4.2 | ↑ Improving |
| Orphan rate | 3% | 2% | 1% | ↑ Improving |
| Output citations | 16 | 19 | 23 | ↑ Improving |

---

## 🎯 RECOMMENDATIONS

**High Priority:**
1. Connect or archive 4 orphan notes
2. Review #productivity tag for archival (15 notes, 0 value)
3. Process 3 stale literature notes

**Medium Priority:**
4. Increase cross-domain connections (run Serendipity more often)
5. Review tags used <3 times for consolidation

**Low Priority:**
6. Continue current note creation pace (healthy growth)
7. Maintain atomicity enforcement (working well)

---

## 🔄 CONVERSION QUALITY

This month's permanent note quality:
- Average rewrite time: 4.2 minutes ✓ (healthy deliberation)
- Notes auto-split for atomicity: 2/25 (8%) ✓
- Notes flagged as "source-dependent": 1/25 (4%) ✓

⚠️ QUALITY FLAGS: None this month

---

## NEXT AUDIT: April 30, 2024

**Constraint:** 
- Be brutally honest - goal is improvement, not validation
- Provide actionable recommendations
- Compare to Luhmann's actual practice when possible
- Identify both strengths and weaknesses
```

---

## Note Metadata Schema

Every Permanent Note includes comprehensive frontmatter for state tracking:

```yaml
---
# IDENTITY
title: "Kuzushi - Breaking Balance"
id: permanent-note-047
created: 2024-01-15T09:23:00Z
modified: 2024-03-20T14:12:00Z

# TAXONOMY
tags: [ashi-waza, judo, leverage]
proposed_new_tags:
  - tag: "biomechanics"
    confidence: 0.92
    status: pending_review

# MATURITY & QUALITY
status: evergreen           # seedling | budding | evergreen | archived
confidence: 0.9             # How certain are you this idea holds?
generation: 2               # Refinement depth (0 = initial, 1+ = evolved)
health_score: 0.87          # Composite: links + revisions + visits
review_cycle: 90d           # When to resurface for review

# GENEALOGY  
parent: [[Initial Thoughts on Kuzushi]]
children:
  - [[Kuzushi in Ne-waza]]
  - [[Kuzushi vs Kazushi - Etymology]]
evolution_type: refinement  # refinement | challenge | application | synthesis

# PROVENANCE
source_type: original       # book | article | conversation | original
derived_from: null          # If from literature: [[Literature Note - Title]]
claim_strength: empirical   # empirical | theoretical | speculative
written_during: morning-pages
mental_state: reflective
sparked_by: post-training

# CONNECTIVITY WITH RELATION VERBS
links:
  - target: "[[Decision Making Under Pressure]]"
    relation: applies
    rationale: "Kuzushi timing principles map to decision windows"
    confidence: 0.91
  
  - target: "[[Minimum Viable Product]]"
    relation: analogizes
    rationale: "Both use smallest effective intervention principle"
    confidence: 0.68

outbound_links: 5
inbound_links: 12
moc_placements:
  - "Judo Techniques MOC > Foundational Principles"
  - "Leverage Points Hub"

# USAGE ANALYTICS
user_visits: 23
last_visited: 2024-03-18
citations_in_output: 2      # Times cited in published work
first_linked: 2024-01-16
last_moc_update: 2024-03-22
link_velocity: 0.3          # Links per week
last_queried: 2024-03-15    # For hub creation tracking
traversal_count: 8          # Manual links created within cluster

# FUTURE SELF
questions:
  - question: "Does this apply to verbal persuasion? Test after 10 sales calls"
    triggered_by: "after_sales_calls"
    due: 2024-06-01
  
  - question: "Contradiction with [[Force Multiplication]]? Revisit Dec 2024"
    triggered_by: "after_reading_biomechanics"
    due: 2024-12-01

reminders:
  - event: "Next tournament"
    date: 2024-04-15
    action: "Review and validate with competition footage"
  
  - event: "Q3 Product Launch"
    action: "Cite this in post-mortem analysis"
---
```

### Metadata Field Explanations

**Identity Fields:**
- `title`: Human-readable note title
- `id`: Unique identifier for stable addressing
- `created/modified`: Timestamps for tracking evolution

**Taxonomy Fields:**
- `tags`: Current canonical tags (max 3)
- `proposed_new_tags`: AI suggestions pending review

**Maturity Fields:**
- `status`: Current lifecycle stage
- `confidence`: How validated is this claim
- `generation`: How many times refined
- `health_score`: Composite quality metric

**Genealogy Fields:**
- `parent`: Note this evolved from
- `children`: Notes that branched from this
- `evolution_type`: How this note relates to parent

**Connectivity Fields (UPDATED):**
- `links`: Array with relation verbs and rationales
- `outbound_links/inbound_links`: Counts for health metrics
- `moc_placements`: Which hubs reference this

**Analytics Fields:**
- `user_visits`: How often opened
- `citations_in_output`: Usage in published work
- `traversal_count`: For hub creation decisions
- `last_queried`: Search/query activity

---

## Core Workflow

### Phase 1: Capture (Frictionless Entry)

**User Action:**
1. Write a fleeting note in `/00 Inbox/` or directly in `/20 Permanent/`
2. No manual tagging required during writing
3. No manual linking required during writing
4. Save file

**Philosophy:** Writing and organizing are separate cognitive modes. Don't mix them.

**Time Cost:** 0-5 seconds (just save the file)

---

### Phase 2: Triage (NEW - Fate Decision)

**When:** Note detected in `/00 Inbox/`

**AI Action:** Gemma analyzes with Prompt J (Triage Classifier)

**Decision Interface:**
```markdown
📋 INBOX TRIAGE

Note: "Meeting notes - Sarah mentioned..."
Created: 2024-04-22 14:30

CLASSIFICATION: TASK
Confidence: 0.94

Reasoning: Contains actionable item ("follow up with Sarah by Friday")

Recommended Action:
Move to task manager: "Follow up with Sarah about Q3 roadmap by Friday"

[Accept] [Reclassify as Source] [Reclassify as Claim] [Delete]
```

**User Action:** One-click decision

**Time Cost:** 5-15 seconds per note

**Expected Conversion Rate:**
- DELETE: 20-30%
- TASK: 20-30%
- SOURCE: 20-30%
- CLAIM: 20-30%

Only CLAIM and SOURCE notes proceed to next phase.

---

### Phase 3: Atomicity Check

**When:** Note classified as CLAIM

**AI Action:** Gemma analyzes with Prompt A (Atomicity Checker)

**Decision Interface:**
```markdown
⚠️ ATOMICITY CHECK

Note: "Kuzushi and Timing.md"

STATUS: MACRO (Multiple claims detected)

ENDURING VALUE: YES
- Transcends context ✓
- Reference in 6 months ✓
- Reusable building block ✓

SPLIT RECOMMENDED:

Original: "Kuzushi and Timing in Judo"
→ [[Kuzushi - Breaking Balance]] (lines 1-45)
   Core concept: Off-balancing opponent before applying force
   
→ [[Timing - Recognizing the Moment]] (lines 46-89)
   Core concept: When to execute technique for maximum effect
   
→ [[Kuzushi-Timing Synthesis]] (hub note)
   Connection: Why both are required together

Rationale: These are separate testable concepts. Kuzushi can exist 
without timing (static drills). Timing can exist without kuzushi 
(counter-attacks).

[Split Now] [Keep Unified] [Needs More Development → Incubate]
```

**User Action:** Choose split strategy

**Time Cost:** 30-60 seconds

---

### Phase 4: Semantic Tagging

**When:** After atomicity check passes

**AI Action:** Gemma analyzes with Prompt B (Semantic Tagging)

**Decision Interface:**
```markdown
🏷️ SEMANTIC TAGGING

Note: [[Kuzushi - Breaking Balance]]

SUGGESTED TAGS:
- #ashi-waza (existing) ✓
- #judo (existing) ✓
- #leverage (existing) ✓

Confidence: 0.94

SIMILAR NOTES:
- [[Tai-sabaki]] (0.89 similarity) - uses: #judo, #movement
- [[Kazushi Etymology]] (0.76 similarity) - uses: #judo, #terminology

NEW TAG PROPOSAL:
- "biomechanics" 
  Confidence: 0.67
  Justification: "Analyzes body mechanics in off-balancing"
  ⚠️ Cooccurs with #judo in 80% of cases - might be redundant

DEDUPLICATION CHECK:
✓ No synonym clusters detected

[Accept All Tags] [Accept Existing Only] [Modify Tags] [Review Individually]
```

**User Action:** Approve tags

**Time Cost:** 10-20 seconds

---

### Phase 5: Link Discovery

**When:** After tagging complete

**AI Action:** Gemma analyzes with Prompt C (Link Discovery + Relation Verbs)

**Decision Interface:**
```markdown
🔗 CONNECTION OPPORTUNITIES

Note: [[Kuzushi - Breaking Balance]]

DIRECT LINKS (High Confidence):

→ [[Decision Making Under Pressure]]
  Relation: applies
  Rationale: "Kuzushi timing principles map to decision windows under stress"
  Confidence: 0.91
  
  Suggested wikilink:
  "The timing sensitivity in kuzushi [[applies to decision-making under pressure]]"
  
  [Add This Link] [Skip]

→ [[Flow State in Combat]]
  Relation: supports
  Rationale: "Provides neuroscience evidence for pattern recognition"
  Confidence: 0.87
  
  [Add This Link] [Skip]

WEAK SIGNALS (Cross-Domain):

→ [[Minimum Viable Product]]
  Relation: analogizes
  Confidence: 0.68
  Rationale: "Both rely on 'smallest effective intervention' principle"
  
  Bridge concept: "Leverage points"
  Suggested connector note: [[Leverage Points Across Domains]]
  
  [Explore Connection] [Create Connector Note] [Dismiss]

LINK BUDGET STATUS:
Recommending 3 links total ✓
Weekly average: 2.3 links/note ✓

[Add All Direct Links] [Review Each] [Skip All]
```

**User Action:** Approve links and relation verbs

**Time Cost:** 20-40 seconds

---

### Phase 6: Dialectic Check

**When:** After linking complete

**AI Action:** Gemma analyzes with Prompt G (Dialectic Engine)

**Decision Interface (if contradiction found):**
```markdown
⚠️ POTENTIAL CONTRADICTION

Your new note: [[Kuzushi - Breaking Balance]]
Claims: "Kuzushi requires minimal force"

Contradicts: [[Force Multiplication in Competition]]
Claims: "Elite judoka use overwhelming force for kuzushi"

Confidence: 0.83
Severity: Medium

SUGGESTED ACTION:
Create synthesis note with scaffolding

Preview of scaffold:
---
Title: [[Kuzushi Paradox - Minimal vs Maximal Force]]

## Claim A: Minimal Force
[AI quote from your note]

## Claim B: Maximal Force  
[AI quote from contradicting note]

## Possible Resolution Frameworks
[AI suggests 3-4 frameworks, YOU write the synthesis]

## Your Synthesis
[EMPTY - Your analysis here]
---

[Create Scaffold] [Dismiss - Not a Real Contradiction] [Review Later]
```

**User Action:** Decide how to handle contradiction

**Time Cost:** 15-30 seconds (or more if creating synthesis)

---

### Phase 7: Hub Tracking/Creation

**When:** Daily batch OR when traversal threshold met

**AI Action:** Gemma analyzes with Prompt D (MOC Integration)

**Decision Interface (threshold met):**
```markdown
🌱 HUB CREATION RECOMMENDED

Cluster: #judo
Current vault size: 47 notes (Beginner vault)
Stats: 3 notes in cluster, 2 traversals (manual links)

Threshold: EXCEEDED
- Need 3 notes ✓
- Need 2 traversals ✓

PROPOSED HUB: [[Judo Techniques Hub]]

Suggested structure:
---
# Judo Techniques Hub

## Foundational Principles
- [[Kuzushi - Breaking Balance]] - Off-balancing before force
- [[Tai-sabaki - Body Movement]] - Positioning and angles

## Applications
- [[Competition Timing]] - Tournament strategies

## Cross-Domain Connections
- See [[Leverage Points Hub]] for meta-patterns
---

This hub will help you:
✓ See judo notes in one place
✓ Identify gaps in understanding
✓ Navigate between related concepts

[Create Hub Now] [Wait Until 5 Notes] [Never Suggest This Cluster]
```

**User Action:** Approve or defer hub creation

**Time Cost:** 15-30 seconds

---

### Phase 8: Completion

**System Action:**
1. Updates note frontmatter with all metadata
2. Logs all decisions to `/80 System/Decision Log.md`
3. Updates Master Tag List if new tags approved
4. Creates hub file if approved
5. Updates analytics for health metrics

**User sees:** Note is filed, linked, tagged, and integrated

**Total time for entire workflow:** 90 seconds - 3 minutes per note

**Compare to manual:** 5-10 minutes per note

---

### Daily Maintenance (Automated Background)

**Every 24 hours:**

1. **Serendipity Engine** (Prompt E)
   - Generates 3 surprise connections
   - Delivered as morning dashboard notification

2. **Elaboration Suggester** (Prompt F)
   - Identifies stagnant notes (>60 days, no children)
   - Suggests branching directions

3. **Orphan Detection**
   - Finds notes with 0 links after 7 days
   - Flags for connection review

4. **Hub Health Check**
   - Warns if hub exceeds 50 entries
   - Detects hubs with 0 updates in 90 days

**Output:** Dashboard showing suggestions

**User time:** 5-10 minutes to review

---

### Weekly Governance (Human Oversight)

**Every Sunday:**

#### A. Master Tag List Updates
```markdown
# 🏷️ Pending Tag Proposals (Week 16)

HIGH CONFIDENCE (Auto-approve after 14 days):
✓ `biomechanics` [0.92] - Used in 4 notes, distinct from existing
  [Approve] [Merge with...] [Reject]

LOW CONFIDENCE (Manual review):
⚠️ `flow-state` [0.45] - Might merge with #deep-work
  Cooccurrence: 83% (5/6 notes)
  [Approve as Separate] [Merge into #deep-work] [Reject]

SYNONYM DETECTION:
🔄 `product-mgmt` and `product-management` cooccur 90%
  Suggest: Merge → `product-management`
  Affected notes: 8
  [Confirm Merge] [Keep Separate]

TAG UTILITY ANALYSIS:
💀 Low-value tags (never cited in outputs):
  - #productivity (15 notes, 0 outputs)
  - #random-thoughts (8 notes, 0 outputs)
  
  [Archive These Tags] [Keep] [Review in 30 Days]
```

**Time cost:** 10-15 minutes

#### B. Weekly Metrics Dashboard
```markdown
# 📊 Weekly Zettelkasten Metrics

THIS WEEK:
- Notes created: 7 (↑2 from last week)
- Conversion rate: 30% (7 permanent / 23 inbox) ✓
- Atomic notes: 85% (6/7 passed split check) ✓
- Orphans created: 1 ⚠️
- Synthesis notes: 2 ✓
- Cross-domain connections: 3 ✓

CONVERSION QUALITY:
Average rewrite time: 4.1 minutes ✓
Notes flagged for quality: 0 ✓

STREAKS:
🔥 Daily writing: 12 days
📉 Longest gap: 4 days (Jan 15-19)

WARNINGS:
⚠️ [[Product Roadmap Q1]] has 0 links after 7 days
⚠️ 3 literature notes haven't been processed in 60+ days

SUGGESTIONS:
💡 Review: [[Old Note from Dec]]
💡 You've written 5 notes on #decision-making but no hub note yet
```

**Time cost:** 5 minutes review

---

### Monthly Audit (Deep Analysis)

**First Sunday of month:**

#### A. Luhmann Audit (Prompt I)
Full system health check with:
- Atomicity score
- Connectivity score
- Emergence metrics
- Output integration
- Trend analysis

#### B. Hub Pruning
```markdown
# 🗂️ Hub Health Review

LOW-VALUE HUBS (Consider archiving):

[[Productivity Hub]]
- 8 notes
- 0 outbound links from hub
- Last updated: 90 days ago
- You opened it: 0 times in 60 days

[Archive Hub - Keep Notes] [Merge with Another] [Keep]

HIGH-VALUE HUBS:

[[Judo Principles Hub]]
- 15 notes ✓
- 23 outbound links ✓
- Last updated: 3 days ago ✓
- Opened 12x this month ✓
- Used in 3 writing projects ✓
```

#### C. Literature Processing Backlog
```markdown
# 📚 Literature Pipeline

STALE LITERATURE (>60 days):
- [[Literature - Ahrens Book]] (created Jan 15, 72 days ago)
- [[Article - GraphRAG]] (created Jan 20, 67 days ago)

Recommendation: Process or archive

[Process Now] [Archive as Reference] [Delete]
```

**Time cost:** 30-45 minutes

---

## Advanced Features

### 1. Research Mode

For exploratory sessions that don't immediately yield notes:

```markdown
# 🔬 Research Session

**Session ID:** session-2024-04-22-143022
**Started:** 2024-04-22 14:30
**Duration:** 47 minutes

**Guiding Question:**
"How do leverage principles appear across different domains?"

**Breadcrumb Trail:**
[[Archimedes Lever]] 
  → noticed mechanical advantage concept
  → [[Financial Leverage]]
    → noticed asymmetric returns
    → [[Operational Leverage]]
      → noticed fixed-cost scaling
      → [[Kuzushi as Leverage]]
        → ❓ Is there "social leverage"?
        → ❓ What about temporal leverage (compound interest)?

**Scratch Notes:**
- Pattern emerging: All involve asymmetric input/output
- Missing piece: Negative leverage (downside amplification)
- Interesting: Time appears in all examples

**Dead Ends:**
- "Cognitive leverage" → too vague, no clear definition
- [[Network Effects]] connection → false pattern

**Outcome:**
✓ Created 1 permanent note: [[Leverage - Meta Pattern]]
✓ Flagged 2 questions for future exploration
✓ Identified 1 dead end to avoid

[Convert to Permanent] [Save as Incubating] [Archive Session]
```

**Auto-captured metadata:**
Any note created during this session gets:
```yaml
research_session_id: session-2024-04-22-143022
guiding_question: "How do leverage principles appear across domains?"
session_duration: 47min
```

**Later benefit:**
When viewing note in isolation, see context:
```markdown
📍 RESEARCH CONTEXT
This note emerged from session exploring:
"How do leverage principles appear across domains?"
Session date: Apr 22, 2024 (47 minutes)
[View Full Session] [View Other Notes from Session]
```

---

### 2. Writing Project Bridge

**User initiates:** "I want to write about [topic]"

**AI Action:** Prompt H (Outline Generator)

**Output:**
```markdown
# 📝 Project Outline Generator

Topic: "Applying Judo Principles to Product Strategy"

VAULT ANALYSIS:
- Relevant notes found: 14
- Cross-domain connections: 5
- Synthesis potential: High ✓
- Gaps detected: 3

---

## PROPOSED STRUCTURE

### I. Introduction: The Leverage Metaphor (300-400 words)
**Supporting Notes:**
- [[Kuzushi - Breaking Balance]]
- [[Leverage Points - Meta Pattern]]

### II. Timing and Market Windows (500-600 words)
**Supporting Notes:**
- [[Timing - Recognizing the Moment]]
- [[Market Windows in Product Launch]]

🔴 GAP: "False timing signals in market analysis"
- Referenced but not written
- Suggested: [[False Signals - Competitive Analysis]]

### III. Minimal Effective Force (400-500 words)
**Supporting Notes:**
- [[Minimum Viable Product]]
- [[Ashi-waza - Foot Techniques]]

### IV. Synthesis (300-400 words)
**Supporting Notes:**
- [[Control Through Constraint]]

---

READINESS: 85%
- Core argument: Well-supported ✓
- Evidence base: Strong ✓
- Gaps: 3 minor (can write or skip)

ESTIMATED LENGTH: 1,800-2,200 words

[Create Project Folder] [Write Gap Notes First] [Start Draft Now]
```

**If user chooses "Create Project Folder":**

System creates:
```
/70 Projects/judo-product-article/
├── outline.md (generated outline)
├── draft.md (empty, ready to write)
└── linked-notes/ (symlinks to source notes)
    ├── kuzushi-breaking-balance.md → ../../20 Permanent/Judo/...
    ├── leverage-points.md → ../../20 Permanent/...
    └── ...
```

---

### 3. Conversation Layer (Dialectical Notes)

For ideas in flux, questions, or contradictions:

```markdown
---
title: "Does Kuzushi Apply Outside Combat?"
type: dialogue
status: exploring
parent: [[Kuzushi - Breaking Balance]]
created: 2024-04-22
---

# 💬 Dialogue: Does Kuzushi Apply Outside Combat?

## The Hypothesis
If kuzushi is about "breaking stable equilibrium before applying force," 
it should appear in:
- Verbal persuasion (breaking mental stance)
- Market disruption (breaking competitor positioning)
- Organizational change (breaking institutional inertia)

## Evidence For
- Sales tactics: Asking unexpected questions creates "mental kuzushi"
- [[Market Windows]] - timing windows = moments of market imbalance
- [[Zero to One - Thiel]] describes "secrets" as consensus-breaking

## Evidence Against
- Might be forced analogy - combat is physical, these are abstract
- "Breaking balance" in persuasion = manipulation? Ethical concern
- No clear measurement - how do you know mental kuzushi occurred?

## Test Plan
1. Record next 10 sales calls
2. Mark moments when prospect shifts defensive → receptive
3. Analyze: Was there a "kuzushi moment"?
4. Deadline: Review findings Apr 30

## Current Status
⏸️ In progress - awaiting sales call data

## Reminders
- [ ] Review after sales call analysis (Apr 30)
- [ ] If validated → promote to Permanent
- [ ] If falsified → archive with lessons learned

## Updates
**2024-04-25:** Analyzed 5 calls, pattern emerging...
```

**Type field enables filtering:**
- `type: permanent` - Validated claims
- `type: dialogue` - Active exploration
- `type: question` - Unanswered inquiries
- `type: counter-argument` - Challenges to existing notes

---

### 4. Future Self Interface

**In any note:**
```yaml
questions_for_future_me:
  - question: "Does this hold true in ne-waza?"
    trigger: "after_next_groundwork_seminar"
    due: 2024-05-15
  
  - question: "Contradiction with [[Force Multiplication]]?"
    trigger: "after_reading_biomechanics_research"
    due: 2024-12-01

reminders:
  - event: "Q3 Product Launch"
    action: "Cite this in post-mortem analysis"
  
  - event: "Next tournament"
    action: "Validate with competition footage"
    date: 2024-04-15
```

**System behavior:**
- Surfaces questions when trigger condition met
- Adds to daily dashboard at appropriate time
- Tracks which questions got answered vs abandoned

**Example notification:**
```markdown
🔔 QUESTION REMINDER

You wrote in [[Kuzushi - Breaking Balance]]:
"Does this hold true in ne-waza?"

Trigger: "after_next_groundwork_seminar"
Your last seminar was yesterday.

Ready to explore this?
[Create Exploration Note] [Mark as Answered] [Defer 30 Days]
```

---

## Technical Implementation

### Stack

```yaml
Core:
  - Obsidian: Vault interface (file management, editing)
  - Gemma 4: Local LLM via Ollama
  - Python 3.11+: Orchestration scripts
  - Node.js 18+: For Obsidian plugin if needed

Storage:
  - Markdown files: Notes (human-readable, git-versioned)
  - SQLite: Embeddings + analytics
  - Git: Version control + rollback capability

Obsidian Plugins:
  - Dataview: Query engine for dashboards
  - Templater: Note templates
  - Local REST API: Python ↔ Obsidian communication
  - QuickAdd: Capture workflows
  - Metadata Menu: Frontmatter UI
```

### Local Agent Architecture

```python
# /80 System/librarian_agent.py

import sqlite3
from pathlib import Path
from ollama import Client
import yaml
from datetime import datetime

class LibrarianEngine:
    def __init__(self):
        self.ollama = Client(host="http://localhost:11434")
        self.model = "gemma-4"
        self.vault_path = Path("/Personal Vault")
        self.embeddings_db = sqlite3.connect("embeddings.db")
        self.decision_log = DecisionLog("80 System/Decision Log.md")
        self.prompts = self.load_prompts()
    
    def load_prompts(self):
        """Load all prompts from library"""
        prompt_dir = self.vault_path / "80 System/Prompt Library"
        prompts = {}
        for prompt_file in prompt_dir.glob("*.md"):
            name = prompt_file.stem
            prompts[name] = prompt_file.read_text()
        return prompts
    
    def process_new_note(self, note_path: Path):
        """Main processing pipeline"""
        
        # 1. Triage (NEW)
        triage_result = self.triage_note(note_path)
        
        if triage_result.classification == "DELETE":
            self.archive(note_path, triage_result.reasoning)
            return
        
        if triage_result.classification == "TASK":
            self.send_to_task_manager(note_path, triage_result.context)
            return
        
        if triage_result.classification == "SOURCE":
            self.move_to_literature(note_path)
            return
        
        # Only CLAIM proceeds
        if triage_result.classification != "CLAIM":
            return
        
        # 2. Atomicity Check
        atomicity_result = self.check_atomicity(note_path)
        
        if atomicity_result.recommendation == "DISCARD":
            decision = self.prompt_user(atomicity_result)
            if decision == "confirm_discard":
                self.archive(note_path, "non-enduring")
                return
        
        if atomicity_result.recommendation == "INCUBATE":
            self.move_to_incubating(note_path)
            return
        
        if atomicity_result.status == "MACRO":
            decision = self.prompt_user(atomicity_result)
            if decision == "split":
                self.execute_split(note_path, atomicity_result.splits)
                return  # Re-process split notes
        
        if atomicity_result.status == "MICRO-ATOMIC":
            decision = self.prompt_user(atomicity_result)
            if decision == "merge":
                self.merge_into_parent(note_path, atomicity_result.parent)
                return
        
        # 3. Semantic Tagging
        tags = self.generate_tags(note_path)
        approved_tags = self.prompt_user(tags)
        self.apply_tags(note_path, approved_tags)
        
        # 4. Link Discovery with Relation Verbs
        links = self.find_connections(note_path)
        approved_links = self.prompt_user(links)
        self.apply_links(note_path, approved_links)
        
        # 5. Dialectic Check
        contradictions = self.check_contradictions(note_path)
        if contradictions:
            contradiction_decision = self.prompt_user(contradictions)
            if contradiction_decision == "create_scaffold":
                self.create_synthesis_scaffold(contradictions)
        
        # 6. Hub Tracking
        self.track_hub_opportunities(note_path)
        
        # 7. Log all decisions
        self.decision_log.record(note_path, {
            "triage": triage_result,
            "atomicity": atomicity_result,
            "tags": approved_tags,
            "links": approved_links,
            "contradictions": contradictions
        })
    
    def triage_note(self, note_path: Path):
        """Prompt J: Triage Classifier"""
        content = note_path.read_text()
        prompt = self.prompts["triage"].format(
            content=content[:500],  # First 500 chars
            source="inbox",
            timestamp=datetime.now().isoformat()
        )
        
        response = self.ollama.generate(
            model=self.model,
            prompt=prompt,
            system="You are a Triage Specialist for a Zettelkasten system."
        )
        
        return self.parse_triage_response(response['response'])
    
    def check_atomicity(self, note_path: Path):
        """Prompt A: Atomicity Checker"""
        content = note_path.read_text()
        prompt = self.prompts["atomicity"].format(
            content=content,
            title=note_path.stem
        )
        
        response = self.ollama.generate(
            model=self.model,
            prompt=prompt
        )
        
        return self.parse_atomicity_response(response['response'])
    
    def generate_tags(self, note_path: Path):
        """Prompt B: Semantic Tagging"""
        content = note_path.read_text()
        master_tag_list = (self.vault_path / "80 System/Master Tag List.md").read_text()
        
        prompt = self.prompts["tagging"].format(
            content=content,
            master_tags=master_tag_list
        )
        
        response = self.ollama.generate(
            model=self.model,
            prompt=prompt
        )
        
        return self.parse_tag_response(response['response'])
    
    def find_connections(self, note_path: Path):
        """Prompt C: Link Discovery with Relation Verbs"""
        content = note_path.read_text()
        
        # Get embedding for semantic search
        embedding = self.get_embedding(note_path)
        similar_notes = self.embeddings_db.similarity_search(
            embedding, 
            threshold=0.7,
            limit=10
        )
        
        prompt = self.prompts["linking"].format(
            content=content,
            title=note_path.stem,
            similar_notes=similar_notes
        )
        
        response = self.ollama.generate(
            model=self.model,
            prompt=prompt
        )
        
        return self.parse_link_response(response['response'])
    
    def check_contradictions(self, note_path: Path):
        """Prompt G: Dialectic Engine"""
        content = note_path.read_text()
        
        # Find semantically similar notes
        embedding = self.get_embedding(note_path)
        similar_notes = self.embeddings_db.similarity_search(
            embedding,
            threshold=0.7,
            limit=5
        )
        
        if not similar_notes:
            return None
        
        prompt = self.prompts["dialectic"].format(
            content=content,
            title=note_path.stem,
            similar_notes=similar_notes
        )
        
        response = self.ollama.generate(
            model=self.model,
            prompt=prompt
        )
        
        return self.parse_dialectic_response(response['response'])
    
    def track_hub_opportunities(self, note_path: Path):
        """Prompt D: Hub Creation Tracking"""
        # Get note tags
        frontmatter = self.parse_frontmatter(note_path)
        tags = frontmatter.get('tags', [])
        
        for tag in tags:
            # Update traversal counts
            self.update_traversal_count(tag)
            
            # Check if threshold met
            vault_size = self.count_permanent_notes()
            cluster_size = self.count_notes_with_tag(tag)
            traversals = self.get_traversal_count(tag)
            
            threshold = self.get_hub_threshold(vault_size)
            
            if (cluster_size >= threshold['notes'] and 
                traversals >= threshold['traversals']):
                self.suggest_hub_creation(tag, cluster_size, traversals)
    
    def get_hub_threshold(self, vault_size):
        """Vault-size adaptive thresholds"""
        if vault_size < 50:
            return {'notes': 3, 'traversals': 2}
        elif vault_size < 200:
            return {'notes': 5, 'traversals': 3}
        else:
            return {'notes': 7, 'traversals': 5}
    
    def daily_tasks(self):
        """Background maintenance"""
        self.run_serendipity_engine()  # Prompt E
        self.check_for_orphans()
        self.suggest_elaborations()    # Prompt F
        self.check_hub_health()
        self.update_analytics()
    
    def weekly_review(self):
        """Generate governance dashboard"""
        return {
            "pending_tags": self.get_pending_tags(),
            "system_health": self.calculate_health_metrics(),
            "warnings": self.detect_issues(),
            "conversion_quality": self.analyze_conversion_quality()
        }
    
    def monthly_audit(self):
        """Prompt I: Luhmann Audit"""
        prompt = self.prompts["luhmann_audit"].format(
            vault_stats=self.gather_vault_statistics()
        )
        
        response = self.ollama.generate(
            model=self.model,
            prompt=prompt
        )
        
        return self.format_audit_report(response['response'])
    
    def prompt_user(self, data):
        """Display decision interface and wait for user input"""
        # This would integrate with Obsidian UI
        # For MVP, could be a modal dialog or notification
        pass


class EmbeddingIndex:
    """Efficient semantic search"""
    def __init__(self, db_path="embeddings.db"):
        self.db = sqlite3.connect(db_path)
        self.setup_schema()
    
    def setup_schema(self):
        self.db.execute("""
            CREATE TABLE IF NOT EXISTS embeddings (
                note_path TEXT PRIMARY KEY,
                embedding BLOB,
                content_hash TEXT,
                last_updated TIMESTAMP
            )
        """)
    
    def update_note_embedding(self, note_path: Path, content: str):
        """Only re-embed if content changed >20%"""
        current_hash = self.content_hash(content)
        stored = self.db.execute(
            "SELECT content_hash FROM embeddings WHERE note_path = ?",
            (str(note_path),)
        ).fetchone()
        
        if stored and stored[0] == current_hash:
            return  # No change
        
        # Generate embedding (using local model)
        embedding = self.generate_embedding(content)
        
        self.db.execute("""
            INSERT OR REPLACE INTO embeddings 
            (note_path, embedding, content_hash, last_updated)
            VALUES (?, ?, ?, ?)
        """, (str(note_path), embedding, current_hash, datetime.now()))
        
        self.db.commit()
    
    def similarity_search(self, query_embedding, threshold=0.7, limit=10):
        """Cosine similarity search"""
        # Implementation would use vector similarity
        # Could use numpy or dedicated vector DB
        pass


class DecisionLog:
    """Audit trail of all AI decisions"""
    def __init__(self, log_path):
        self.log_path = Path(log_path)
    
    def record(self, note_path, decisions):
        """Log decision with rollback capability"""
        entry = {
            "timestamp": datetime.now().isoformat(),
            "note": str(note_path),
            "decisions": decisions,
            "rollback_script": self.generate_rollback_script(note_path, decisions)
        }
        
        # Append to log
        with open(self.log_path, 'a') as f:
            f.write(f"\n## {entry['timestamp']}\n")
            f.write(f"**Note:** {entry['note']}\n")
            f.write(f"**Decisions:** {yaml.dump(entry['decisions'])}\n")
            f.write(f"**Rollback:** `{entry['rollback_script']}`\n")
```

### Embedding Management

```python
# Use sentence-transformers for local embeddings
from sentence_transformers import SentenceTransformer
import numpy as np

class LocalEmbeddingModel:
    def __init__(self):
        # all-MiniLM-L6-v2 is lightweight and local
        self.model = SentenceTransformer('all-MiniLM-L6-v2')
    
    def encode(self, text):
        return self.model.encode(text, convert_to_numpy=True)
    
    def similarity(self, embedding1, embedding2):
        """Cosine similarity"""
        return np.dot(embedding1, embedding2) / (
            np.linalg.norm(embedding1) * np.linalg.norm(embedding2)
        )
```

### Configuration File

```yaml
# /80 System/config.yml

# Automation Thresholds
automation:
  tagging:
    auto_apply_above: 0.95
    always_review_below: 0.70
  
  linking:
    auto_apply_direct: 0.90
    auto_apply_weak_signals: never  # Always review
  
  moc_placement:
    auto_apply_above: 0.85
  
  atomicity_splits:
    always_review: true  # Never auto-split

# Conversion Quality
conversion:
  flag_if_rewrite_time_under: 90  # seconds
  warn_if_atomicity_fail_rate: 0.30  # 30%
  track_source_dependency: true

# Hub Creation
hubs:
  mode: permissive_with_pruning
  
  thresholds:
    beginner_vault_size: 50
    beginner_min_notes: 3
    beginner_min_traversals: 2
    
    growing_vault_size: 200
    growing_min_notes: 5
    growing_min_traversals: 3
    
    mature_min_notes: 7
    mature_min_traversals: 5
  
  pruning:
    frequency_days: 30
    unused_threshold_days: 60
    low_visit_count: 3

# Link Budget
linking:
  max_direct_per_note: 3
  max_weak_signals_per_note: 2
  warn_weekly_average_above: 5

# Serendipity
serendipity:
  daily_suggestions: 3
  min_confidence: 0.60
  lookback_days: 30

# Analytics
analytics:
  track_visit_counts: true
  track_query_activity: true
  track_rewrite_time: true
```

---

## Success Metrics

### Organizational Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Tag Cleanliness** | 0% duplicate/synonym tags | Monthly synonym detection scan |
| **Connection Rate** | 100% notes have 3+ bidirectional links | Graph analysis |
| **Orphan Prevention** | <2% notes orphaned after 7 days | Daily orphan count |
| **MOC Coverage** | 100% notes in ≥1 MOC | Hub placement tracking |

### Thinking Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Elaboration Rate** | 20%+ notes spawn children within 90 days | Genealogy tracking |
| **Synthesis Generation** | 5+ hub notes per month | Hub creation count |
| **Cross-Domain Connections** | 10+ weak signals per month | Serendipity engine output |
| **Contradiction Detection** | All conflicts flagged within 24h | Dialectic engine runtime |

### Output Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Publication Rate** | 50%+ notes cited in outputs within 1 year | Citation tracking |
| **Time to Outline** | <5 minutes for article outline | Outline generator usage |
| **Idea Maturity** | 80%+ incubating notes promoted/archived within 90 days | Status tracking |
| **Emergent Output Density** | 30%+ outputs use cross-domain/contradiction insights | Content analysis |

### Efficiency Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Processing Time** | <3 minutes per note (vs 5-10 manual) | Timestamp tracking |
| **Weekly Governance** | <30 minutes on Sundays | User time tracking |
| **System Latency** | <2 seconds for AI responses | Response time logging |
| **Cost** | $0/month | Local inference only |
| **AI Decision Reversal Rate** | <15% | Decision log analysis |

### Quality Metrics (NEW)

| Metric | Target | Measurement |
|--------|--------|-------------|
| **Conversion Quality** | Avg rewrite time >90 seconds | Timestamp delta |
| **Atomicity Success Rate** | >85% pass without split | Prompt A outcomes |
| **Link Relation Completeness** | 100% links have verbs + rationales | Frontmatter validation |
| **Hub Utility** | <10% hubs pruned per month | Hub pruning rate |

---

## Rollout Plan

### Phase 1: Foundation + Triage (Week 1-2)

**Goals:**
- Set up file system
- Install core infrastructure
- Build triage gate
- Test basic atomicity checking

**Tasks:**
- [ ] Create vault folder structure
- [ ] Install Ollama + download Gemma 4 model
- [ ] Create Prompt Library folder
- [ ] Write Prompt J (Triage Classifier)
- [ ] Write Prompt A (Atomicity Checker) with enduring value filter
- [ ] Build basic Python agent (file watching)
- [ ] Test triage → atomicity workflow with 10 sample notes
- [ ] Create config.yml with initial thresholds

**Deliverable:** Can classify inbox notes and check atomicity

---

### Phase 2: Tagging + Linking with Relation Verbs (Week 3-4)

**Goals:**
- Add semantic tagging
- Implement link discovery with relation verbs
- Build decision interface (basic)
- Create Master Tag List

**Tasks:**
- [ ] Write Prompt B (Semantic Tagging)
- [ ] Write Prompt C (Link Discovery with Relation Verbs)
- [ ] Build embedding index (SQLite + sentence-transformers)
- [ ] Create Master Tag List.md template
- [ ] Build decision interface (could be command-line for MVP)
- [ ] Add frontmatter auto-update logic
- [ ] Test full workflow: triage → atomicity → tags → links
- [ ] Validate relation verb enforcement

**Deliverable:** End-to-end note processing with relation-annotated links

---

### Phase 3: Dialectics + Hub Tracking (Week 5-6)

**Goals:**
- Add contradiction detection
- Implement evidence-based hub creation
- Build traversal tracking
- Create weekly dashboard

**Tasks:**
- [ ] Write Prompt G (Dialectic Engine)
- [ ] Write Prompt D (Hub Integration with thresholds)
- [ ] Implement traversal count tracking
- [ ] Build vault-size adaptive logic for hubs
- [ ] Create Dataview query for weekly dashboard
- [ ] Write Prompt E (Serendipity Engine)
- [ ] Write Prompt F (Elaboration Suggester)
- [ ] Test hub creation at different vault sizes

**Deliverable:** Contradiction scaffolds + evidence-based hubs

---

### Phase 4: Governance Tools (Week 7-8)

**Goals:**
- Build weekly review interface
- Create monthly audit
- Add decision logging
- Implement rollback

**Tasks:**
- [ ] Write Prompt I (Luhmann Audit)
- [ ] Build Decision Log system
- [ ] Create weekly governance dashboard (Dataview)
- [ ] Implement tag synonym detection
- [ ] Build hub pruning interface
- [ ] Create rollback scripts (git-based)
- [ ] Add conversion quality tracking
- [ ] Test full monthly cycle

**Deliverable:** Complete governance toolkit

---

### Phase 5: Advanced Features (Week 9-10)

**Goals:**
- Add Research Mode
- Build Outline Generator
- Implement Future Self interface
- Create Conversation Layer

**Tasks:**
- [ ] Write Prompt H (Outline Generator)
- [ ] Build Research Session tracking
- [ ] Add session context auto-capture
- [ ] Create dialogue note templates
- [ ] Implement question/reminder system
- [ ] Build project folder generator
- [ ] Test writing workflow end-to-end

**Deliverable:** Full Zettelkasten → Output pipeline

---

### Phase 6: Polish & Documentation (Week 11-12)

**Goals:**
- Performance optimization
- User documentation
- Tutorial vault
- Open source preparation

**Tasks:**
- [ ] Optimize embedding generation (batch processing)
- [ ] Add caching for frequently-accessed data
- [ ] Write user manual
- [ ] Create tutorial vault with 50 example notes
- [ ] Record video walkthrough
- [ ] Set up GitHub repository
- [ ] Write contributing guidelines
- [ ] Prepare for public release

**Deliverable:** Production-ready system with documentation

---

## Philosophy and Design Principles

### Core Philosophy

**AI = Labor, Human = Governance**

This is not just a slogan—it's the architectural principle that governs every design decision:

**AI Handles:**
- Finding similar notes (search/embeddings)
- Detecting patterns (synonyms, contradictions)
- Suggesting structure (hubs, links, tags)
- Tracking metrics (health scores, analytics)
- Generating scaffolding (outlines, synthesis templates)

**Human Handles:**
- What counts as a claim vs a task
- Whether an idea is worth keeping
- How to resolve contradictions
- Which connections matter
- What to publish

### Zettelkasten Fidelity

We preserve Luhmann's core insights while adapting to digital affordances:

**Preserved from Luhmann:**
1. **Atomicity:** One idea per note
2. **Addressability:** Stable identifiers for lasting references
3. **Local adjacency:** See what came before/after a thought
4. **Emergent structure:** Links create structure, not folders
5. **Surprise mechanism:** System surfaces unexpected connections

**Enhanced for Digital:**
1. **Semantic search:** Find notes by meaning, not just keywords
2. **Bidirectional links:** Automatic backlink tracking
3. **Graph visualization:** See connection patterns
4. **Cross-domain discovery:** AI finds analogies across fields
5. **Contradiction detection:** System flags intellectual conflicts

**Avoided Pitfalls:**
1. ❌ Link decoration (links without semantic meaning)
2. ❌ Premature taxonomy (folders before knowledge emerges)
3. ❌ Collector's fallacy (capture without conversion)
4. ❌ Over-automation (AI does thinking)
5. ❌ Tag drift (synonyms proliferate)

### Friction Philosophy

From the best practices document, we learned:

> "Remove friction from capture, search, and surfacing; keep productive friction in selection, rewriting, and relation naming."

**Where we remove friction:**
- Capture: One inbox, no decisions required
- Search: Semantic similarity, not keyword matching
- Surfacing: Daily suggestions, not manual review

**Where we preserve friction:**
- Selection: Is this worth keeping?
- Rewriting: In your own words, not highlights
- Relation naming: Why does this link matter?

**Why this matters:**
The filing process IS the thinking process. Remove it entirely and you're just hoarding. Keep only the valuable friction.

### Evidence-Based Structure

**Old approach (most PKM apps):**
Create structure upfront → Hope you fill it → Usually abandoned

**Our approach:**
Track behavior → Detect patterns → Suggest structure when proven

**Example:**
```
Week 1: User writes 3 notes on #judo
Week 2: User manually links them twice
Week 3: System suggests hub creation (threshold met)
Week 4: User creates hub, sees value
Month 2: 5 hubs exist, 2 get pruned (unused)
Month 3: User understands which clusters matter
```

**Philosophy:** 
Prefer permissive creation + aggressive pruning over strict gatekeeping

### Relation Verbs as Thinking Tool

**Problem:** 
"Related notes" links create graph noise without insight

**Solution:**
Every link requires a relation verb from controlled vocabulary

**Example:**
```markdown
❌ BAD:
[[Kuzushi]] and [[MVP]]

✅ GOOD:
[[Kuzushi]] analogizes [[MVP]] because both use 
smallest effective intervention
```

**Why this works:**
- Forces you to articulate WHY the connection matters
- Creates reusable reasoning traces
- Makes links searchable by type
- Prevents link blindness

### Quality Over Quantity

**Anti-pattern:** 
Many systems reward note count ("I have 5,000 notes!")

**Our approach:**
Reward note utility ("50% cited in published work")

**Mechanisms:**
1. Triage gate (30% conversion rate expected)
2. Enduring value check (not every thought is permanent)
3. Hub pruning (structure that doesn't get used is removed)
4. Tag archival (metadata that provides no value is deleted)

**Philosophy:**
A small collection of well-connected, frequently-used notes beats a large collection of unprocessed highlights.

### Trust Through Transparency

**Every AI action is:**
1. **Logged:** Decision Log tracks what happened and when
2. **Reversible:** Rollback scripts can undo changes
3. **Explainable:** Confidence scores and reasoning provided
4. **Auditable:** Monthly reports show AI decision quality

**Why this matters:**
You'll only trust the system if you can verify it's helping, not harming. Transparency enables trust.

---

## Appendix: Key Changes from Initial Design

This section documents how our design evolved through discussion and research.

### Major Additions

#### 1. **Triage Gate (Prompt J)**
**What:** Four-way classification before atomicity check  
**Why:** Prevents collector's fallacy, ensures only claims reach permanent  
**Source:** Best practices document emphasis on "delete, task, source, claim" workflow  

#### 2. **Relation Verbs in Links**
**What:** Every link requires semantic relation (extends, contradicts, applies, etc.)  
**Why:** Prevents meaningless "keyword decoration" links  
**Source:** Best practices document: "Links need verbs"  
**Impact:** Changes link metadata schema, adds to Prompt C  

#### 3. **Evidence-Based Hub Creation**
**What:** Vault-size adaptive thresholds, track traversal patterns  
**Why:** Beginners need early wins, mature vaults need proven necessity  
**Source:** User feedback on motivation vs gatekeeping balance  
**Impact:** Modified Prompt D, added traversal tracking  

#### 4. **Enduring Value Filter**
**What:** Atomicity check includes "should this be permanent?" assessment  
**Why:** Not every atomic thought deserves permanent status  
**Source:** Best practices document on literature vs permanent distinction  
**Impact:** Expanded Prompt A with promote/incubate/discard logic  

### Major Modifications

#### 5. **Removed Daily Conversion Limit**
**Original plan:** Hard cap of 3 permanent notes per day  
**Problem:** Breaks import scenarios and research sprints  
**Solution:** Quality tracking without hard limits  
**Rationale:** Flag rushed conversions, don't block legitimate batches  

#### 6. **Permissive Hub Creation + Aggressive Pruning**
**Original plan:** High thresholds for all hubs (7+ notes, 5+ traversals)  
**Problem:** Demotivating for beginners, delays payoff  
**Solution:** Low thresholds (3 notes, 2 traversals for <50 notes) with monthly pruning  
**Rationale:** Better to create and remove than never create  

#### 7. **Hub Tracking via Traversal Counts**
**Original plan:** AI suggests MOC placement immediately  
**Problem:** Violates "emergent structure" principle  
**Solution:** Track manual linking patterns, suggest when threshold met  
**Impact:** Added traversal_count field to metadata  

### Design Principles Clarified

#### 8. **Friction Philosophy**
**Insight:** Not all friction is bad  
**Applied:** Remove friction from capture/search, preserve friction in selection/rewriting  
**Source:** Best practices: "The conversion pass should be a filter"  

#### 9. **Luhmann Fidelity**
**Insight:** Zettelkasten is about thinking, not organizing  
**Applied:** Atomicity enforcement, relation verbs, surprise connections, dialectics  
**Avoided:** Over-automation, premature taxonomy, link decoration  

#### 10. **Quality Over Quantity**
**Insight:** 90% of captures shouldn't become permanent notes  
**Applied:** Triage gate, enduring value check, tag archival  
**Metrics:** Conversion rate (target 30%), citation rate (target 50%)  

### Technical Changes

#### 11. **Relation Verb Metadata Schema**
**Before:**
```yaml
outbound_links: 5
```

**After:**
```yaml
links:
  - target: "[[Note Title]]"
    relation: extends
    rationale: "One sentence why"
    confidence: 0.91
```

#### 12. **Hub Threshold Configuration**
**Before:** Static thresholds  
**After:** Vault-size adaptive  
```yaml
beginner (<50 notes): 3 notes, 2 traversals
growing (50-200): 5 notes, 3 traversals  
mature (200+): 7 notes, 5 traversals
```

#### 13. **Conversion Quality Tracking**
**Added fields:**
- `rewrite_time`: How long spent on conversion
- `atomicity_split_required`: Boolean flag
- `source_quotes_detected`: Boolean flag

**Purpose:** Track quality without blocking quantity

### Removed Features

#### 14. **Strict MOC Auto-Population**
**Originally:** AI automatically adds notes to MOCs  
**Removed:** Violates emergence principle  
**Replaced with:** Hub suggestions when traversal threshold met  

#### 15. **Complex Automation Profiles**
**Originally:** Conservative/Semi-auto/Aggressive modes  
**Removed:** Too complex, creates "set and forget" mindset  
**Replaced with:** Single system with configurable confidence thresholds  

#### 16. **Link Priority Field**
**Suggested:** Classify links as spine/supporting/marginal  
**Rejected:** Adds metadata burden without clear ROI  
**Alternative:** Health score already captures link importance  

### Philosophy Refinements

#### 17. **"Prefer Pruning Over Gatekeeping"**
**Applied to:**
- Hub creation (low threshold, monthly pruning)
- Tag proposals (permissive suggestions, quarterly review)
- Link suggestions (generous, but require rationale)

**Rationale:** Easier to delete than to never create; forgives wrong guesses

#### 18. **"Conversion IS Thinking"**
**Applied to:**
- Mandatory rewriting (no copy-paste)
- Relation verb requirement (articulate WHY)
- Synthesis scaffolding (structure only, human writes content)

**Rationale:** The act of processing creates understanding

---

## Final Notes

This specification represents 12 weeks of design work incorporating:
- Luhmann's original Zettelkasten principles
- Sönke Ahrens' smart notes workflow
- 2026 best practices for low-friction knowledge work
- User feedback on motivation and practical constraints
- Technical feasibility for local-first, $0-cost operation

**The system is designed to:**
1. Eliminate organizational busywork
2. Preserve intellectual agency
3. Enable emergent thinking
4. Scale sustainably
5. Cost nothing to operate

**Next steps:**
1. Review this specification thoroughly
2. Provide feedback on any unclear or problematic sections
3. Prioritize features for MVP
4. Begin Week 1 implementation

**Questions to consider:**
- Are the prompts clear enough for implementation?
- Are the thresholds (confidence scores, hub creation, etc.) reasonable?
- Is the metadata schema too heavy or just right?
- Are there any missing features critical for your workflow?
- Does the rollout timeline seem feasible?

---

**Document Status:** Final Draft  
**Last Updated:** April 22, 2026  
**Next Review:** After initial feedback pass

---

*This document is a living specification. As we implement and learn, it will evolve. Version control via git ensures we can track changes and understand our reasoning over time.*
