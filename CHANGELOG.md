# Changelog — ZettleLib

All notable changes are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

---

## [Unreleased]

---

## [2.1.0] — 2026-04

### Fixed
- Beta-vault added as a regular directory instead of a git submodule — resolves clone issues for new users

---

## [2.0.0] — 2026-04

### Added
- Socratic architecture finalized — 9 prompt contracts covering the full note-processing pipeline
- Philosophy manifesto and design principles documented
- Prompt contract system: `.txt` template + `.yaml` spec pairs with three parser types (VOCAB_MATCH, PREFIX_EXTRACT, PATTERN_EXTRACT)
- Grounding system — tag suggestion constrained to `vault-taxonomy.md`, MOC references constrained to `vault-index.md`

### Changed
- Major project reorganization — prompt library, vault scaffold, and architecture reference separated cleanly
- `processed_with` frontmatter field now records which contract versions touched each note (audit trail)

---

## [0.2.0] — 2026-03

### Added
- LM Studio support — local LLM alternative to Ollama
- Runner script for easier local setup
- Vault scaffold populated with initial content

---

## [0.1.0] — 2026-03

### Added
- Initial MVP: prompt library, vault scaffold, and planning artifacts
- Three-note-type vault structure: Fleeting, Literature, Permanent
- `_System/` folder convention with Prompt Library, vault-taxonomy seed, vault-index
