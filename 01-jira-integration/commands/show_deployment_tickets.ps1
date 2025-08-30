# Show Deployment Tickets - QA Engineer Command
# Purpose: Show tickets assigned to the current QA Engineer that are ready for deployment (status "To Deploy")
# Usage: .\show_deployment_tickets.ps1

# Load environment variables from .env file in QA-Manual-Framework root
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
# Navigate up to find QA-Manual-Framework directory
$currentDir = $scriptDir
while ($currentDir -and (Split-Path -Leaf $currentDir) -ne "QA-Manual-Framework") {
    $currentDir = Split-Path -Parent $currentDir
}
$projectRoot = $currentDir
$envFile = Join-Path $projectRoot ".env"

if (Test-Path $envFile) {
    Write-Host "Loading environment from $envFile" -ForegroundColor Yellow
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^([^=]+)=(.*)$') {
            [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
        }
    }
} else {
    Write-Host "Warning: .env file not found at $envFile" -ForegroundColor Red
    Write-Host "Please create .env file in project root with JIRA_MCP_LOGIN and JIRA_MCP_TOKEN" -ForegroundColor Red
    exit 1
}

# Configuration from environment variables
$JIRA_URL = "https://your-domain.atlassian.net"
$EMAIL = $env:JIRA_MCP_LOGIN
$API_TOKEN = $env:JIRA_MCP_TOKEN

# Validate environment variables
if (-not $EMAIL) {
    Write-Host "Error: JIRA_MCP_LOGIN not found in environment variables" -ForegroundColor Red
    Write-Host "Please set JIRA_MCP_LOGIN in your project root .env file" -ForegroundColor Red
    exit 1
}

if (-not $API_TOKEN) {
    Write-Host "Error: JIRA_MCP_TOKEN not found in environment variables" -ForegroundColor Red
    Write-Host "Please set JIRA_MCP_TOKEN in your project root .env file" -ForegroundColor Red
    exit 1
}

# Create basic auth header
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $EMAIL, $API_TOKEN)))
$headers = @{Authorization=("Basic {0}" -f $base64AuthInfo)}

Write-Host "Show Deployment Tickets - QA Engineer Dashboard" -ForegroundColor Blue
Write-Host "=================================================" -ForegroundColor Blue

# Get current user info
Write-Host "Getting user information..." -ForegroundColor Yellow
$userInfo = Invoke-RestMethod -Uri "$JIRA_URL/rest/api/3/myself" -Headers $headers -Method Get
$accountId = $userInfo.accountId
$displayName = $userInfo.displayName

Write-Host "Current User: $displayName ($accountId)" -ForegroundColor Green
Write-Host ""

# Search for tickets where current user is QA Assignee and status is "To Deploy"
Write-Host "Searching for tickets ready for deployment..." -ForegroundColor Yellow

# JQL query to find tickets where current user is QA Assignee and status is "To Deploy"
$jqlQuery = "cf[11207] = `"$accountId`" AND project = YOUR_PROJECT AND status = `"To Deploy`" ORDER BY updated DESC"
$searchUrl = "$JIRA_URL/rest/api/3/search?jql=$([System.Web.HttpUtility]::UrlEncode($jqlQuery))`&maxResults=50`&fields=key,summary,status,priority,assignee,updated,customfield_11332"

try {
    $response = Invoke-RestMethod -Uri $searchUrl -Headers $headers -Method Get
    
    $total = $response.total
    Write-Host "Found $total tickets ready for deployment" -ForegroundColor Green
    Write-Host ""
    
    if ($total -eq 0) {
        Write-Host "No tickets found ready for deployment." -ForegroundColor Yellow
        Write-Host "These tickets have been tested on dev environment and are waiting to be deployed to staging." -ForegroundColor Cyan
        exit 0
    }
    
    # Display tickets in a formatted table
    Write-Host "===============================================================================================================" -ForegroundColor Blue
    Write-Host "Ticket Key  | Summary                                                     | Status      | Priority    | Last Updated        " -ForegroundColor Blue
    Write-Host "===============================================================================================================" -ForegroundColor Blue
    
    foreach ($issue in $response.issues) {
        $key = $issue.key
        $summary = $issue.fields.summary
        $status = $issue.fields.status.name
        $priority = $issue.fields.priority.name
        $updated = $issue.fields.updated
        $environment = $issue.fields.customfield_11332.value
        
        # Format date - handle different date formats
        try {
            $dateObj = [DateTime]::ParseExact($updated, "yyyy-MM-ddTHH:mm:ss.fffzzz", $null)
            $formattedDate = $dateObj.ToString("yyyy-MM-dd HH:mm")
        } catch {
            try {
                $dateObj = [DateTime]::Parse($updated)
                $formattedDate = $dateObj.ToString("yyyy-MM-dd HH:mm")
            } catch {
                $formattedDate = $updated
            }
        }
        
        # Truncate summary if too long
        $shortSummary = if ($summary.Length -gt 50) { $summary.Substring(0, 47) + "..." } else { $summary }
        
        # Color coding for deployment tickets (all should be "To Deploy" status)
        $statusColor = "Yellow"  # To Deploy status is highlighted in yellow
        
        Write-Host "$($key.PadRight(11)) | $($shortSummary.PadRight(55)) | " -NoNewline
        Write-Host $status.PadRight(11) -ForegroundColor $statusColor -NoNewline
        Write-Host " | $($priority.PadRight(11)) | $($formattedDate.ToString().PadRight(19))"
    }
    
    Write-Host "===============================================================================================================" -ForegroundColor Blue
    
    Write-Host ""
    Write-Host "Deployment Information:" -ForegroundColor Cyan
    Write-Host "  - These tickets have been tested on development environment" -ForegroundColor White
    Write-Host "  - All test cases have passed" -ForegroundColor White
    Write-Host "  - Ready to be deployed to staging environment" -ForegroundColor White
    Write-Host "  - Contact DevOps team for deployment process" -ForegroundColor White
    Write-Host ""
    Write-Host "Tips:" -ForegroundColor Yellow
    Write-Host "  - Use 'jira show-ticket [KEY]' to view detailed ticket information"
    Write-Host "  - Use 'jira update-status [KEY] [STATUS]' to update ticket status after deployment"
    Write-Host "  - Use 'jira add-comment [KEY]' to add deployment notes"
    Write-Host ""
    Write-Host "Command completed successfully!" -ForegroundColor Green
    
} catch {
    Write-Host "Error: Failed to retrieve deployment tickets" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
