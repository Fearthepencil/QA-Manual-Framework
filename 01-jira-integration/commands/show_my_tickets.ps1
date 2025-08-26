# Show My Tickets - QA Engineer Command
# Purpose: Show tickets assigned to the current QA Engineer
# Usage: .\show_my_tickets.ps1

# Configuration
$JIRA_URL = "https://compstak.atlassian.net"
$EMAIL = "pavle.stefanovic@compstak.com"
$API_TOKEN = "ATATT3xFfGF0WoOP7XmgRbjig08sBPpatf0t6uHmOD4wCvsEYmvT7ghM7mpqUqLbXp15KXwP5UxY05uZ1UB4qIk6Y7GASxgHyFcG1sspSVrkGyh0JYZ7xcUfQpwPlSN0uxbJGljjB11Kv596K9QNLc4fQOC2SbYqo3sdjATSjla0wySte4AWi9g=E96B7070"

# Create basic auth header
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $EMAIL, $API_TOKEN)))
$headers = @{Authorization=("Basic {0}" -f $base64AuthInfo)}

Write-Host "Show My Tickets - QA Engineer Dashboard" -ForegroundColor Blue
Write-Host "================================================" -ForegroundColor Blue

# Get current user info
Write-Host "Getting user information..." -ForegroundColor Yellow
$userInfo = Invoke-RestMethod -Uri "$JIRA_URL/rest/api/3/myself" -Headers $headers -Method Get
$accountId = $userInfo.accountId
$displayName = $userInfo.displayName

Write-Host "Current User: $displayName ($accountId)" -ForegroundColor Green
Write-Host ""

# Search for tickets where current user is QA Assignee
Write-Host "Searching for tickets assigned to you as QA Assignee..." -ForegroundColor Yellow

# JQL query to find tickets where current user is QA Assignee
$jqlQuery = "cf[11207] = `"$accountId`" AND project = AP ORDER BY updated DESC"
$searchUrl = "$JIRA_URL/rest/api/3/search?jql=$([System.Web.HttpUtility]::UrlEncode($jqlQuery))`&maxResults=50`&fields=key,summary,status,priority,assignee,updated,customfield_11332"

try {
    $response = Invoke-RestMethod -Uri $searchUrl -Headers $headers -Method Get
    
    $total = $response.total
    Write-Host "Found $total tickets assigned to you as QA Assignee" -ForegroundColor Green
    Write-Host ""
    
    if ($total -eq 0) {
        Write-Host "No tickets found assigned to you as QA Assignee." -ForegroundColor Yellow
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
        
        # Format date
        $formattedDate = [DateTime]::Parse($updated).ToString("yyyy-MM-dd HH:mm")
        
        # Truncate summary if too long
        $shortSummary = if ($summary.Length -gt 50) { $summary.Substring(0, 47) + "..." } else { $summary }
        
        # Color coding based on status
        $statusColor = switch ($status) {
            { $_ -in @("Done", "Closed") } { "Green" }
            "In Progress" { "Yellow" }
            { $_ -in @("To Do", "Open") } { "Red" }
            default { "White" }
        }
        
        Write-Host "$($key.PadRight(11)) | $($shortSummary.PadRight(55)) | " -NoNewline
        Write-Host $status.PadRight(11) -ForegroundColor $statusColor -NoNewline
        Write-Host " | $($priority.PadRight(11)) | $($formattedDate.PadRight(19))"
    }
    
    Write-Host "===============================================================================================================" -ForegroundColor Blue
    
    Write-Host ""
    Write-Host "Tips:" -ForegroundColor Yellow
    Write-Host "  - Use 'jira show-ticket [KEY]' to view detailed ticket information"
    Write-Host "  - Use 'jira update-status [KEY] [STATUS]' to update ticket status"
    Write-Host "  - Use 'jira add-comment [KEY]' to add comments to tickets"
    Write-Host ""
    Write-Host "Command completed successfully!" -ForegroundColor Green
    
} catch {
    Write-Host "Error: Failed to retrieve tickets" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
