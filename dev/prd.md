---
stepsCompleted: ['step-01-init', 'step-02-discovery', 'step-02b-vision', 'step-02c-executive-summary']
inputDocuments: ['product-brief-ZettleLib.md', 'librarian-engine-v2-specification.md', 'zettelkasten-low-friction-best-practices-2026.pdf', 'philosophy.md']
classification:
  projectType: 'LLM configuration layer — a set of LLM instruction files (CLAUDE.md, GEMINI.md, AGENTS.md) that turn any capable LLM CLI into a disciplined Zettelkasten maintainer. Not traditional software.'
  domain: 'Knowledge Work Infrastructure'
  complexity: 'Low-to-medium — complexity lives entirely in prompt/instruction quality. Infrastructure is zero. Hard problem is instructions that work across real vaults and multiple LLM backends.'
  projectContext: 'greenfield-with-blueprint'
  distributionModel: 'GitHub repo — 3 config files + docs. Installation = copy one file into vault root.'
  architecturePrinciples:
    - 'Socratic Thinking Partner: AI suggests/observes/inquires; human decides/responds. No verdicts.'
    - 'File-system-native: reads and writes markdown files directly'
    - 'Intentional invocation: user runs LLM on demand, or follows the "What should I do?" flow'
    - 'Git as first-class infrastructure: rollback, history, and collaboration via existing git repo'
    - 'Dataview as query layer: ZettleLib writes frontmatter, Dataview displays dashboards'
    - 'LLM-agnostic: CLAUDE.md for Claude CLI, GEMINI.md for Gemini CLI, AGENTS.md for local/generic LLMs'
    - 'Co-evolving config: users refine their config file over time with the LLM'
    - 'Obsidian as primary viewer — uses existing plugins (Local REST API, Dataview), not a custom plugin'
  roadmapItems:
    phase2:
      - 'Optional file watcher for auto-processing (opt-in only, never default)'
      - 'Image download workflow: local assets folder, LLM reads text then images separately'
    phase3:
      - 'Marp presentation generation from permanent notes + outlines'
      - 'Community config variants: domain-tuned CLAUDE.md/GEMINI.md/AGENTS.md files'
workflowType: 'prd'
project_name: 'ZettleLib'
user_name: 'Jason'
date: '2026-04-22'
---

# Product Requirements Document - ZettleLib

**Author:** Jason
**Date:** 2026-04-22

---

## Executive Summary

ZettleLib is an LLM configuration layer that transforms any capable LLM CLI into a disciplined Zettelkasten maintainer. The product ships as three instruction files — `CLAUDE.md` for Claude CLI, `GEMINI.md` for Gemini CLI, and `AGENTS.md` for local or generic LLMs — that encode the complete Zettelkasten workflow as LLM-readable operating instructions. Installation is a single file copy into a markdown vault root. There is no application to install, no subscription to pay, and no data that leaves the user's machine unless the user chooses it.

The product targets knowledge workers and students who understand the Zettelkasten method but cannot sustain its discipline at scale, and aspiring practitioners who have attempted the method and abandoned it due to maintenance overhead. The core problem is not tooling — Obsidian, Logseq, and Roam provide capable canvases. The problem is the discipline gap: the organizational overhead required to maintain a well-connected, atomic, tag-consistent vault grows faster than most practitioners can absorb while also doing the actual thinking the method is supposed to accelerate.

ZettleLib removes that overhead by making the LLM a **Socratic thinking partner**. Instead of issuing verdicts or classifications, the AI asks targeted questions that help the human see their own thinking more clearly. It facilitates the triage of inbox notes, guides atomicity discovery, maintains tag taxonomy, discovers semantic connections with explicit relation verbs, flags contradictions, and surfaces non-obvious connections. The human answers, resolves, and synthesizes. The result is a vault that compounds — one where new knowledge is automatically connected to prior knowledge, and where the user's relationship with their vault shifts from maintenance burden to idea generator.

Key 2.0 enhancements include a "What should I do?" entry point for zero-friction daily flow, a "Fast Track" for solid notes to prevent pipeline fatigue, and a "Parked Questions Index" to ensure unresolved inquiries are never lost.

The core insight driving the product: the most valuable cognitive act in learning is connecting new knowledge to what you already know. ZettleLib automates the *search* for those connections so users can focus on the *quality* of the synthesis. Cover more ground. Generate ideas faster. Learn through comparison and relation rather than isolated capture.

**Tagline direction:** *Accelerate your thinking, accelerate your learning.*

### What Makes This Special

**Methodology enforcement, not methodology suggestion.** Every existing tool in this space provides infrastructure — file storage, linking, graph visualization — with zero opinions about how it should be used. ZettleLib is the only tool that enforces the specific discipline that makes Zettelkasten work: atomic notes, canonical taxonomy, semantically-labeled links, evidence-based structure emergence, and human-governed AI decisions. The discipline is the product.

**LLM-agnostic via instruction files.** The workflow logic lives in markdown configuration files, not in application code. Users bring their own LLM — any capable CLI or local model. The instructions work regardless of the underlying model and improve automatically as models improve. Each config file co-evolves with the user's vault over time: the conventions, domain vocabulary, and workflow refinements accumulated through real use become embedded in the configuration itself.

**File-system-native, intentionally thin.** The vault is a folder of markdown files. ZettleLib reads and writes those files directly. Obsidian — or any markdown viewer — is the display layer. Git provides version control, audit history, and rollback for free. Dataview reads ZettleLib-written frontmatter to generate dynamic dashboards. The system uses what already exists rather than replicating it.

**Human governance preserved.** AI suggests; human commits. No decision is auto-applied without user review. Every AI action is logged in the vault's Decision Log. The vault remains the user's intellectual property — shaped by AI labor, directed by human judgment. Confidence scores are strictly internal; the AI uses them to prioritize suggestions but never reveals them to the user, preserving the intellectual primacy of the human practitioner.

**Why now:** The analog Zettelkasten was too labor-intensive for most practitioners. Digital Zettelkasten tools eliminated physical friction but introduced organizational friction that proved equally fatal to sustained practice. LLM CLIs — capable, free-tier-accessible, and file-system-aware — make the organizational friction removable for the first time without sacrificing the method's intellectual rigor. This is the right moment for a Zettelkasten rediscovery.

### Project Classification

| Field | Value |
|---|---|
| **Project Type** | LLM configuration layer — instruction files, not application software |
| **Domain** | Knowledge Work Infrastructure |
| **Complexity** | Low-to-medium; front-loaded on instruction quality across multiple LLM backends |
| **Project Context** | Greenfield with detailed blueprint (Librarian Engine V2 spec) |
| **Distribution** | GitHub repository; installation = copy one file into vault root |
| **Architecture** | File-system-native; intentional invocation; git-backed; Dataview as query layer; Obsidian as primary viewer via existing plugins |
