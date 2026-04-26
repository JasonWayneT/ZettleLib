---
title: Decision Log
type: system
maintained_by: ZettleLib AI
purpose: Audit trail of every AI action on the vault — enables rollback and transparency
---

# Decision Log

Every AI decision is recorded here with enough detail to understand and reverse it.

**Format:** Each entry includes timestamp, note path, decision made, outcome, and rollback instruction.

**Rollback:** All changes can be reversed via `git revert` to the commit before the processing session. The Librarian will remind you to commit before and after each session.

---

## Log Entries

<!-- Entries are appended chronologically. Most recent at the bottom. -->
<!-- Format: -->
<!--
## YYYY-MM-DDTHH:MM:SSZ
**Note:** /path/to/note.md
**Pipeline step:** [Triage | Atomicity | Tagging | Linking | Dialectic | Hub]
**Decision:** [What was recommended]
**User action:** [Accepted | Rejected | Modified — details]
**Outcome:** [What changed in the vault]
**Rollback:** git revert to commit [hash] or manual: [specific reversal steps]
-->

*No entries yet. Decisions will be logged as you process your first notes.*
