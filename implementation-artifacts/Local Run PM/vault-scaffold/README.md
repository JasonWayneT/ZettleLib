# Vault Folder Structure

Create these folders in your Obsidian vault root. The numbering keeps them sorted in a logical order.

```
/Your Vault/
├── 00 Inbox/              ← Drop raw captures here. No friction. No formatting required.
├── 10 Literature/          ← Source-bound notes: book highlights, article summaries, quotes.
├── 15 Incubating/          ← Ideas under development. Not ready for permanent storage yet.
├── 20 Permanent/           ← THE CORE. Atomic, evergreen, one-claim-per-note.
├── 70 Projects/            ← Active writing projects. Outlines, drafts, linked notes.
├── 80 System/
│   ├── Master Tag List.md  ← Copy from vault-scaffold/80 System/
│   ├── Decision Log.md     ← Copy from vault-scaffold/80 System/
│   ├── Prompt Library/     ← Copy all files from 80 System/Prompt Library/
│   └── Archive/            ← Monthly audit reports, retired hubs, tag snapshots
└── 90 Maps/
    ├── Indexes/            ← Thin entry points ("Start here: [[A]], [[B]]")
    └── Hubs/               ← Thick synthesis notes (emerge from evidence, not aspiration)
```

## Folder Purposes

| Folder | What Goes Here | What Doesn't |
|---|---|---|
| **00 Inbox** | Anything captured quickly — thoughts, quotes, screenshots | Nothing stays here long; it's a processing queue |
| **10 Literature** | Notes bound to a source (book, article, podcast) | Your own original thinking (that goes to 20 Permanent) |
| **15 Incubating** | Ideas that are promising but incomplete | Finished atomic claims (those go to 20 Permanent) |
| **20 Permanent** | One testable claim per note, with enduring value | Multi-topic notes, tasks, source-dependent content |
| **70 Projects** | Outlines, drafts, and published outputs | Notes that belong in the permanent collection |
| **80 System** | AI config, prompts, logs, archives | Your actual notes |
| **90 Maps** | Index pages and hub synthesis notes | Individual permanent notes |

## Setup Checklist

1. [ ] Create all folders above in your Obsidian vault
2. [ ] Copy `Master Tag List.md` into `/80 System/`
3. [ ] Copy `Decision Log.md` into `/80 System/`
4. [ ] Copy all prompt files into `/80 System/Prompt Library/`
5. [ ] Copy your chosen config file (`GEMINI.md`, `CLAUDE.md`, or `AGENTS.md`) into vault root
6. [ ] Initialize git in your vault: `git init && git add -A && git commit -m "Initial vault setup"`
7. [ ] Open Obsidian, verify folder structure appears
8. [ ] Install recommended Obsidian plugins: Dataview, Templater
