param (
    [Parameter(Mandatory=$true, HelpMessage="Path to the ZettleLib prompt file (e.g., '80 System\Prompt Library\prompt-J-triage.md')")]
    [string]$PromptFile,
    
    [Parameter(Mandatory=$true, HelpMessage="Path to the note you want to process (e.g., '00 Inbox\my-new-idea.md')")]
    [string]$NoteFile,

    [Parameter(Mandatory=$false, HelpMessage="LM Studio Local Server URL. Default is http://localhost:1234/v1/chat/completions")]
    [string]$ServerUrl = "http://localhost:1234/v1/chat/completions"
)

# Ensure files exist
if (-not (Test-Path $PromptFile)) {
    Write-Error "Prompt file not found: $PromptFile"
    exit 1
}
if (-not (Test-Path $NoteFile)) {
    Write-Error "Note file not found: $NoteFile"
    exit 1
}
if (-not (Test-Path "AGENTS.md")) {
    Write-Error "AGENTS.md not found in current directory. Please run this script from your vault root."
    exit 1
}

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
    temperature = 0.2
    max_tokens = -1
    stream = $false
} | ConvertTo-Json -Depth 4

Write-Host "Sending request to LM Studio at $ServerUrl..." -ForegroundColor Cyan

# Send to LM Studio
try {
    $response = Invoke-RestMethod -Uri $ServerUrl `
                                  -Method Post `
                                  -Headers @{ "Content-Type" = "application/json" } `
                                  -Body $body

    # Output the result
    Write-Host "`n--- AI RESPONSE ---`n" -ForegroundColor Green
    Write-Output $response.choices[0].message.content
}
catch {
    Write-Error "Failed to connect to LM Studio. Is the Local Server running on port 1234?"
    Write-Error $_.Exception.Message
}
