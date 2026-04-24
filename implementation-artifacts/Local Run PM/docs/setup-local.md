# Local LLM Setup Guide (Ollama / Gemma 4 / Generic)

## Prerequisites

- [Obsidian](https://obsidian.md/) installed
- [Ollama](https://ollama.ai/) installed (or another local LLM runtime)
- Git installed
- A vault with the ZettleLib folder structure (see `vault-scaffold/README.md`)

## Installation

### 1. Install Ollama

Download from [ollama.ai](https://ollama.ai/) and install for your platform.

### 2. Pull a Model

**Recommended: Gemma 4 (27B)**
```bash
ollama pull gemma-4
```

**Alternatives:**
```bash
ollama pull llama3:70b        # Strong general-purpose
ollama pull mistral-large     # Good instruction following
ollama pull gemma-4:9b        # Lighter — faster but lower quality
```

### 3. Copy Config File

Copy `AGENTS.md` into your vault root:

```
/Your Vault/
├── AGENTS.md          ← This file
├── 00 Inbox/
├── 10 Literature/
├── ...
```

### 4. Copy Prompt Library

Copy the entire `80 System/Prompt Library/` folder into your vault's `/80 System/` directory.

### 5. Copy Templates

Copy `Master Tag List.md` and `Decision Log.md` from `vault-scaffold/80 System/` into your vault's `/80 System/`.

### 6. Initialize Git

```bash
cd "/path/to/your/vault"
git init
git add -A
git commit -m "Initial ZettleLib setup"
```

## Usage

### Interactive Session

```bash
cd "/path/to/your/vault"
ollama run gemma-4 --system "$(cat AGENTS.md)"
```

Then type your commands:

```
Process this note: [paste note content]
```

### Single-Prompt Mode

```bash
ollama run gemma-4 --system "$(cat AGENTS.md)" "Process this note: $(cat '00 Inbox/my-new-note.md')"
```

### Using a Script (Optional Convenience)

Create a `zettle.sh` (or `zettle.ps1` on Windows) in your vault root:

**Linux/Mac (`zettle.sh`):**
```bash
#!/bin/bash
cd "$(dirname "$0")"
ollama run gemma-4 --system "$(cat AGENTS.md)" "$@"
```

**Windows (`zettle.ps1`):**
```powershell
$vaultDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $vaultDir
$system = Get-Content "AGENTS.md" -Raw
ollama run gemma-4 --system $system $args
```

Then: `./zettle.sh "process this note: ..."` or `./zettle.ps1 "process this note: ..."`

---

## What You Lose Going Local

| Capability | Cloud (Gemini CLI / Claude CLI) | Local (Gemma 4 27B) |
|---|---|---|
| **Context window** | ~1M tokens (full vault in one pass) | ~32k tokens (must chunk) |
| **Serendipity (Prompt E)** | Strong cross-domain pattern recognition | Noticeably weaker — fewer surprising connections |
| **Contradiction detection (Prompt G)** | Catches subtle semantic tensions | May miss nuanced contradictions |
| **Tag deduplication (Prompt B)** | Catches subtle synonyms reliably | May miss non-obvious overlaps |
| **Luhmann Audit (Prompt I)** | Analyzes whole vault in one pass | Requires chunked vault samples |
| **Outline Generator (Prompt H)** | Finds connections across hundreds of notes | Works well for <50 notes; degrades above that |
| **Privacy** | Vault content leaves your machine | Fully local — zero data exposure |
| **Cost** | Free tier exists; paid above limits | $0 always |
| **Offline** | Requires internet | Always works |
| **Triage / Atomicity / Tagging (J, A, B)** | Excellent | Very good — local handles single-note ops well |

### Recommendation

- **Starting out (vault < 50 notes):** Local works great for everything
- **Growing vault (50–200 notes):** Local for daily processing; cloud for monthly audit + serendipity
- **Large vault (200+):** Cloud for vault-wide operations; local for single-note pipeline

### Hybrid Approach

You can use both. Keep `AGENTS.md` for daily local processing and `GEMINI.md` for monthly vault-wide operations:

```bash
# Daily — local, fast, private
ollama run gemma-4 --system "$(cat AGENTS.md)" "process this note: ..."

# Monthly audit — cloud, full vault visibility
gemini -f GEMINI.md "monthly audit"
```

---

## Troubleshooting

**Model is slow:**
- Use `gemma-4:9b` for faster responses (lower quality)
- Process notes one at a time rather than batching
- Ensure you have enough RAM (27B model needs ~16GB)

**Responses are cut off:**
- Local models have smaller output limits
- Ask the model to complete its response: "Continue from where you stopped"
- For long outputs (Prompt I audit), ask for sections one at a time

**Model doesn't follow the prompt format:**
- Smaller models may not follow structured output formats precisely
- This is acceptable — the content matters more than exact formatting
- Re-prompt: "Format your previous response using the output format from the prompt file"
