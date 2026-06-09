---
title: "ZettleLib"
description: "A Zettelkasten prompt contract library and architecture reference — deterministic note processing that works identically from Gemma2 9B to Claude."
author: "Jason Taylor"
role: "Product Manager"
status: "complete"
ai_role: "skill code generation within spec; prompt contracts authored by Jason"
tech_stack: ["Python", "Markdown", "YAML", "LanceDB", "Ollama"]
pm_skills: ["prompt engineering", "architecture design", "model-agnostic system design", "constraint-based AI design", "information architecture"]
keywords: ["Zettelkasten", "personal knowledge management", "prompt contracts", "Obsidian", "note-taking", "local LLM", "model-agnostic"]
date_completed: "2026-04"
---

# ZettleLib

> A Zettelkasten prompt contract library and architecture reference — terminal-driven note processing, serendipity, and Map of Content generation that works identically from Gemma2 9B to Claude.

Originally built as a skill for [Xochitl](../Xochitl). The skill has since been ported to [Hermes](https://github.com/hermes-cli/hermes) as a plugin. This repo is the canonical home for the prompt contracts and vault architecture.

---

## What This Is

ZettleLib started as a standalone app (server + Obsidian plugin). I rebuilt it as a **skill inside Xochitl** because the infrastructure was getting in the way of actually using the system.

**What it does now:**
- Runs inside Xochitl's terminal interface — no server, no plugin, no bat scripts
- Points at any folder your Obsidian vault lives in
- Processes permanent notes using a deterministic prompt contract system
- Surfaces non-obvious connections between notes via vector embeddings
- Generates Maps of Content on demand
- Works with Gemma2 9B local models all the way to Claude cloud — same output format every time

**My role:** Architecture design, prompt contract system design (`.txt` template + `.yaml` spec), parser design, fallback strategy, vault structure decisions, porting to Hermes.
**AI's role:** Skill code generation within my spec. The prompt contracts themselves — the actual LLM instructions — are authored by Jason, not generated.

**What it is not:**
- A standalone app
- A plugin
- Something you install separately

---

## TL;DR

You run Xochitl in your terminal. You say `let's work on zettles`. Xochitl scans your vault, processes your permanent notes with LLM-powered suggestions (tags, links, tension detection), and never blocks you. When you're done you say `done for today`. Your vault in Obsidian stays clean.

The LLM never writes to your files directly. Every suggestion goes through a confirmation step. All file writes happen when you say `accept`. Switch from a 9B local model to Claude and the output format stays identical — the prompt contracts guarantee it.

---

## Status

| Field | Value |
|---|---|
| **Phase** | Stable |
| **Stability** | Prompt contracts stable — skill code lives in Hermes plugin |
| **Last updated** | April 2026 |

---

## Results & Impact

- **Model portability:** 9 prompt contracts work identically from Gemma2 9B (local) to Claude (cloud) — same output format, same parser, same fallback behavior.
- **Ceiling test:** A clean note processes in 4 user exchanges or fewer. That's the design constraint and the runtime result.
- **What I learned:** The parsing strategy matters more than the prompt wording. Three parsers (`VOCAB_MATCH`, `PREFIX_EXTRACT`, `PATTERN_EXTRACT`) handle all 9 operations. The real reliability work is in tolerance for noisy model output, not in making the prompts longer.

---

## Repository Layout

```
ZettleLib/
├── beta-vault/
│   ├── _System/
│   │   ├── Prompt Library/         ← 9 prompt contracts (.txt + .yaml pairs)
│   │   └── vault-taxonomy.md       ← Seed tag list copied into new vaults
│   └── 80 System/                  ← Legacy Socratic prompts (reference only)
└── dev/
    └── implementation-plan-v3.md   ← The current architecture spec
```

The code lives in Xochitl at `src/skills/zettelkasten_skill.py` and friends. This repo is the **prompt contract library and architecture reference** — not the running application.

---

## Features

### Note Creation
| Command | What happens |
|---|---|
| `new note: [claim]` | Creates `Permanent/claim-as-slug.md` with scaffolded frontmatter |
| `new literature: [source]` | Creates `Literature/source-slug.md` with today's session header |

### Note Processing (`process note`)
Runs the full pipeline on the most recent permanent note (or a named one):

1. **Word count check** — flags if under 100 or over 400 words, non-blocking
2. **Atomicity check** — LLM detects if the note is making one claim or several (contract: `atomicity-check-v1`)
3. **Context collapse check** — flags phrases like "this argument" or "the former" that won't survive time
4. **Tag suggestion** — LLM selects from your approved `vault-taxonomy.md`, grounded so it can't invent tags (contract: `tag-suggestion-v1`)
5. **Link suggestion** — vector DB finds top candidates, LLM labels each relationship as EXTENDS / PARALLEL / TENSION / UNRELATED (contract: `link-label-v1`)
6. **Tension confirmation** — any TENSION link is confirmed with a second LLM pass on both note bodies before the ⚡ flag appears (contract: `tension-confirm-v1`)
7. **Single confirmation** — one `Accept / Edit` prompt, not one per step
8. **Passive serendipity** — after you accept, one non-obvious connection surfaces with a one-sentence explanation (contract: `serendipity-explain-v1`)
9. **Optional clarity check** — offered after acceptance, never blocks

### Fleeting Triage (`process fleeting`)
LLM pre-categorises every note in `Fleeting/` before you see them:
- **PROMOTE** — looks permanent-ready, prompts you to give it a claim title
- **KEEP** — leave it for now, no action needed
- **DISCARD** — looks ephemeral, asks for your confirmation before removing

Contract: `fleeting-triage-v1`. Fallback is always KEEP — nothing is auto-discarded.

### Serendipity (`what's connecting`)
On-demand scan across recent permanent notes via vector embeddings. Surfaces pairs of notes making the same argument from different domains, with a one-sentence explanation of the connection.

### Map of Content (`generate moc [topic]`)
On demand. Never maintained manually.

1. Vector DB retrieves all permanent notes related to the topic
2. Code clusters them by word overlap into 2–4 groups
3. LLM labels each cluster in 3–5 words (contract: `moc-cluster-label-v1`)
4. LLM selects the best entry point note ID (contract: `moc-entry-point-v1`)
5. Code assembles `_System/MOC_[topic].md` — LLM never writes to the file

Run it again to regenerate. The file always reflects the current state of the vault.

### Clarity Coaching (`clarity check`)
Optional. Offered after processing, available any time. LLM gives up to 3 specific suggestions (contract: `clarity-coaching-v1`). Falls back to heuristic checks (title-as-claim, vague qualifiers, bullets vs prose) if the contract isn't available.

### Vault Scaffold (`scaffold vault`)
Creates the full folder structure, Obsidian config, and copies the prompt contract library from this repo into `_System/Prompt Library/`. Run once per vault.

---

## Vault Structure

```
MyVault/
├── Fleeting/           Raw captures — shower thoughts, quick reactions
├── Literature/         One file per source, you add session-dated entries
├── Permanent/          One file per atomic claim — this is where the work lives
└── _System/            Xochitl-managed, hidden from Obsidian graph
    ├── Prompt Library/ The 9 prompt contracts — .txt templates + .yaml specs
    ├── vault-taxonomy.md  Approved tags — tag suggestion reads only from here
    ├── vault-index.md  One row per processed note — powers serendipity and MOC
    ├── Decision Log.md Append-only audit trail of every action
    ├── Parked Questions.md Unresolved intellectual threads
    └── MOC_*.md        Generated Maps of Content
```

`_System/` and `Fleeting/` are excluded from the Obsidian graph. Permanent and Literature notes are visible.

### Permanent Note Format

```markdown
---
id: 20260511-001
created: 2026-05-11
source:
tags: [strategy, design-thinking]
status: seedling
links:
  - note: "Customer jobs are tripartite"
    type: EXTENDS
processed_with: atomicity-check-v1 tag-suggestion-v1 link-label-v1
---

# Value maps describe mechanism not promise

[2–4 sentences. Standalone prose. Written for future-you without today's context.
No bullet points. No headers.]

[[Customer jobs are tripartite]] — extends
```

**Status:** `seedling` → `evergreen`. You promote manually. Xochitl never decides status.  
**Word count:** 100–400 words. 100–200 is the sweet spot.  
**Title:** One specific, arguable claim — not a topic heading.

---

## Prompt Contract System

Every LLM call in this skill uses a **prompt contract** — a `.txt` template + `.yaml` spec. This is what makes the skill work identically across a Gemma2 9B local model and Claude.

### Why contracts

Without contracts, "generate a MOC" returns different structure from every model. With contracts, every LLM call does exactly one thing — classify or label from a constrained set. The model fills one slot. Code does everything else.

### The four rules

1. LLM classifies or labels from a constrained set. Code does everything else.
2. LLM never writes to vault files. Code assembles all file content from structured responses.
3. Every LLM call is single-turn. No chat history. Fresh context per call.
4. Every parser tolerates noise. Imperfect model output is assumed, not exceptional.

### Three parsers

All 9 operations use exactly one parser each:

```
VOCAB_MATCH     Word-boundary search — tolerates preamble, explanation, case variation
                re.search(r'\b(ONE|MULTIPLE)\b', output, re.IGNORECASE)

PREFIX_EXTRACT  Finds PREFIX: value lines — tolerates markdown noise and extra lines
                re.findall(r'^TAG:\s*(.+)$', output, re.MULTILINE | re.IGNORECASE)

PATTERN_EXTRACT Regex match anywhere in output — used for note IDs
                re.search(r'\d{8}-\d{3}', output)
```

If a parser returns nothing, it retries once with the same prompt. If it fails again, it applies the fallback defined in the contract YAML (`SKIP`, `NONE`, `FIRST`, or a literal `VALUE`). Nothing ever blocks.

### All 9 contracts

| Contract | Parser | Vocabulary / Config | Temp | Fallback |
|---|---|---|---|---|
| `atomicity-check-v1` | VOCAB_MATCH | ONE, MULTIPLE | 0 | SKIP |
| `tag-suggestion-v1` | PREFIX_EXTRACT | prefix=TAG, max=3 | 0 | NONE |
| `link-label-v1` | VOCAB_MATCH | EXTENDS, PARALLEL, TENSION, UNRELATED | 0 | UNRELATED |
| `tension-confirm-v1` | VOCAB_MATCH | TENSION, ALIGNED | 0 | ALIGNED |
| `moc-cluster-label-v1` | PREFIX_EXTRACT | prefix=LABEL, max=1 | 0.3 | "Cluster N" |
| `moc-entry-point-v1` | PATTERN_EXTRACT | `\d{8}-\d{3}` | 0 | FIRST |
| `serendipity-explain-v1` | PREFIX_EXTRACT | prefix=EXPLAIN, max=1 | 0.3 | SKIP |
| `fleeting-triage-v1` | VOCAB_MATCH | PROMOTE, KEEP, DISCARD | 0 | KEEP |
| `clarity-coaching-v1` | PREFIX_EXTRACT | prefix=SUGGESTION, max=3 | 0.4 | NONE |

Temperature 0 for all classification. Slightly higher only where label phrasing benefits from variation.

### Contract file format

Each contract is two files in `_System/Prompt Library/`:

**`atomicity-check-v1.txt`** — the prompt template:
```
[CONTEXT]
You are checking if a Zettelkasten permanent note makes exactly one claim.

[INPUT]
Title: {{title}}
Body: {{body}}

[INSTRUCTION]
Decide whether this note makes exactly one claim or more than one claim.

[OUTPUT FORMAT]
ONE word only: ONE or MULTIPLE
Do not explain. Do not add any other text.

[EXAMPLE]
Input Title: "Constraints reveal system values"
Input Body: "Every system has implicit priorities..."
Output: ONE
```

**`atomicity-check-v1.yaml`** — the contract spec:
```yaml
version: 1
operation: atomicity-check
parser: VOCAB_MATCH
parser_config:
  vocabulary: [ONE, MULTIPLE]
temperature: 0
single_turn: true
fallback:
  type: SKIP
grounding: null
```

The `[EXAMPLE]` section is mandatory — it's the single biggest compliance driver for small local models. It goes last so it's closest to where generation begins.

### Grounding

Tag suggestion is grounded to `vault-taxonomy.md`. Any tag the LLM suggests that isn't in your taxonomy file is silently dropped. The LLM physically cannot invent a tag — it only selects from what you give it.

### Version policy

Bump the version (`v1` → `v2`) only when the output type, prefix, or vocabulary changes. Rewording the prompt within the same structure does not need a version bump. The `processed_with` field in each note's frontmatter records which contract version touched it — permanent audit trail.

---

## Session Flow

```
you:  let's work on zettles
xo:   [ZETTEL MODE] 2 fleeting notes, 1 permanent note ready. Parked: 3 questions.

you:  new note: value maps describe mechanism not promise
xo:   Created Permanent/value-maps-describe-mechanism-not-promise.md — open it in Obsidian.

[You write the body in Obsidian. Come back to the terminal when done.]

you:  process note
xo:   183 words.

      Tags: #strategy #design-thinking
      Links:
        [[Customer jobs are tripartite]] — extends
        [[Constraints reveal system logic]] — parallel
        ⚡ [[Good strategy optimises for outcomes]] — tension

      Accept / Edit

you:  accept
xo:   Done.

      One non-obvious connection the vault surfaced:
        [[First Principles Thinking]] — both argue the frame you choose determines
        what's designable. [0.87]

      Feel real or forced?

you:  real
xo:   Added. → Clarity check? (optional)

you:  [ignores]

you:  done for today
xo:   [ZETTEL MODE OFF] Back to normal.
```

Total exchanges for a clean note: **4**. That is the ceiling.

---

## Setup

### Prerequisites

- [Xochitl](../Xochitl) installed and running
- [Ollama](https://ollama.ai) running locally with `nomic-embed-text` pulled (for vector embeddings)
- Obsidian pointing at your vault folder

### 1. Pull the embedding model

```bash
ollama pull nomic-embed-text
```

### 2. Set your vault path

In Xochitl's `.env`:
```
VAULT_PATH=C:\Users\You\Documents\MyVault
```

### 3. Scaffold the vault

```
xochitl
you: scaffold vault
```

This creates `Fleeting/`, `Literature/`, `Permanent/`, `_System/` and copies the prompt contract library from this repo into `_System/Prompt Library/`.

Open Obsidian → `Open folder as vault` → point to the same folder.

### 4. Start working

```
xochitl
you: let's work on zettles
```

---

## Command Reference

| Command | Description |
|---|---|
| `let's work on zettles` | Enter zettel mode — scans vault, reports status |
| `done for today` | Exit zettel mode — logs session summary |
| `new note: [claim]` | Create a new permanent note with scaffolded frontmatter |
| `new literature: [source]` | Create a literature note for a source |
| `process note` | Run the full pipeline on the most recent permanent note |
| `process note [filename]` | Run pipeline on a specific note |
| `accept` | Confirm pending tag/link suggestions — writes frontmatter |
| `process fleeting` | Triage inbox — LLM pre-categorises PROMOTE / KEEP / DISCARD |
| `clarity check` | Clarity coaching on the current note |
| `what's connecting` | On-demand serendipity scan across recent notes |
| `generate moc [topic]` | Build or regenerate a Map of Content |
| `vault status` | Current counts: fleeting, permanent, parked questions |
| `scaffold vault` | Create vault folder structure + copy prompt library |

---

## Design Principles

**Minimal friction.** Every step either runs silently or asks one question. Never two consecutive questions. The note-processing ceiling is 4 exchanges for a clean note.

**LLM suggests, human decides.** The LLM never writes to vault files. Every tag, link, and suggestion surfaces for confirmation. Xochitl announces what it's doing and waits.

**Faithful to Luhmann.** Three note types only: Fleeting (raw), Literature (source reference), Permanent (atomic claims). No Incubating, Maps, Projects, or Hub folders added without your request.

**Deterministic across models.** The prompt contract system means Gemma2 9B and Claude produce output in the same format. Parsers tolerate model noise. Fallbacks handle parse failure. Nothing blocks on a bad model response.

**Grounded, not hallucinated.** Tags come only from `vault-taxonomy.md`. MOC note references come only from `vault-index.md`. The LLM selects from what exists — it cannot invent connections that aren't in your vault.

---

## Architecture Notes

The skill is split across four files in Xochitl's `src/skills/`:

| File | Responsibility |
|---|---|
| `zettelkasten_skill.py` | Mode state, note creation, command routing |
| `zettelkasten_process.py` | Processing pipeline, pending state, confirm flow |
| `zettelkasten_contracts.py` | ContractLoader, 3 parsers, retry logic, grounding |
| `zettelkasten_moc.py` | MOC generation: retrieval, clustering, assembly |
| `zettelkasten_scaffold.py` | Vault creation, Obsidian config, contract file copy |

The vector DB (`src/memory.py` in Xochitl) handles all semantic retrieval. LLM calls only classify or label what the vector DB surfaces — they never retrieve from their training knowledge.

---

## Challenges & Decisions

### Prompt contracts over freeform prompting
**Problem:** Without output contracts, every LLM produces a different format for the same operation. A MOC from Gemma2 looked nothing like one from Claude. Parsers broke constantly.
**Decision:** Formalize every LLM call as a `.txt` template + `.yaml` spec. Constrained vocabulary, single-turn, fixed parser per operation. The LLM fills one slot; code does everything else.
**Tradeoff:** More upfront design work per operation. Each new feature requires a new contract, not just a new prompt.
**Outcome:** 9 operations, all model-agnostic. The skill works identically regardless of which LLM is configured.

### Separating the contract library from the skill code
**Problem:** The prompt contracts and vault architecture are stable artifacts. The skill code changes as the host system (Xochitl, then Hermes) evolves. Coupling them means every skill refactor risks the contracts.
**Decision:** Extract the prompt contract library into its own repo (ZettleLib). Skill code lives in the host system; contracts live here.
**Tradeoff:** Two repos to maintain. Changes to the contract format require coordination across both.
**Outcome:** Contracts evolved independently through one major refactor without breaking the skill. The separation was worth the coordination overhead.

---

## This Repo vs The Xochitl Repo

| | ZettleLib (this repo) | Xochitl |
|---|---|---|
| What it is | Prompt contract library + architecture reference | The running application |
| Where code lives | — | `src/skills/zettelkasten_*.py` |
| Where contracts live | `beta-vault/_System/Prompt Library/` | Copied into your live vault at scaffold time |
| What you edit here | Contract templates, vault-taxonomy seed, this plan | Skill logic, routing, memory |

When you change a contract template here, re-scaffold or manually copy the updated `.txt`/`.yaml` files into your live vault's `_System/Prompt Library/`.

---

## How This Was Built

ZettleLib started as a standalone server + Obsidian plugin. I rebuilt it as a Xochitl skill because the infrastructure was getting in the way of actually using the system. The key architectural insight came from watching how different LLMs handled the same prompt: without strict output contracts, every model produced different structure. I designed the prompt contract system (`.txt` template + `.yaml` spec, single-turn, constrained vocabulary) specifically to make the skill model-agnostic.

I later extracted the skill and ported it to Hermes as a plugin, separating the prompt contract library (this repo) from the running skill code. That separation was the right call: contracts can evolve independently of the application.
