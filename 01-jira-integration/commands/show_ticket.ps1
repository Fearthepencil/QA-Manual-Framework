# Show Ticket Details - QA Engineer Command
# Purpose: Show detailed information for a specific JIRA ticket
# Usage: .\show_ticket.ps1 -TicketKey "YOUR_PROJECT-12345"

param(
    [Parameter(Mandatory=$true)]
    [string]$TicketKey
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

# Create authorization header
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("${EMAIL}:${API_TOKEN}")))
$headers = @{
    "Authorization" = "Basic $base64AuthInfo"
    "Content-Type" = "application/json"
}

Write-Host ""
Write-Host "Show Ticket Details - QA Engineer Dashboard" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Blue
Write-Host ""

try {
    # Get current user info first
    Write-Host "Getting user information..." -ForegroundColor Yellow
    $userResponse = Invoke-RestMethod -Uri "$JIRA_URL/rest/api/3/myself" -Headers $headers -Method Get
    $currentUser = $userResponse.displayName
    $currentUserId = $userResponse.accountId
    Write-Host "Current User: $currentUser ($currentUserId)" -ForegroundColor Green
    Write-Host ""

    # Get ticket details with expanded fields including comments
    Write-Host "Retrieving details for ticket: $TicketKey..." -ForegroundColor Yellow
    $ticketUri = "$JIRA_URL/rest/api/3/issue/$TicketKey" + "?expand=renderedFields,comments"
    $response = Invoke-RestMethod -Uri $ticketUri -Headers $headers -Method Get
    
    Write-Host "Ticket found!" -ForegroundColor Green
    Write-Host ""
    
    # Extract ticket information
    $summary = $response.fields.summary
    $status = $response.fields.status.name
    $priority = $response.fields.priority.name
    $created = $response.fields.created
    $updated = $response.fields.updated
    $reporter = $response.fields.reporter.displayName
    $assignee = if ($response.fields.assignee) { $response.fields.assignee.displayName } else { "Unassigned" }
    $description = if ($response.fields.description) { $response.fields.description } else { "No description" }
    $environment = if ($response.fields.customfield_YOUR_ENVIRONMENT_FIELD_ID) { $response.fields.customfield_YOUR_ENVIRONMENT_FIELD_ID.value } else { "N/A" }
$qaAssignee = if ($response.fields.customfield_YOUR_QA_ASSIGNEE_FIELD_ID) { $response.fields.customfield_YOUR_QA_ASSIGNEE_FIELD_ID.displayName } else { "N/A" }
    
    # Format dates
    try {
        $createdDate = [DateTime]::Parse($created).ToString("dd/MM/yyyy HH:mm")
        $updatedDate = [DateTime]::Parse($updated).ToString("dd/MM/yyyy HH:mm")
    } catch {
        $createdDate = $created
        $updatedDate = $updated
    }
    
    # Display ticket details
    Write-Host "===============================================================================================================" -ForegroundColor Blue
    Write-Host "TICKET DETAILS" -ForegroundColor Cyan
    Write-Host "===============================================================================================================" -ForegroundColor Blue
    Write-Host ""
    Write-Host "Key:           $TicketKey" -ForegroundColor White
    Write-Host "Summary:       $summary" -ForegroundColor White
    Write-Host "Status:        $status" -ForegroundColor $(if ($status -eq "Done") { "Green" } elseif ($status -like "*QA*") { "Yellow" } else { "White" })
    Write-Host "Priority:      $priority" -ForegroundColor $(if ($priority -eq "Critical") { "Red" } elseif ($priority -eq "Major") { "Yellow" } else { "White" })
    Write-Host "Environment:   $environment" -ForegroundColor White
    Write-Host ""
    Write-Host "Reporter:      $reporter" -ForegroundColor White
    Write-Host "Assignee:      $assignee" -ForegroundColor White
    Write-Host "QA Assignee:   $qaAssignee" -ForegroundColor White
    Write-Host ""
    Write-Host "Created:       $createdDate" -ForegroundColor White
    Write-Host "Updated:       $updatedDate" -ForegroundColor White
    Write-Host ""
    Write-Host "URL:           $JIRA_URL/browse/$TicketKey" -ForegroundColor Cyan
    Write-Host ""
    
    # Function to extract text from ADF format
    function Get-AdfText {
        param($adfContent)
        
        if (-not $adfContent) { return "" }
        
        $text = ""
        if ($adfContent.content) {
            foreach ($item in $adfContent.content) {
                if ($item.type -eq "paragraph" -and $item.content) {
                    foreach ($textItem in $item.content) {
                        if ($textItem.text) {
                            $text += $textItem.text
                        }
                    }
                    $text += [Environment]::NewLine
                } elseif ($item.type -eq "bulletList" -and $item.content) {
                    foreach ($listItem in $item.content) {
                        $text += "• "
                        if ($listItem.content) {
                            foreach ($listContent in $listItem.content) {
                                if ($listContent.content) {
                                    foreach ($textItem in $listContent.content) {
                                        if ($textItem.text) {
                                            $text += $textItem.text
                                        }
                                    }
                                }
                            }
                        }
                        $text += [Environment]::NewLine
                    }
                } elseif ($item.type -eq "orderedList" -and $item.content) {
                    $counter = 1
                    foreach ($listItem in $item.content) {
                        $text += "$counter. "
                        if ($listItem.content) {
                            foreach ($listContent in $listItem.content) {
                                if ($listContent.content) {
                                    foreach ($textItem in $listContent.content) {
                                        if ($textItem.text) {
                                            $text += $textItem.text
                                        }
                                    }
                                }
                            }
                        }
                        $text += [Environment]::NewLine
                        $counter++
                    }
                } elseif ($item.type -eq "codeBlock" -and $item.content) {
                    $text += '```'
                    if ($item.attrs -and $item.attrs.language) {
                        $text += $item.attrs.language
                    }
                    $text += [Environment]::NewLine
                    foreach ($codeItem in $item.content) {
                        if ($codeItem.text) {
                            $text += $codeItem.text
                        }
                    }
                    $text += [Environment]::NewLine + '```' + [Environment]::NewLine
                } elseif ($item.type -eq "heading" -and $item.content) {
                    $level = if ($item.attrs -and $item.attrs.level) { $item.attrs.level } else { 1 }
                    $text += "#" * $level + " "
                    foreach ($textItem in $item.content) {
                        if ($textItem.text) {
                            $text += $textItem.text
                        }
                    }
                    $text += [Environment]::NewLine
                } elseif ($item.text) {
                    $text += $item.text
                }
            }
        } elseif ($adfContent.text) {
            $text = $adfContent.text
        }
        
        return $text.Trim()
    }
    
    # Display description if available
    if ($description -ne "No description") {
        Write-Host "===============================================================================================================" -ForegroundColor Blue
        Write-Host "DESCRIPTION" -ForegroundColor Cyan
        Write-Host "===============================================================================================================" -ForegroundColor Blue
        Write-Host ""
        
        # Try to get rendered description first, then fall back to parsing ADF
        $descriptionText = ""
        if ($response.renderedFields -and $response.renderedFields.description) {
            # Use rendered HTML and strip basic tags
            $descriptionText = $response.renderedFields.description -replace '<[^>]+>', '' -replace '&nbsp;', ' ' -replace '&lt;', '<' -replace '&gt;', '>' -replace '&amp;', '&'
        } elseif ($description.type -eq "doc") {
            $descriptionText = Get-AdfText $description
        } else {
            $descriptionText = $description
        }
        
        if ($descriptionText) {
            Write-Host "$descriptionText" -ForegroundColor White
        } else {
            Write-Host "[Complex formatting - view in JIRA for full details]" -ForegroundColor Gray
        }
        Write-Host ""
    }
    
    # Display comments if available
    if ($response.fields.comment -and $response.fields.comment.comments -and $response.fields.comment.comments.Count -gt 0) {
        Write-Host "===============================================================================================================" -ForegroundColor Blue
        Write-Host "COMMENTS ($($response.fields.comment.total))" -ForegroundColor Cyan
        Write-Host "===============================================================================================================" -ForegroundColor Blue
        Write-Host ""
        
        $commentNumber = 1
        foreach ($comment in $response.fields.comment.comments) {
            $commentAuthor = $comment.author.displayName
            $commentCreated = try { [DateTime]::Parse($comment.created).ToString("dd/MM/yyyy HH:mm") } catch { $comment.created }
            $commentUpdated = if ($comment.updated -ne $comment.created) { 
                try { [DateTime]::Parse($comment.updated).ToString("dd/MM/yyyy HH:mm") } catch { $comment.updated }
            } else { $null }
            
            Write-Host "Comment #$commentNumber" -ForegroundColor Yellow
            Write-Host "Author: $commentAuthor" -ForegroundColor White
            Write-Host "Created: $commentCreated" -ForegroundColor White
            if ($commentUpdated) {
                Write-Host "Updated: $commentUpdated" -ForegroundColor White
            }
            Write-Host "---" -ForegroundColor Gray
            
            # Extract comment body text
            $commentText = ""
            if ($comment.body) {
                $commentText = Get-AdfText $comment.body
            }
            
            if ($commentText) {
                Write-Host "$commentText" -ForegroundColor White
            } else {
                Write-Host "[Complex formatting in comment - view in JIRA for full details]" -ForegroundColor Gray
            }
            
            Write-Host ""
            $commentNumber++
        }
    } elseif ($response.fields.comment -and $response.fields.comment.total -gt 0) {
        Write-Host "Comments:      $($response.fields.comment.total) comment(s) available (some may be restricted)" -ForegroundColor White
        Write-Host ""
    }
    
    Write-Host "===============================================================================================================" -ForegroundColor Blue
    Write-Host ""
    Write-Host "Tips:" -ForegroundColor Yellow
    Write-Host "  - Use 'jira update-status $TicketKey [STATUS]' to update ticket status" -ForegroundColor Gray
    Write-Host "  - Use 'jira add-comment $TicketKey' to add comments to ticket" -ForegroundColor Gray
    Write-Host "  - View full details at: $JIRA_URL/browse/$TicketKey" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Command completed successfully!" -ForegroundColor Green

} catch {
    Write-Host "Error: Failed to retrieve ticket details for $TicketKey" -ForegroundColor Red
    Write-Host "Error details: $($_.Exception.Message)" -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $statusCode = $_.Exception.Response.StatusCode.value__
        if ($statusCode -eq 404) {
            Write-Host "Ticket $TicketKey not found or you don't have permission to view it" -ForegroundColor Red
        } elseif ($statusCode -eq 401) {
            Write-Host "Authentication failed - check your JIRA credentials" -ForegroundColor Red
        }
    }
    exit 1
}
