# Note Metadata Schema

Every permanent note in a ZettleLib vault uses this YAML frontmatter schema. The Librarian AI writes and maintains these fields during processing. You can also edit them manually.

---

## Full Schema

```yaml
---
# IDENTITY
title: "Note Title"                    # Human-readable title
id: permanent-note-XXX                 # Unique ID for stable addressing
created: 2026-01-15T09:23:00Z          # ISO timestamp — when first written
modified: 2026-03-20T14:12:00Z         # ISO timestamp — last meaningful edit

# TAXONOMY
tags: [tag-1, tag-2]                   # From Master Tag List (max 3, prefer 2)
proposed_new_tags:                      # AI suggestions pending your approval
  - tag: "proposed-tag"
    confidence: 0.XX
    status: pending_review

# MATURITY & QUALITY
status: seedling                       # seedling | budding | evergreen | archived
confidence: 0.8                        # How validated is this claim? (0.0–1.0)
generation: 0                          # Refinement depth (0 = initial, 1+ = revised)
health_score: 0.0                      # Composite: links + revisions + visits
review_cycle: 90d                      # When to resurface for review

# GENEALOGY
parent: null                           # [[Note this evolved from]] or null
children: []                           # [[Notes that branched from this]]
evolution_type: null                    # refinement | challenge | application | synthesis

# PROVENANCE
source_type: original                  # book | article | conversation | original
derived_from: null                     # [[Literature Note]] if from a source
claim_strength: null                   # empirical | theoretical | speculative
written_during: null                   # Context: morning-pages, post-meeting, etc.
sparked_by: null                       # What triggered this thought?

# CONNECTIVITY
links:                                 # Semantic connections with relation verbs
  - target: "[[Target Note]]"
    relation: extends                  # Verb from controlled vocabulary
    rationale: "One sentence why"      # WHY this connection matters
    confidence: 0.XX
outbound_links: 0                      # Count — for health metrics
inbound_links: 0                       # Count — for health metrics
moc_placements: []                     # Which hubs reference this note

# USAGE ANALYTICS
user_visits: 0                         # How often you've opened this note
last_visited: null                     # Date of last open
citations_in_output: 0                 # Times cited in /70 Projects/ outputs
traversal_count: 0                     # Manual links created within tag cluster
last_queried: null                     # Last search/query that surfaced this note

# FUTURE SELF
questions: []                          # Questions to revisit later
  # - question: "Does this apply to X?"
  #   triggered_by: "after_event"
  #   due: 2026-06-01
reminders: []                          # Time-triggered actions
  # - event: "Q3 Review"
  #   action: "Cite in post-mortem"
  #   date: 2026-07-01
---
```

---

## Field Reference

### Identity Fields

| Field | Required | Description |
|---|---|---|
| `title` | Yes | Human-readable note title |
| `id` | Yes | Unique identifier — `permanent-note-XXX` format |
| `created` | Yes | ISO timestamp of first creation |
| `modified` | Yes | ISO timestamp of last meaningful content change |

### Taxonomy Fields

| Field | Required | Description |
|---|---|---|
| `tags` | Yes | 1–3 tags from the Master Tag List |
| `proposed_new_tags` | No | AI-proposed tags awaiting approval |

### Maturity Fields

| Field | Required | Description |
|---|---|---|
| `status` | Yes | `seedling` → `budding` → `evergreen` → `archived` |
| `confidence` | No | How validated is this claim (0.0–1.0) |
| `generation` | No | How many times this note has been revised (0+) |
| `health_score` | No | Composite metric calculated during audits |
| `review_cycle` | No | How often to resurface for review (e.g., `90d`) |

**Status lifecycle:**
- `seedling` — Just created, minimally connected
- `budding` — Connected to 2+ notes, showing early integration
- `evergreen` — Well-connected, cited in outputs, stable claim
- `archived` — Superseded, merged, or no longer relevant

### Genealogy Fields

| Field | Required | Description |
|---|---|---|
| `parent` | No | The note this evolved from (wikilink) |
| `children` | No | Notes that branched from this (wikilinks array) |
| `evolution_type` | No | How this relates to parent: refinement, challenge, application, synthesis |

### Provenance Fields

| Field | Required | Description |
|---|---|---|
| `source_type` | Yes | `original`, `book`, `article`, `conversation` |
| `derived_from` | No | If from literature: link to the source note |
| `claim_strength` | No | `empirical`, `theoretical`, `speculative` |

### Connectivity Fields

| Field | Required | Description |
|---|---|---|
| `links` | Yes | Array of semantic connections with relation verbs |
| `links[].target` | Yes | Wikilink to connected note |
| `links[].relation` | Yes | Verb: extends, contradicts, applies, exemplifies, refines, supports, analogizes, inverts, parallels |
| `links[].rationale` | Yes | One sentence explaining WHY this connection matters |
| `links[].confidence` | Yes | How confident (0.0–1.0) |

### Usage Analytics Fields

| Field | Required | Description |
|---|---|---|
| `user_visits` | No | Incremented each time you open the note |
| `citations_in_output` | No | Count of citations in `/70 Projects/` |
| `traversal_count` | No | Manual links created within the note's tag cluster — used for hub threshold calculation |

### Future Self Fields

| Field | Required | Description |
|---|---|---|
| `questions` | No | Questions to revisit later, with optional triggers and due dates |
| `reminders` | No | Time-triggered actions tied to events |

---

## Minimal Viable Frontmatter

For quick captures that you'll flesh out during processing, this is the minimum:

```yaml
---
title: "My Note Title"
id: permanent-note-001
created: 2026-04-22T10:00:00Z
modified: 2026-04-22T10:00:00Z
tags: []
status: seedling
source_type: original
links: []
---
```

The Librarian AI will fill in the remaining fields during the processing pipeline.
