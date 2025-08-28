# AI-Generated Comment Direct API Call
# Usage: Called by AI with generated JSON file

param(
    [string]$TicketKey,
    [string]$JsonFile
)

# Load environment variables from .env file in QA-Manual-Framework root
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
# Navigate up to find QA-Manual-Framework directory
$currentDir = $scriptDir
while ($currentDir -and (Split-Path -Leaf $currentDir) -ne "QA-Manual-Framework") {
    $currentDir = Split-Path -Parent $currentDir
}
$projectRoot = $currentDir
$envFile = Join-Path $projectRoot ".env"
Get-Content $envFile | ForEach-Object {
    if ($_ -match '^([^=]+)=(.*)$') {
        [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
    }
}

$JIRA_URL = "https://compstak.atlassian.net"
$EMAIL = $env:JIRA_MCP_LOGIN
$API_TOKEN = $env:JIRA_MCP_TOKEN

$headers = @{
    "Authorization" = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${EMAIL}:${API_TOKEN}"))
    "Content-Type" = "application/json"
}

# Read the AI-generated JSON file directly
try {
    $jsonPayload = Get-Content $JsonFile -Raw
    $response = Invoke-RestMethod -Uri "$JIRA_URL/rest/api/3/issue/$TicketKey/comment" -Method POST -Headers $headers -Body $jsonPayload
    
    Write-Host "✅ Comment added successfully!"
    Write-Host "Comment ID: $($response.id)"
    Write-Host "Ticket URL: $JIRA_URL/browse/$TicketKey"
    
} catch {
    Write-Host "❌ Error: $($_.Exception.Message)"
    exit 1
} finally {
    # Clean up the JSON file
    if (Test-Path $JsonFile) {
        Remove-Item $JsonFile -Force
    }
}
