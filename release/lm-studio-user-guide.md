# ZettleLib + LM Studio: Local Setup Guide

Run the entire ZettleLib pipeline locally and privately using LM Studio. No cloud, no API costs, no data leaving your machine.

---

## Part 1: One-Time Setup

### 1. Download a Model in LM Studio

Open LM Studio and go to the **Search** tab. Look for models in GGUF format.

**Recommended models:**
1. **Gemma 4 (27B)** — Best reasoning. Search `gemma-4-27b-it-GGUF`. Use `Q4_K_M` or `Q5_K_M` depending on your RAM.
2. **Llama 3 (8B) Instruct** — Fast and lightweight. Search `Meta-Llama-3-8B-Instruct-GGUF`. Use `Q4_K_M` if you have less than 16GB RAM.
3. **Mistral Nemo (12B) Instruct** — Good middle ground.

Download your model and load it in the chat interface to make sure it fits in memory.

### 2. Start the Local Server

1. Click the **Local Server** icon (`<->` on the left sidebar)
2. Select your model from the dropdown
3. Make sure the port is `1234` (default)
4. Click **Start Server**

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

- `AGENTS.md` → vault root
- `Prompt Library/` folder → inside `80 System/`
- `Master Tag List.md` → inside `80 System/`
- `Decision Log.md` → inside `80 System/`

---

## Part 2: The Daily Workflow

### Method A: Chat Interface (Easiest)

1. Go to the **Chat** tab in LM Studio
2. In the right-hand **System Prompt** sidebar, paste the contents of `AGENTS.md`
3. Type: **"Process this note:"** then paste your note content
4. Answer the AI's questions as they come up — it will walk you through triage, atomicity, tagging, linking, and contradiction checking. If the note is already a clear, solid idea, the AI will offer a "Fast Track" to skip deep questioning and move straight to filing.
5. Apply the approved changes to your note in Obsidian

### Method B: Script via Local Server (Faster for Multiple Notes)

Use the PowerShell script to process notes without copy-pasting:

1. Save this as `process-note.ps1` in your vault root:

```powershell
param (
    [Parameter(Mandatory=$true)]
    [string]$NoteFile
)

$systemPrompt = Get-Content "AGENTS.md" -Raw
$noteContent = Get-Content $NoteFile -Raw
$userMessage = "Process this note:`n`n$noteContent"

$body = @{
    messages = @(
        @{ role = "system"; content = $systemPrompt },
        @{ role = "user"; content = $userMessage }
    )
    temperature = 0.3
} | ConvertTo-Json -Depth 4

$response = Invoke-RestMethod -Uri "http://localhost:1234/v1/chat/completions" `
                              -Method Post `
                              -Headers @{ "Content-Type" = "application/json" } `
                              -Body $body

Write-Output $response.choices[0].message.content
```

2. Run it:
```powershell
.\process-note.ps1 -NoteFile "00 Inbox\my-new-idea.md"
```

---

## Part 3: Other Things You Can Say

Just like the CLI, you can ask your local model to perform specific tasks:

| What you want | What to say |
|---|---|
| Find out what needs doing | `What should I do?` or `What needs attention?` |
| Process one note | `Process this note: [Paste content]` |
| Get surprised by connections | `Surprise me` or `Daily review` |
| Write about something | `I want to write about [topic]` |
| Sunday tag and orphan cleanup | `Weekly review` |
| Monthly health check | `Monthly audit` or `Vault health` |

---

## Part 4: Tips

1. **Keep Temperature low** (0.2–0.3) for consistent output.
2. **Set Context Length** to at least `8192` in Local Server settings. Use `16384` if your hardware allows it.
3. **Max out GPU Offload** in settings for speed.
4. **Single-note processing** works great locally. Vault-wide operations (serendipity, audits) work better with larger models or a cloud LLM.
