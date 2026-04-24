# ZettleLib + Gemini CLI: The Complete Step-by-Step User Guide

This guide provides an in-depth, step-by-step walkthrough for setting up and using ZettleLib with the official Google Gemini CLI. 

By combining ZettleLib's prompt architecture with the Gemini CLI, you transform a standard Obsidian vault into an AI-enforced Zettelkasten that handles all the organizational labor for you.

---

## Part 1: Initial Setup

### 1. Install Node.js and the Gemini CLI
The Gemini CLI is a Node.js application, so you'll need Node installed on your machine.

1. **Install Node.js**: If you don't have it, download and install Node.js (version 18 or higher) from [nodejs.org](https://nodejs.org/).
2. **Install the CLI**: Open your terminal or command prompt and run:
   ```bash
   npm install -g @google/gemini-cli
   ```
   *Note: This installs the CLI globally, allowing you to run the `gemini` command from anywhere.*

### 2. Authenticate the CLI
Before using the CLI, you need to connect it to your Google account.

1. In your terminal, run:
   ```bash
   gemini
   ```
2. The CLI will prompt you to authenticate. Follow the on-screen instructions to open a browser window and sign in with your Google account.
3. *Alternative (API Key)*: If you prefer to use an API key from Google AI Studio, you can set it as an environment variable:
   - **Windows**: `$env:GEMINI_API_KEY="YOUR_API_KEY"`
   - **Mac/Linux**: `export GEMINI_API_KEY="YOUR_API_KEY"`

### 3. Scaffold Your Vault
ZettleLib relies on a specific folder structure to function correctly.

1. Open your Obsidian vault in your file explorer.
2. Create the following exact folder structure at the root of your vault:
   ```text
   00 Inbox/
   10 Literature/
   15 Incubating/
   20 Permanent/
   70 Projects/
   80 System/
   90 Maps/
   ```

### 4. Install the ZettleLib Files
Move the necessary ZettleLib configuration files into your vault.

1. Copy the `GEMINI.md` file into the **root directory** of your vault.
2. Copy the entire `Prompt Library` folder into your `80 System/` folder.
3. Copy `Master Tag List.md` and `Decision Log.md` into your `80 System/` folder.

Your final structure should look like this:
```text
Your Vault/
├── GEMINI.md
├── 00 Inbox/
├── ...
└── 80 System/
    ├── Master Tag List.md
    ├── Decision Log.md
    └── Prompt Library/
        ├── prompt-J-triage.md
        ├── prompt-A-atomicity.md
        └── ... (all 12 prompts)
```

---

## Part 2: Daily Workflow & Processing

The core of ZettleLib is processing notes from your inbox into your permanent system.

### The Pipeline
Every note goes through a specific sequence:
**Capture → Triage (J) → Atomicity (A) → Tagging (B) → Linking (C) → Dialectic (G) → Hub Tracking (D)**

### Step-by-Step Processing

1. **Capture an Idea**
   Create a new file in `00 Inbox/`. Write your thought quickly. Don't worry about formatting, tags, or links.

2. **Start the Gemini CLI**
   Open your terminal and navigate to your vault's root directory:
   ```bash
   cd "C:\Path\To\Your\Vault"
   ```

3. **Run the Triage Prompt (Prompt J)**
   Instruct Gemini to use the `GEMINI.md` configuration file and process your note. The CLI can read files directly if you provide the path.
   ```bash
   gemini -f GEMINI.md "Run Prompt J on this note: 00 Inbox/my-new-idea.md"
   ```
   *Gemini will respond with a classification: DELETE, TASK, SOURCE, or CLAIM.*
   - If **CLAIM**: Proceed to the next step.
   - If anything else: Follow the instructions (e.g., move to `/10 Literature/` or delete) and stop processing.

4. **Run the Atomicity Checker (Prompt A)**
   ```bash
   gemini -f GEMINI.md "Run Prompt A on this note: 00 Inbox/my-new-idea.md"
   ```
   *Gemini will tell you if the note contains a single, enduring idea. It may suggest splitting the note if it covers too much ground.*

5. **Run the Tagging Prompt (Prompt B)**
   ```bash
   gemini -f GEMINI.md "Run Prompt B on this note: 00 Inbox/my-new-idea.md"
   ```
   *Gemini will analyze the `Master Tag List.md` and suggest 1-3 tags, plus generate the YAML frontmatter.*
   - **Your Job**: Copy the generated YAML frontmatter and paste it at the top of your note.

6. **Run the Linking Prompt (Prompt C)**
   ```bash
   gemini -f GEMINI.md "Run Prompt C on this note: 00 Inbox/my-new-idea.md"
   ```
   *Gemini will search your vault for relevant connections and suggest links with specific relationship verbs (e.g., "extends", "contradicts").*
   - **Your Job**: Add the approved links to the `links:` section in your note's YAML frontmatter.

7. **Finalize and Move**
   - Once all steps are complete, move the note from `00 Inbox/` to `20 Permanent/`.
   - Open `80 System/Decision Log.md` and add a quick note about what was processed (or ask Gemini to write the log entry for you).

---

## Part 3: Routine Maintenance

To keep the Zettelkasten healthy, you run specific prompts on a schedule.

### Daily: The Serendipity Engine
Find non-obvious connections between your notes.
```bash
gemini -f GEMINI.md "Run Prompt E (Serendipity Engine) across my permanent notes."
```
*Gemini will pull 3 non-obvious cross-domain connections. Review them and add links to your notes if you agree with the synthesis.*

### Weekly: Governance (Sundays)
Clean up your tags and fix orphans.
```bash
gemini -f GEMINI.md "Run the Weekly Governance prompt."
```
*Gemini will review your Master Tag List, suggest merges for synonyms, and flag any permanent notes that have zero links.*

### Monthly: The Luhmann Audit (1st Sunday)
Get a comprehensive health score of your vault.
```bash
gemini -f GEMINI.md "Run Prompt I (Luhmann Audit). Read all notes in /20 Permanent/ and calculate the 6 metrics."
```
*Gemini will score your vault on Atomicity, Connectivity, Emergence, Surprise, Output, and Overall Health.*

---

## Part 4: Writing & Output

When you are ready to turn your notes into an article, essay, or project:

1. **Generate an Outline (Prompt H)**
   Tell Gemini your topic and ask it to build an outline using only your permanent notes.
   ```bash
   gemini -f GEMINI.md "Run Prompt H. I want to write an essay about [Your Topic]. Build an outline using my permanent notes."
   ```

2. **Review the Gap Analysis**
   Gemini will provide an outline and identify "Gaps"—concepts you need for the essay that don't exist in your vault yet.

3. **Start the Project**
   Create a new folder in `70 Projects/`, save the outline there, and begin drafting!

---

## Tips & Best Practices for the Gemini CLI

1. **Context Window Advantage**: The Gemini CLI has a massive context window. For tasks like the Monthly Audit or Outline Generation, it can easily read your entire `/20 Permanent/` folder at once.
2. **Interactive Mode**: Instead of passing commands directly via arguments, you can start an interactive session:
   ```bash
   gemini -f GEMINI.md
   ```
   Then type your commands back and forth, which is faster for processing a single note through the A -> B -> C pipeline.
3. **Always use Git**: Because Gemini is analyzing and suggesting changes, always run `git commit` before and after processing sessions. If you make a mess, you can easily roll back.
