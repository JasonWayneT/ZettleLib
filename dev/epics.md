---
stepsCompleted: ['step-01-validate-prerequisites', 'step-02-design-epics']
inputDocuments:
  - '_bmad-output/planning-artifacts/prd.md'
  - '_bmad-output/planning-artifacts/product-brief-ZettleLib.md'
  - 'ZettleManagement/librarian-engine-v2-specification.md'
project_name: 'ZettleLib'
user_name: 'Jason'
date: '2026-04-22'
---

# ZettleLib - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for ZettleLib, decomposing requirements from the Product Brief, PRD, and Librarian Engine V2 Specification into implementable stories.

---

## Requirements Inventory

### Functional Requirements

**Core Processing Pipeline**

FR1: System must guide the user to classify every inbox note into exactly one of four categories: DELETE, TASK, SOURCE, or CLAIM (Triage — Prompt J).
FR2: System must facilitate an atomicity check for CLAIM notes by asking Socratic questions (Atomicity Check — Prompt A).
FR3: System must offer a "Fast Track" for notes that appear solid and atomic, allowing the user to skip deep questioning (Prompt A).
FR4: When a note is MACRO, system must facilitate the discovery of split points through questioning (Prompt A).
FR5: System must inquire about the enduring value of CLAIM notes (transcends context, reference in 6 months, reusable building block) (Prompt A).
FR6: System must assign tags from a canonical Master Tag List, enforcing a hard cap of 3 tags per note (Semantic Tagging — Prompt B).
FR7: System must detect synonym clusters and tag drift, flagging proposed deduplication merges for human review (Prompt B).
FR8: System must maintain internal confidence scores for tag proposals; scores must not be revealed to the user (Prompt B).
FR9: System must discover note connections using semantic relation verbs from a controlled vocabulary: extends, contradicts, applies, exemplifies, refines, supports, analogizes, inverts, parallels (Link Discovery — Prompt C).
FR10: System must enforce a link budget of max 3 direct connections + 2 weak signal connections per note (Prompt C).
FR11: Every proposed link must include the target note, relation verb, and a one-sentence rationale; confidence scores remain internal (Prompt C).
FR12: System must detect contradictions between new and existing notes (cosine similarity >0.7) and flag them with confidence scores (Dialectic Engine — Prompt G).
FR13: When a contradiction is detected, system must guide the human through a dialectic resolution — human writes the actual synthesis (Prompt G).
FR13b: System must support "Parking" unresolved questions into a central `Parked Questions.md` index for later retrieval (Prompts J, A, G).
FR14: System must track tag cluster size and manual traversal counts to determine hub creation eligibility (Hub Tracking — Prompt D).
FR15: Hub creation thresholds must be vault-size adaptive: beginner (<50 notes) = 3 notes + 2 traversals; growing (50–200) = 5 notes + 3 traversals; mature (200+) = 7 notes + 5 traversals (Prompt D).
FR16: System must generate daily serendipity connections: max 3 per day, minimum confidence 0.60, ignoring direct links and shared tags (Serendipity Engine — Prompt E).
FR17: System must detect stagnant notes (stable >60 days, 0 child notes) and suggest Narrow/Broaden/Challenge elaboration directions (Elaboration Suggester — Prompt F).
FR18: System must generate writing outlines from relevant permanent notes, identifying gaps (concepts referenced but not yet written) and providing per-section word count estimates (Outline Generator — Prompt H).
FR19: System must run a monthly health audit using an "Adversarial Pass" to find 5+ concrete weaknesses before calculating health scores (Audit — Prompt I).
FR19b: System must maintain a "Processing Summary" in the chat context to preserve session state across prompts (System-wide).

**Human Governance Layer**

FR20: Every AI suggestion must require explicit human approval before any change is applied to the vault (AI suggests, human commits — no auto-apply).
FR21: Every AI decision must be logged to Decision Log.md in the vault with timestamp, note path, decision details, and rollback information.
FR22: System must support rollback of any AI decision.
FR23: System must present decisions with a clear choice interface (Accept / Reject / Modify options).
FR24: AI suggestions must prioritize internal confidence but avoid revealing scores or issuing definitive verdicts.

**Master Tag List & Taxonomy**

FR25: System must maintain a Master Tag List as a human-readable markdown file in the vault.
FR26: Tag proposals approved by the user must be automatically added to the Master Tag List.
FR27: System must run weekly tag utility analysis, identifying tags never cited in output notes (dead-weight candidates).

**Config & Multi-LLM Support**

