# ZettleLib

An LLM configuration layer that turns any capable LLM CLI into a thinking partner for your Zettelkasten vault. Drop one file in your vault, say "process my inbox," and have a conversation about your ideas.

## Project Structure

```
ZettleManagement/
├── release/          ← What users get (config files, prompts, guides)
├── beta-vault/       ← Live test vault with Obsidian
└── dev/              ← Design specs, PRD, research (not shipped)
```

## Quickstart

1. Pick your LLM: Gemini CLI, Claude CLI, or LM Studio
2. Copy the matching config file (`GEMINI.md`, `CLAUDE.md`, or `AGENTS.md`) from `release/` into your vault root
3. Copy `release/80 System/` into your vault
4. Say "What should I do?" or "process my inbox"

See `release/gemini-cli-user-guide.md` or `release/lm-studio-user-guide.md` for detailed setup.
