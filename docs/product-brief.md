---
title: ZettleLib Product Brief
status: draft
created: 2026-06-08
updated: 2026-06-08
---

# ZettleLib

> A prompt contract library and architecture reference for AI-powered Zettelkasten — model-agnostic by design, so the same workflow runs identically on a local Gemma2 9B or Claude.

---

## Executive Summary

ZettleLib is the canonical home for the prompt contracts and vault architecture that power an AI-assisted Zettelkasten workflow. It started as a skill inside Xochitl (a personal AI assistant) and has since been ported to Hermes as a plugin. The repo itself contains no application code — just the prompt templates, contract specs, and vault structure that make the skill work.

The central engineering insight: without strict output contracts, every LLM produces different structure from the same prompt. With contracts, every call is constrained to a single classification task from a defined vocabulary. The model fills one slot. Code does everything else.

---

## The Problem

Zettelkasten is a powerful note-taking methodology — atomic claims, explicit links between ideas, deliberate knowledge structure. Most people who try it abandon it because the maintenance overhead is too high: tagging consistently, finding connections between notes, keeping the inbox from filling up.

AI can help, but unstructured AI assistance creates its own problems: different models produce different output formats, the LLM writes directly to files (risking bad edits), and there's no audit trail of what changed or why.

---

## The Solution

A **prompt contract system**: every LLM call in the skill uses a `.txt` template + `.yaml` spec. Each contract does exactly one thing — classify or label from a constrained set. The model fills one slot. Code does everything else.

**Four rules that make it work:**
1. LLM classifies or labels from a constrained set. Code does everything else.
2. LLM never writes to vault files. Code assembles all file content from structured responses.
3. Every LLM call is single-turn. No chat history. Fresh context per call.
4. Every parser tolerates noise. Imperfect model output is assumed, not exceptional.

**What this enables in practice** — a full Zettelkasten processing session from the terminal:
- Process a permanent note through 9 automated steps (atomicity check, tag suggestion, link labeling, tension detection, serendipity) in 4 exchanges
- Triage the fleeting inbox with LLM pre-categorization (PROMOTE / KEEP / DISCARD)
- Generate Maps of Content on demand from vector embeddings — never maintained manually
- Run the same workflow on a local Gemma2 9B or Claude cloud — identical output format every time

**Grounding over hallucination:** Tags can only be selected from `vault-taxonomy.md` — the LLM cannot invent a tag that isn't in your approved list. MOC references can only come from `vault-index.md`. The same anti-hallucination philosophy as Applyr, applied to knowledge management.

---

## Architecture

The repo contains the **prompt contracts and vault architecture**. The running skill code lives in Hermes (ported from Xochitl). The separation was intentional: prompt contracts evolve independently of application code.

| Layer | Location |
|---|---|
| Prompt contracts (9 templates + YAML specs) | `beta-vault/_System/Prompt Library/` |
| Vault taxonomy seed | `beta-vault/_System/vault-taxonomy.md` |
| Architecture spec | `dev/implementation-plan-v3.md` |
| Skill code | Hermes plugin (separate repo) |

**9 prompt contracts across 3 parser types:**

| Parser | Used for |
|---|---|
| `VOCAB_MATCH` | Binary or multi-class classification (atomicity, link type, tension) |
| `PREFIX_EXTRACT` | Structured list output (tags, MOC labels, suggestions) |
| `PATTERN_EXTRACT` | ID extraction (MOC entry point note) |

Temperature 0 for all classification. Slightly higher only where label phrasing benefits from variation (MOC labels, serendipity).

---

## Design Principles

**Minimal friction.** Processing a clean note takes 4 exchanges maximum — that's the ceiling, not the average.

**LLM suggests, human decides.** Tags, links, and suggestions all surface for confirmation. The LLM never writes to vault files.

**Faithful to Luhmann.** Three note types only: Fleeting, Literature, Permanent. The system doesn't add categories or folders the methodology doesn't call for.

**Deterministic across models.** The contract system means model choice is an infrastructure decision, not a product decision. Swap from local to cloud without changing a single workflow step.

---

## Status

Stable. Prompt contracts are finalized. The skill runs inside Hermes. This repo is the reference and library — not the running application.

---

## Who This Serves

Anyone using Zettelkasten methodology with Obsidian who wants AI assistance that doesn't make a mess: doesn't invent connections, doesn't write to files without confirmation, and works the same way regardless of which model is running underneath.