FR28: System must ship as three LLM-specific instruction files: CLAUDE.md for Claude CLI, GEMINI.md for Gemini CLI, and AGENTS.md for local/generic LLMs.
FR29: All three config files must encode the complete Zettelkasten workflow (prompts J, A, B, C, D, E, F, G, H, I) as LLM-readable operating instructions.
FR30: Config files must be installable by copying a single file into the vault root — no installer, no dependencies beyond the chosen LLM CLI.
FR31: Config files must support user-driven co-evolution: conventions, domain vocabulary, and refinements accumulated through real use must be embeddable in the config.

**Note Metadata Schema**

FR32: Every permanent note must support a comprehensive frontmatter schema covering identity, taxonomy, maturity, genealogy, connectivity (with relation verbs), usage analytics, and future-self fields.
FR33: System must write and maintain note frontmatter as part of the processing workflow.

**Vault Structure**

FR34: System must assume and reference the standard vault folder structure: 00 Inbox, 10 Literature, 15 Incubating, 20 Permanent, 70 Projects, 80 System, 90 Maps.
FR35: System must move notes between folders as part of workflow decisions (e.g., TASK → task manager, SOURCE → 10 Literature, CLAIM → 20 Permanent).

**Governance Dashboards**

FR36: System must support a weekly governance dashboard surfacing: pending tag proposals, tag utility warnings, orphan notes (0 links after 7 days), weekly throughput metrics.
FR37: System must generate a monthly hub pruning review identifying low-value hubs (no updates in 90 days, few visits).
FR38: System must detect and report stale literature notes (>60 days unprocessed).

---

### Non-Functional Requirements

NFR1: Note processing time must be <3 minutes per note (vs 5–10 minutes manual).
NFR2: AI response latency must be <2 seconds per prompt invocation.
NFR3: Weekly governance time investment must be <30 minutes.
NFR4: Monthly audit time investment must be <45 minutes.
NFR5: Operational cost must be $0/month (local inference; no mandatory subscription).
NFR6: All user data must remain local unless the user explicitly opts into a remote LLM.
NFR7: Atomicity success rate target: >85% of notes pass without requiring a split.
NFR8: Tag deduplication target: 0% duplicate or synonym tags in the Master Tag List.
NFR9: Connectivity target: >70% of permanent notes have 3+ bidirectional links.
NFR10: Output integration target: >50% of permanent notes cited in written outputs within 1 year.
NFR11: AI decision reversal rate target: <15% (users should rarely need to undo AI decisions).
NFR12: Conversion quality signal: average rewrite time >90 seconds (flags rushed processing).
NFR13: Link quality: 100% of proposed links must include relation verb + rationale.
NFR14: Hub utility: <10% of hubs pruned per month (structure created should be useful).
NFR15: Cross-domain surprise target: >10 weak-signal connections per month.
NFR16: Elaboration rate target: >20% of permanent notes spawn child notes within 90 days.
NFR17: System must be LLM-agnostic — workflow must produce equivalent results across Claude CLI, Gemini CLI, and local Ollama-compatible models.

---

### Additional Requirements

> **Scope Decision (confirmed by Jason, 2026-04-22):**
> Phase 1 MVP = LLM config files only (CLAUDE.md, GEMINI.md, AGENTS.md). No Python, no file watcher, no embeddings database. The LLM reads the config and operates directly on vault markdown files. User invokes the LLM on demand. Git provides rollback. Dataview reads ZettleLib-written frontmatter for dashboards.
>
> Python orchestration and full automation pipeline are explicitly deferred to Phase 2 and Phase 3 (see Roadmap below).

- ARC1: Vault folder structure must follow the seven-folder convention from the V2 spec (00–90 series): 00 Inbox, 10 Literature, 15 Incubating, 20 Permanent, 70 Projects, 80 System, 90 Maps.
- ARC2: All prompts (J, A, B, C, D, E, F, G, H, I) must be authored as versioned markdown files stored in `/80 System/Prompt Library/` within the vault, referenced by the config files.
- ARC3: Config files must be LLM-specific: CLAUDE.md targets Claude CLI conventions, GEMINI.md targets Gemini CLI, AGENTS.md targets Ollama/generic LLMs. All three must implement the same workflow logic.
- ARC4: Dataview plugin is the dashboard query layer — ZettleLib writes frontmatter, Dataview reads it for weekly metrics and governance views. ZettleLib must not require a custom Obsidian plugin.
- ARC5: Git is the sole version control and rollback mechanism in Phase 1. No custom rollback scripts required.
- ARC6: The Master Tag List and Decision Log are plain markdown files in the vault (80 System folder), maintained by the LLM during processing sessions.
- ARC7: Config files must be self-contained and composable — the user must be able to refine and extend their config over time without breaking prior workflow instructions.

