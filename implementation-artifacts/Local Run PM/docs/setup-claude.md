# Claude CLI Setup Guide

## Prerequisites

- [Obsidian](https://obsidian.md/) installed
- [Claude CLI](https://docs.anthropic.com/en/docs/claude-cli) installed
- Git installed
- A vault with the ZettleLib folder structure (see `vault-scaffold/README.md`)

## Installation

### 1. Install Claude CLI

```bash
npm install -g @anthropic-ai/claude-code
```

Or follow the latest instructions at [Anthropic's documentation](https://docs.anthropic.com/en/docs/claude-cli).

### 2. Copy Config File

Copy `CLAUDE.md` into your vault root:

```
/Your Vault/
├── CLAUDE.md          ← This file
├── 00 Inbox/
├── 10 Literature/
├── ...
```

Claude CLI automatically reads `CLAUDE.md` from the current directory as its system instructions.

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
cd "/path/to/your/vault"
claude
```

Claude CLI automatically picks up `CLAUDE.md`. Then type:

```
Process this note: [paste note content or reference file path]
```

Claude can read files directly from your vault using its file access tools.

### Daily Review

```
daily review
```

### Weekly Governance

```
weekly review
```

### Monthly Audit

```
monthly audit
```

### Generate Writing Outline

```
outline: Applying Judo Principles to Product Strategy
```

## Tips

- **Always commit to git** before and after processing sessions
- Claude CLI reads `CLAUDE.md` automatically — no need to specify it each time
- Claude's extended thinking is particularly strong for dialectic checks and serendipity connections
- For vault-wide operations, Claude's large context window handles most vaults without chunking
- The `CLAUDE.md` config file co-evolves — add your refinements to the "User Refinements" section
