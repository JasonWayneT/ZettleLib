# ZettleLib + Gemini CLI: User Guide

This guide walks you through setting up and using ZettleLib with the Gemini CLI. The goal: you capture ideas, say "process my inbox," and have a thinking conversation with the AI about each note.

---

## Part 1: One-Time Setup

### 1. Install the Gemini CLI

1. **Install Node.js** (version 18+) from [nodejs.org](https://nodejs.org/) if you don't have it.
2. **Install the CLI**:
   ```bash
   npm install -g @google/gemini-cli
   ```

### 2. Sign In

Run `gemini` in your terminal. It will ask you to sign in with your Google account. Follow the steps — this only happens once.

### 3. Set Up Your Vault

Create this folder structure inside your Obsidian vault:

```text
00 Inbox/
10 Literature/
15 Incubating/
20 Permanent/
70 Projects/
80 System/
90 Maps/
```

Then copy the ZettleLib files in:

- `GEMINI.md` → vault root
- `Prompt Library/` folder → inside `80 System/`
- `Master Tag List.md` → inside `80 System/`
- `Decision Log.md` → inside `80 System/`

That's it. You're set up.

---

## Part 2: The Daily Workflow

### Capture

Write your ideas in `00 Inbox/`. Don't worry about formatting, tags, or structure. Just write.

### Process

When you're ready to process your inbox:

1. Open your terminal
2. Navigate to your vault:
   ```bash
   cd "C:\Path\To\Your\Vault"
   ```
3. Start Gemini:
   ```bash
   gemini
   ```
4. Say:
   ```
   Process my inbox.
   ```

That's it. Gemini reads the `GEMINI.md` config automatically, picks up the notes in your inbox, and walks you through each one as a conversation:

- **Triage** — It asks you what the note is (task, source material, your own idea, or something ephemeral). You decide.
- **Atomicity** — If it's your own idea, it asks you questions about whether the note is doing one job or several. If it's already a clear, solid idea, it offers a "Fast Track" to skip the deep questions and proceed straight to filing.
- **Tagging** — It suggests tags from your existing list and asks if they fit.
- **Linking** — It finds connections to your other notes and asks if they feel real.
- **Contradiction check** — It shows you if the new note might disagree with something you wrote before.

You answer the questions, park the ones you want to think about later, and dismiss anything that doesn't feel useful. When it's done, your note is filed with tags, links, and any parked questions saved for later.

### Process a single note

If you only want to process one specific note:

```
Process this note: 00 Inbox/my-new-idea.md
```

---

## Part 3: Other Things You Can Say

You don't need to remember prompt names or run anything manually. Just tell Gemini what you want in plain English.

| What you want | What to say |
|---|---|
| Find out what needs doing | `What should I do?` or `What needs attention?` |
| Process everything in your inbox | `Process my inbox` |
| Process one note | `Process this note: 00 Inbox/[filename]` |
| Get surprised by connections | `Surprise me` or `Daily review` |
| Write about something | `I want to write about [topic]` |
| Sunday tag and orphan cleanup | `Weekly review` |
| Monthly health check | `Monthly audit` or `Vault health` |

---

## Part 4: Tips

1. **Use interactive mode.** Starting `gemini` without arguments drops you into a conversation. This is the easiest way to work — just talk to it.

2. **Use Git.** Run `git commit` before and after processing sessions. If anything goes wrong, you can roll back.

3. **Gemini has a massive context window.** It can read your entire `/20 Permanent/` folder at once, which makes the serendipity engine and outline generator work well.

4. **Your config evolves.** The `GEMINI.md` file has a "User Refinements" section at the bottom. As you use the system, add your preferences there — domain vocabulary, workflow shortcuts, threshold adjustments.