---

### Roadmap (Future Phases — Out of Scope for Phase 1 Epics)

**Phase 2 — Advanced Reasoning & Scalability**
- Integration of specialized "Socratic Models" (Gemma 2 27B / Llama 3 70B) for deep dialectic sessions.
- Systematic vault-wide contradiction mapping.
- Community config variants (domain-tuned CLAUDE.md/GEMINI.md/AGENTS.md for academic research, product management, creative writing).
- Marp presentation generation from permanent notes + outlines.
- Broader Obsidian ecosystem integrations.

---

### UX Design Requirements

*No UX design document exists — this is expected for a CLI/config-file tool with no traditional UI.*

---

### FR Coverage Map

| FR | Epic | Summary |
|---|---|---|
| FR1 | Epic 2 | Triage classification into DELETE/TASK/SOURCE/CLAIM (Prompt J) |
| FR2 | Epic 2 | Atomicity assessment: ATOMIC/MICRO-ATOMIC/MACRO/NON-ENDURING (Prompt A) |
| FR3 | Epic 2 | Split proposals with line ranges and rationale for MACRO notes (Prompt A) |
| FR4 | Epic 2 | Merge suggestions for MICRO-ATOMIC notes (Prompt A) |
| FR5 | Epic 2 | Enduring value assessment: PROMOTE/INCUBATE/DISCARD (Prompt A) |
| FR6 | Epic 2 | Semantic tagging from canonical Master Tag List, max 3 tags (Prompt B) |
| FR7 | Epic 2 | Synonym/tag drift detection and deduplication proposals (Prompt B) |
| FR8 | Epic 2 | New tag proposals with confidence scores; below 0.60 flagged for review (Prompt B) |
| FR9 | Epic 2 | Semantic relation verb connections from controlled vocabulary (Prompt C) |
| FR10 | Epic 2 | Link budget enforcement: max 3 direct + 2 weak signal per note (Prompt C) |
| FR11 | Epic 2 | Every link includes target, relation verb, one-sentence rationale, confidence (Prompt C) |
| FR12 | Epic 6 | Contradiction detection between new and existing notes (cosine sim >0.7) (Prompt G) |
| FR13 | Epic 6 | Synthesis scaffolds with Claim A, Claim B, resolution frameworks (Prompt G) |
| FR14 | Epic 7 | Hub creation eligibility tracking via cluster size + traversal counts (Prompt D) |
| FR15 | Epic 7 | Vault-size adaptive hub thresholds: beginner/growing/mature (Prompt D) |
| FR16 | Epic 3 | Daily serendipity connections: max 3/day, confidence >0.60 (Prompt E) |
| FR17 | Epic 3 | Stagnant note detection (>60 days, 0 children) + Narrow/Broaden/Challenge suggestions (Prompt F) |
| FR18 | Epic 4 | Writing outline from permanent notes with gap identification + word estimates (Prompt H) |
| FR19 | Epic 5 | Monthly Luhmann health audit: atomicity, connectivity, emergence, output, health score (Prompt I) |
| FR20 | Epics 2–7 | Human approval required for every AI action before vault change |
| FR21 | Epic 5 | Decision Log.md maintained with timestamp, note path, decision, rollback info |
| FR22 | Epic 5 | Rollback support for any AI decision via git |
| FR23 | Epics 2–7 | Confidence scores + plain-language reasoning on every suggestion |
| FR24 | Epics 2–7 | Accept/Reject/Modify decision interface |
| FR25 | Epic 5 | Master Tag List as human-readable markdown file in vault |
| FR26 | Epic 5 | Approved tags auto-added to Master Tag List |
| FR27 | Epic 5 | Weekly tag utility analysis: tags never cited in output |
| FR28 | Epic 8 | Three LLM-specific config files: CLAUDE.md, GEMINI.md, AGENTS.md |
| FR29 | Epic 8 | All three configs encode the complete workflow (Prompts J, A, B, C, D, E, F, G, H, I) |
| FR30 | Epic 1 | Single-file installation: copy one file into vault root |
| FR31 | Epic 8 | Config co-evolution: conventions and refinements embeddable over time |
| FR32 | Epic 2 | Full note frontmatter schema: identity, taxonomy, maturity, genealogy, connectivity, analytics, future-self |
| FR33 | Epic 2 | Frontmatter written and maintained by LLM during processing sessions |
| FR34 | Epic 1 | Standard vault folder structure: 00 Inbox through 90 Maps |
| FR35 | Epic 1 | Note routing between folders as part of workflow decisions |
| FR36 | Epic 5 | Weekly governance dashboard: pending tags, orphans, metrics, warnings |
| FR37 | Epic 5 | Monthly hub pruning review: low-value hubs flagged for archival |
| FR38 | Epic 5 | Stale literature detection: notes >60 days unprocessed flagged |

