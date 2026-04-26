---
title: "Product Brief: ZettleLib (Working Title)"
status: "draft"
created: "2026-04-22"
updated: "2026-04-22"
inputs: ["ZettleManagement/librarian-engine-v2-specification.md", "ZettleManagement/zettelkasten-low-friction-best-practices-2026.pdf"]
---

# Product Brief: ZettleLib
### *The AI Enforcement Layer for Serious Zettelkasten Practice*

---

## Executive Summary

Most people who try Zettelkasten quit before they realize its value. Not because the method is wrong — Luhmann built 90,000 notes and produced decades of original scholarship with it. They quit because the discipline it demands is constant, invisible, and relentless. Modern tools like Obsidian give you a beautiful canvas and zero guidance. The result: thousands of notes, no real connections, and a slow creeping sense that you're just hoarding.

ZettleLib is a **Socratic thinking partner** that sits on top of Obsidian and guides you toward genuine Zettelkasten discipline. Instead of managing your vault for you, it asks the questions you would ask yourself if you had infinite time and discipline. It helps you triage incoming notes, discover atomicity, prevent tag drift, surface non-obvious connections, and flag contradictions. The AI does the cognitive labor of retrieval and questioning; you make the intellectual decisions. The result is a knowledge system that actually compounds over time — one that teaches you the method while removing the maintenance burden.

ZettleLib is **LLM-agnostic and free to start.** It ships as three LLM-specific configuration files — `CLAUDE.md` for Claude CLI, `GEMINI.md` for Gemini CLI, and `AGENTS.md` for local or generic LLMs. Drop the right file into your vault root, point your LLM at it, and it becomes a disciplined Zettelkasten maintainer. No installer. No subscription. No data leaving your machine unless you choose it.

---

## The Problem

Zettelkasten practitioners face a paradox: the method's value scales with the number of well-connected, atomic notes — but the manual overhead required to maintain those connections scales faster than most people can keep up with.

Filing takes time. Tags drift — "product," "product-mgmt," and "product-management" accumulate in the same vault until the taxonomy is noise. Notes go unlinked. Connections that could spark new ideas are never discovered. Most people either quit after 50 notes, or they accumulate thousands of unprocessed highlights that are effectively inaccessible.

Both failure modes share the same root cause: **the cognitive overhead of organizing knowledge competes directly with the act of creating it.**

Today's workarounds are insufficient:
- **YouTube tutorials and Reddit threads** explain the method but leave the discipline entirely to the user
- **Obsidian plugins** (Dataview, Smart Connections) improve retrieval but don't enforce workflow
- **Cloud AI tools** (Mem, Reflect) sacrifice privacy and local-first principles, and none enforce ZK methodology
- **Manual practice** works for the rare practitioner willing to spend 5–10 minutes per note on maintenance overhead

None of these solve the discipline problem. ZettleLib does.

---

## The Solution

ZettleLib is an LLM configuration layer that runs within your vault and implements an intelligent, human-governed Socratic processing pipeline.

**Core workflow — when you ask "What should I do?", ZettleLib guides you:**

1. **Triage** — Guides you to classify captures as Delete, Task, Source Note, or Claim. Stops collector's fallacy early.
2. **Atomicity Check** — Asks questions to verify if each permanent note carries exactly one claim. Offers a **Fast Track** for solid notes to prevent process fatigue.
3. **Semantic Tagging** — Suggests tags from your canonical taxonomy, identifying synonyms and drift.
4. **Link Discovery** — Surfaces connections using semantic relation verbs (*extends, contradicts, analogizes*) with required one-sentence rationales.
5. **Dialectic Detection** — Asks questions about contradictions between new and existing notes.
6. **Parked Questions Index** — Maintains a central `Parked Questions.md` index to ensure unresolved inquiries are surfaced during elaboration reviews.
7. **Serendipity Engine** — Daily surfacing of non-obvious cross-domain connections.
8. **Adversarial Health Audit** — Monthly health reports using an **Adversarial Pass** to find concrete vault weaknesses.

**The output layer — when you're ready to write:**
ZettleLib's Outline Generator lets you say "I want to write about X" and returns a structured outline built from your permanent notes — with connection paths mapped, gaps identified, and estimated depth for each section. The vault becomes a writing engine, not just a storage system.

**The governing principle:** AI suggests, human commits. Every significant decision surfaces for approval. Nothing is auto-committed without your review. The system maintains a full decision log and rollback capability — so AI actions are always transparent and reversible.

---

## What Makes This Different

