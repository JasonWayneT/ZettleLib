---
stepsCompleted: [1]
inputDocuments: []
workflowType: 'architecture'
project_name: 'ZettleLib'
user_name: 'Jason'
date: '2026-04-22'
---

# Architecture Decision Document

## 1. Instruction-as-Infrastructure (ZettleLib 2.0)
**Decision:** Move away from a custom Python orchestration layer in favor of a pure-instruction model.
**Rationale:** Modern LLM CLIs (Claude, Gemini) and local servers (LM Studio) are already file-system aware and have massive context windows. Creating a custom middleware adds maintenance overhead and friction without significant gain. The instructions *are* the product.
**Status:** Implemented in GEMINI.md, CLAUDE.md, and AGENTS.md.

## 2. Socratic Thinking Partner vs. Oracle Manager
**Decision:** Prompts must not issue verdicts (e.g., "This is macro-atomic"). They must ask questions that guide the user to their own conclusion.
**Rationale:** Zettelkasten is a cognitive development method. If the AI makes the decisions, the user stops learning. Socratic questioning preserves human agency and intellectual rigor.
**Status:** Integrated across all Prompt Library files.

## 3. Persistent Context via Processing Summary
**Decision:** Instead of external state files, the system uses an accumulating "Processing Summary" block within the chat history.
**Rationale:** Keeps the workflow stateless on the filesystem but stateful in the LLM's context window. Reduces complexity and potential for desync between the AI and the vault.
**Status:** Mandatory rule in all core config files.

## 4. Centralized Retrieval Index (Parked Questions)
**Decision:** Maintain an append-only `Parked Questions.md` file in `/80 System/`.
**Rationale:** Solves the "needle in a haystack" problem where elaboration prompts couldn't find unresolved questions in a large vault. Turns ephemeral questions into queryable system state.
**Status:** Integrated into Prompts J, A, G, and F.

## 5. Internal-Only Confidence Scores
**Decision:** Confidence scores are used by the AI to prioritize suggestions but are never shown to the user.
**Rationale:** Prevents "score-watching" and maintains the "Thinking Partner" relationship. A high confidence score from an AI is not a substitute for human conviction.
**Status:** Active constraint in Prompt Library.
