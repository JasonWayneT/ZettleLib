# Gemini CLI Setup Guide

## Prerequisites

- [Obsidian](https://obsidian.md/) installed
- [Gemini CLI](https://github.com/google-gemini/gemini-cli) installed
- Git installed
- A vault with the ZettleLib folder structure (see `vault-scaffold/README.md`)

## Installation

### 1. Install Gemini CLI

```bash
npm install -g @anthropic-ai/gemini-cli
```

Or follow the latest instructions at the [Gemini CLI repository](https://github.com/google-gemini/gemini-cli).

### 2. Copy Config File

Copy `GEMINI.md` into your vault root:

```
/Your Vault/
├── GEMINI.md          ← This file
├── 00 Inbox/
├── 10 Literature/
├── ...
```

### 3. Copy Prompt Library

Copy the entire `80 System/Prompt Library/` folder into your vault's `/80 System/` directory.

### 4. Copy Templates

Copy `Master Tag List.md` and `Decision Log.md` from `vault-scaffold/80 System/` into your vault's `/80 System/`.

### 5. Initialize Git

```bash
cd "/path/to/your/vault"
git init
git add -A
git commit -m "Initial ZettleLib setup"
```

## Usage

### Process a Note

Navigate to your vault directory and run:

```bash
gemini -f GEMINI.md "Process this note: [paste note content or path]"
```

Or interactively:

```bash
cd "/path/to/your/vault"
gemini -f GEMINI.md
```

Then type: `process this note` and paste/reference the note.

### Daily Review

```bash
gemini -f GEMINI.md "daily review"
```

### Weekly Governance

```bash
gemini -f GEMINI.md "weekly review"
```

### Monthly Audit

```bash
gemini -f GEMINI.md "monthly audit"
```

### Generate Writing Outline

```bash
gemini -f GEMINI.md "outline: Applying Judo Principles to Product Strategy"
```

## Tips

- **Always commit to git** before and after processing sessions
- Gemini CLI can read files directly from your vault — reference note paths in your prompts
- For vault-wide operations (serendipity, audit), Gemini's large context window handles the full vault well
- The `GEMINI.md` config file co-evolves — add your refinements to the "User Refinements" section at the bottom

## Using Gemma 4 Locally Instead

If you prefer fully local operation with Gemma 4 via Ollama:

1. Install [Ollama](https://ollama.ai/)
2. Pull Gemma 4: `ollama pull gemma-4`
3. Use `AGENTS.md` instead of `GEMINI.md`
4. See `docs/setup-local.md` for detailed local model guidance

**What you lose going local:** See the comparison table in `docs/setup-local.md`.
