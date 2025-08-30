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

$JIRA_URL = "https://your-domain.atlassian.net"
$EMAIL = $env:JIRA_MCP_LOGIN
$API_TOKEN = $env:JIRA_MCP_TOKEN

$headers = @{
    "Authorization" = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${EMAIL}:${API_TOKEN}"))
    "Content-Type" = "application/json"
}

# Read the AI-generated JSON file directly
try {
    Write-Host "Reading JSON file: $JsonFile"
    $jsonPayload = Get-Content $JsonFile -Raw -Encoding UTF8
    Write-Host "JSON payload size: $($jsonPayload.Length) characters"
    
    # Validate JSON structure
    try {
        $testJson = $jsonPayload | ConvertFrom-Json
        Write-Host "JSON validation passed"
    } catch {
        Write-Host "Invalid JSON structure: $($_.Exception.Message)"
        throw "Invalid JSON format"
    }
    
    Write-Host "Posting comment to JIRA..."
    $response = Invoke-RestMethod -Uri "$JIRA_URL/rest/api/3/issue/$TicketKey/comment" -Method POST -Headers $headers -Body $jsonPayload -ContentType "application/json; charset=utf-8"
    
    Write-Host "✅ Comment added successfully!"
    Write-Host "Comment ID: $($response.id)"
    Write-Host "Ticket URL: $JIRA_URL/browse/$TicketKey"
    
} catch {
    Write-Host "Error Details:"
    Write-Host "   Message: $($_.Exception.Message)"
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "   JIRA Response: $responseBody"
    }
    exit 1
} finally {
    # Clean up the JSON file
    if (Test-Path $JsonFile) {
        Remove-Item $JsonFile -Force
    }
}