**Methodology enforcement, not methodology suggestion.** Obsidian, Logseq, and Roam are opinionless canvases. ZettleLib is deliberately opinionated — it enforces the specific discipline that makes Zettelkasten work at scale.

**LLM-agnostic and free to start.** Use whatever AI you already have access to — a local Ollama model, the free tier of Gemini CLI, Claude CLI, or any API-accessible LLM. No new subscription. No data leaving your machine if you choose local. This is both a practical decision and a statement of values: serious knowledge workers shouldn't have to pay a recurring fee just to think clearly.

**The prompts are the product.** ZettleLib's value lives in its versioned, domain-tested prompt library — not in proprietary infrastructure. The prompts enforce ZK discipline regardless of which LLM is running underneath. That means the system gets better as models improve, and users can swap models without losing their workflow.

**A layer, not a replacement.** ZettleLib doesn't compete with Obsidian — it augments it. No new editor to learn. No migration. Your existing vault, now with an AI that enforces the discipline you've been trying to maintain manually.

**Links as reasoning traces.** Every connection carries a semantic verb and a one-sentence rationale. Links become searchable reasoning traces — not graph clutter. This is the difference between a knowledge graph that looks impressive and one that actually produces insight.

**It teaches while it manages.** New users learn correct Zettelkasten habits through the system's guided prompts and constraints. The system is a mentor, not just a manager.

---

## Who This Serves

**Primary: The serious Zettelkasten practitioner.**
Knowledge workers and students who understand the method, have an Obsidian vault, and are frustrated that no tool enforces the discipline. They've read Ahrens. They know what they're supposed to do. They can't maintain it consistently at scale. They're technically comfortable — able to install Python and point it at an LLM. They're active in communities like r/Zettelkasten, r/ObsidianMD, and zettelkasten.de.

**Secondary: The aspiring practitioner who's tried and failed.**
Someone who has attempted Zettelkasten but couldn't make it stick. ZettleLib acts as a guided teacher — the system's constraints and feedback train correct habits while handling the maintenance overhead that caused the original abandonment.

---

## Success Criteria

**MVP — 90-day personal dogfood:**
- Notes captured and processed without losing the essence of the original insight
- Atomic note quality measurably improving (tracked via monthly audit scores)
- Less than 5 minutes of after-the-fact maintenance per week
- Cross-domain connections surfacing that would not have been found manually
- At least one piece of written output generated directly from vault connections using the Outline Generator

**Community release — GitHub + Reddit:**
- Early adopters successfully running the system on their own vaults using the LLM of their choice
- Positive reception from r/Zettelkasten and r/ObsidianMD communities
- Prompt iteration feedback from real-world vault diversity
- Evidence the system teaches the method, not just manages the vault

---

## Roadmap

**Phase 1 — Config Validation (MVP, 90 days)**
Three LLM config files (CLAUDE.md, GEMINI.md, AGENTS.md) dogfooded on a real vault. If the instructions fail here, everything fails. No orchestration layer — the LLM reads the config and operates directly on the vault's markdown files. Git provides rollback. Dataview reads frontmatter for dashboards. Processing is intentional: user invokes the LLM on demand.
*In scope: Core workflow instructions (triage, atomicity, tagging, linking, serendipity, outline generation, monthly audit). Decision Log as vault markdown file. Git as version control.*

**Phase 2 — Community Release (GitHub + Reddit)**
Validated configs published with documentation. Setup guides per LLM (Claude CLI, Gemini CLI, Ollama). Optional file watcher for users who want auto-processing (opt-in, never default). Image download workflow for LLM-readable local assets. Feedback loop with early adopters.
*In scope: Polished README, per-LLM setup guides, optional watcher, image handling docs.*

**Phase 3 — Ecosystem Expansion**
Community-contributed config variants (domain-tuned versions for academic research, product management, creative writing). Marp presentation generation from vault content. Broader Obsidian ecosystem integrations. Potential hosted option for non-technical users.
*In scope: Community config library, Marp output, wider distribution.*

**Deliberately deferred:**
- New text editor or note-taking interface
- Full GraphRAG (until corpus maturity proves it's needed)
- Multi-vault or team/collaborative support
- Cloud sync

---

## Vision

ZettleLib becomes the standard enforcement layer for serious Zettelkasten practice — the tool that finally makes the method sustainable at scale for the people who care most about it. The prompts are open, the system is local-first, and the discipline is Luhmann's. Because the method, not the editor, is what endures.

---

*Version 1.1 — updated 2026-04-22 | Approved for PRD*
