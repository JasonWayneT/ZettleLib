# ZettleLib

**The AI Enforcement Layer for Serious Zettelkasten Practice**

---

ZettleLib turns any capable LLM CLI into a disciplined Zettelkasten maintainer. Drop one file into your Obsidian vault root. No installer. No subscription. No data leaves your machine unless you choose it.

## What This Is

Three LLM configuration files — `GEMINI.md`, `CLAUDE.md`, and `AGENTS.md` — that encode the complete Zettelkasten workflow as LLM-readable operating instructions. The AI handles organizational labor. You handle intellectual decisions.

**What happens when you process a note:**

```
Capture → Triage → Atomicity Check → Semantic Tagging → Link Discovery → Dialectic Check → Hub Tracking → Done
```

Each step runs a purpose-built prompt. Each step surfaces decisions for your approval. Nothing is auto-applied.

## What It Does

| Feature | What the AI Does | What You Do |
|---|---|---|
| **Triage** | Classifies inbox notes as DELETE / TASK / SOURCE / CLAIM | Approve the classification |
| **Atomicity** | Verifies one idea per note; proposes splits when needed | Accept, reject, or modify splits |
| **Tagging** | Tags from a canonical taxonomy; detects synonym drift | Approve tags; grow the taxonomy over time |
| **Linking** | Finds connections with semantic relation verbs | Choose which connections matter |
| **Dialectic** | Detects contradictions; builds synthesis scaffolds | Write the actual synthesis |
| **Serendipity** | Surfaces non-obvious cross-domain connections daily | Explore or dismiss each surprise |
| **Elaboration** | Identifies stagnant notes; suggests branching directions | Decide which ideas to deepen |
| **Outline** | Builds writing outlines from your permanent notes | Write the actual output |
| **Audit** | Monthly vault health report with six scored metrics | Act on the recommendations |
| **Hub Tracking** | Suggests Maps of Content when evidence thresholds are met | Approve structure when it's earned |

## Quick Start

### 1. Set Up Your Vault

Create these folders in your Obsidian vault:

```
00 Inbox/
10 Literature/
15 Incubating/
20 Permanent/
70 Projects/
80 System/
90 Maps/
```

### 2. Copy the Files

```
Your Vault/
├── GEMINI.md (or CLAUDE.md or AGENTS.md)  ← Config file in vault root
└── 80 System/
    ├── Master Tag List.md                  ← From vault-scaffold/
    ├── Decision Log.md                     ← From vault-scaffold/
    └── Prompt Library/                     ← All 12 prompt files
        ├── prompt-J-triage.md
        ├── prompt-A-atomicity.md
        ├── prompt-B-tagging.md
        ├── prompt-C-linking.md
        ├── prompt-D-hub.md
        ├── prompt-E-serendipity.md
        ├── prompt-F-elaboration.md
        ├── prompt-G-dialectic.md
        ├── prompt-H-outline.md
        ├── prompt-I-audit.md
        ├── prompt-weekly-governance.md
        └── prompt-hub-pruning.md
```

### 3. Initialize Git

```bash
cd "/path/to/your/vault"
git init && git add -A && git commit -m "Initial ZettleLib setup"
```

### 4. Start Processing

**Gemini CLI:**
```bash
gemini -f GEMINI.md "process this note: [paste note]"
```

**Claude CLI:**
```bash
cd /path/to/vault && claude
> process this note: [paste note]
```

**Ollama (Gemma 4 local):**
```bash
ollama run gemma-4 --system "$(cat AGENTS.md)" "process this note: [paste note]"
```

## Choose Your LLM

| Config File | Target | Best For |
|---|---|---|
| `GEMINI.md` | Gemini CLI | Large vaults; vault-wide operations; free tier available |
| `CLAUDE.md` | Claude CLI | Strong reasoning; extended thinking for dialectic checks |
| `AGENTS.md` | Ollama / local LLMs | Privacy-first; offline; $0 always; best for <50 notes |

All three encode the same workflow. See `docs/setup-*.md` for per-LLM setup instructions.

## Cadence

| When | What | Time |
|---|---|---|
| **Any time** | Process inbox notes through the pipeline | 90 sec – 3 min per note |
| **Daily** | Serendipity connections + elaboration suggestions | 5–10 min |
| **Weekly** (Sunday) | Tag governance, orphan detection, metrics | <30 min |
| **Monthly** (1st Sunday) | Luhmann health audit + hub pruning | 30–45 min |

## Philosophy

- **AI = labor, Human = governance.** The AI triages, tags, links, and detects contradictions. You approve, reject, synthesize, and decide what matters.
- **The prompts are the product.** ZettleLib's value lives in its versioned prompt library — not in infrastructure. The prompts get better as models improve.
- **A layer, not a replacement.** Obsidian is the editor. Git is version control. Dataview is the dashboard. ZettleLib adds discipline to what already exists.
- **Links are reasoning traces.** Every connection carries a semantic verb and a rationale. Your link graph becomes searchable intellectual history.

## Documentation

- [Workflow Guide](docs/workflow-guide.md) — The complete 8-phase pipeline explained
- [Note Metadata Schema](docs/note-metadata-schema.md) — Frontmatter field reference
- [Gemini CLI Setup](docs/setup-gemini.md)
- [Claude CLI Setup](docs/setup-claude.md)
- [Local LLM Setup](docs/setup-local.md) — Includes cloud-vs-local comparison table
- [Vault Structure](vault-scaffold/README.md) — Folder explanations and setup checklist

## Project Status

**Phase 1 (current):** Config files + prompt library. Dogfooding on a real vault.

**Phase 2 (planned):** Python orchestration layer with file watching, SQLite embeddings, and automation thresholds.

**Phase 3 (planned):** Community config variants, Marp presentation generation, broader ecosystem integrations.

---

*ZettleLib — Accelerate your thinking, accelerate your learning.*