---

## Epic List

### Epic 1: Vault Foundation & Setup
A ZettleLib user can initialize their vault with the correct folder structure, Master Tag List template, and Decision Log template, and install ZettleLib with a single config file copy — in under 5 minutes.
**FRs covered:** FR30, FR34, FR35
**ARCs:** ARC1, ARC6, ARC7
**Deliverables:** Vault folder scaffold documentation, README with setup instructions, Master Tag List template, Decision Log template

---

### Epic 2: Core Note Intake Pipeline
A ZettleLib user can process any inbox note through the complete triage → atomicity → tagging → linking pipeline, with AI assistance and explicit human approval at each decision point.
**FRs covered:** FR1–FR11, FR20, FR23–FR24, FR32–FR33
**NFRs:** NFR1, NFR7–NFR9, NFR12–NFR13
**Deliverables:** Prompts J, A, B, C as versioned markdown files in `/80 System/Prompt Library/`; these prompts integrated into CLAUDE.md (primary dogfood config)
*Note: This is the core of Phase 1 — the most critical epic to validate.*

---

### Epic 3: Daily Intelligence Engine
A ZettleLib user can discover non-obvious cross-domain connections through daily serendipity sessions, and receive targeted elaboration prompts for notes that have stagnated without branching.
**FRs covered:** FR16–FR17, FR20, FR23–FR24
**NFRs:** NFR15–NFR16
**Deliverables:** Prompts E, F

---

### Epic 4: Writing Output Bridge
A ZettleLib user can generate a structured writing outline from their permanent note collection on any topic, with gap identification and per-section word estimates — ready to draft immediately.
**FRs covered:** FR18, FR20, FR23–FR24
**NFRs:** NFR1
**Deliverables:** Prompt H

---

### Epic 5: Vault Governance & Health
A ZettleLib user can maintain vault quality through a weekly governance session (tag proposals, orphan detection, hub pruning, metrics dashboard) and a monthly Luhmann health audit with actionable improvement recommendations.
**FRs covered:** FR19, FR21–FR22, FR25–FR27, FR36–FR38
**NFRs:** NFR3–NFR4, NFR8, NFR11, NFR14
**Deliverables:** Prompt I; Dataview dashboard queries for weekly metrics; hub pruning prompt; stale literature detection prompt

---

### Epic 6: Dialectic & Contradiction Detection *(advanced — optional within Phase 1)*
A ZettleLib user can detect intellectual contradictions between notes and receive AI-generated synthesis scaffolds, preventing silent inconsistency from accumulating in the vault.
**FRs covered:** FR12–FR13, FR20, FR23–FR24
**Deliverables:** Prompt G
*Note: Not in the product brief's explicit Phase 1 list (J, A, B, C, E, H, I). Included as optional Phase 1 since it is a config file — no extra infrastructure required.*

---

### Epic 7: Evidence-Based Hub Creation *(advanced — optional within Phase 1)*
A ZettleLib user can let Maps of Content emerge naturally from actual usage patterns, with hub creation suggested only when vault-size-adaptive evidence thresholds are met — never prematurely.
**FRs covered:** FR14–FR15, FR21, FR25–FR27
**Deliverables:** Prompt D; traversal tracking frontmatter fields documented
*Note: Same as Epic 6 — optional Phase 1. Not in the product brief's explicit Phase 1 prompt list.*

---

### Epic 8: Multi-LLM Packaging & Community Release
Any knowledge worker can install ZettleLib regardless of their chosen LLM — Claude CLI, Gemini CLI, or local Ollama — with equivalent workflow quality and clear per-LLM setup guides.
**FRs covered:** FR28–FR31
**NFRs:** NFR5–NFR6, NFR17
**ARCs:** ARC3, ARC7
**Deliverables:** GEMINI.md and AGENTS.md (porting validated CLAUDE.md workflow); per-LLM setup guides; polished public README; GitHub repository preparation
