# ZettleLib + LM Studio: Local Setup Guide

If you are using **LM Studio** instead of Ollama, you can easily run the ZettleLib pipeline entirely locally. LM Studio is fantastic because it provides an easy-to-use GUI for downloading models and exposes an OpenAI-compatible local server.

This guide explains how to hook up LM Studio to the ZettleLib workflow using the `AGENTS.md` configuration.

---

## 1. Choose and Download a Model in LM Studio

Open LM Studio and go to the **Search** tab. You want to look for models in the **GGUF** format that are tuned for instruction following.

**Top Recommendations for ZettleLib:**
1. **Gemma 4 (27B) GGUF**: (Search `gemma-4-27b-it-GGUF`). Look for a `Q4_K_M` or `Q5_K_M` quantization depending on your RAM. This is the best balance of reasoning and speed.
2. **Llama 3 (8B) Instruct GGUF**: (Search `Meta-Llama-3-8B-Instruct-GGUF`). If you have less than 16GB of RAM, grab the `Q4_K_M` version of this. It is extremely fast and follows the YAML frontmatter instructions well.
3. **Mistral Nemo (12B) Instruct GGUF**: Another excellent, lightweight alternative.

*Download your chosen model and load it in the chat interface to ensure it fits in your computer's memory.*

---

## 2. Start the Local Server

The magic of LM Studio is its local server. We will use this to send notes to the model.

1. In LM Studio, click the **Local Server** icon (the double-arrow `<->` icon on the left sidebar).
2. Select the model you just downloaded from the drop-down menu at the top.
3. Ensure the **Server Port** is set to `1234` (this is the default).
4. Click the green **Start Server** button.

LM Studio is now listening for requests at `http://localhost:1234/v1`.

---

## 3. Set up the ZettleLib Files

Ensure your vault is scaffolded correctly:
1. Place `AGENTS.md` in your vault root.
2. Place the `Prompt Library` folder, `Master Tag List.md`, and `Decision Log.md` in your `/80 System/` folder.

---

## 4. Processing Notes (Two Methods)

Since LM Studio doesn't have a native CLI tool like Gemini or Ollama, you have two ways to process your notes.

### Method A: Copy/Paste into LM Studio Chat (Easiest)
You can just use the standard Chat tab in LM Studio.

1. Go to the **Chat** tab in LM Studio.
2. In the right-hand **System Prompt** sidebar, paste the entire contents of the `AGENTS.md` file.
3. Open the specific prompt you want to run from your vault (e.g., `80 System/Prompt Library/prompt-J-triage.md`).
4. Copy the prompt text, fill in the placeholders (like `[TITLE]` and `[FULL NOTE CONTENT]`) with your new note's content.
5. Paste it into the LM Studio chat box and hit send.

### Method B: Use a Script via the Local Server (Faster)
You can create a quick PowerShell script to act as your "CLI" that talks to LM Studio's server. 

1. Create a file named `process-note.ps1` in your vault root.
2. Paste the following code into it:

```powershell
param (
    [Parameter(Mandatory=$true)]
    [string]$PromptFile,
    
    [Parameter(Mandatory=$true)]
    [string]$NoteFile
)

# Read the system config
$systemPrompt = Get-Content "AGENTS.md" -Raw

# Read the specific ZettleLib prompt and the user's note
$zettlePrompt = Get-Content $PromptFile -Raw
$noteContent = Get-Content $NoteFile -Raw

# Combine them (Replace the placeholder in the prompt with actual content)
$finalPrompt = $zettlePrompt.Replace("[FULL NOTE CONTENT]", $noteContent)

# Build the JSON payload for LM Studio
$body = @{
    messages = @(
        @{ role = "system"; content = $systemPrompt },
        @{ role = "user"; content = $finalPrompt }
    )
    temperature = 0.3 # Low temp for consistency
} | ConvertTo-Json -Depth 4

# Send to LM Studio
$response = Invoke-RestMethod -Uri "http://localhost:1234/v1/chat/completions" `
                              -Method Post `
                              -Headers @{ "Content-Type" = "application/json" } `
                              -Body $body

# Output the result
Write-Output "`n--- AI RESPONSE ---`n"
Write-Output $response.choices[0].message.content
```

**How to use the script:**
Open PowerShell in your vault root and run:
```powershell
.\process-note.ps1 -PromptFile "80 System\Prompt Library\prompt-J-triage.md" -NoteFile "00 Inbox\my-new-idea.md"
```

*Note: The script above is a basic wrapper. You will still need to manually replace the `[TITLE]` placeholder in the prompt file, or tweak the script to do it automatically!*

---

## Tips for LM Studio

1. **Keep Temperature Low**: ZettleLib requires strict formatting (like YAML output). In LM Studio, go to the right sidebar and set the **Temperature** to `0.2` or `0.3`.
2. **Context Window**: In the LM Studio Local Server settings, make sure your **Context Length** is set high enough (e.g., `8192` or `16384`) to handle pasting larger notes or multiple notes for Prompt E (Serendipity).
3. **Hardware Acceleration**: Make sure **GPU Offload** is maxed out in LM Studio settings so the model runs as fast as possible on your graphics card.
