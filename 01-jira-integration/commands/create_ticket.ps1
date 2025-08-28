# Create JIRA Ticket - Comprehensive Bug Report Generator
# Purpose: Create Bug (t) tickets with proper ADF formatting and company compliance
# Usage: .\create_ticket.ps1 [Title] [Description] [Environment]

param(
    [string]$Title = "",
    [string]$Description = "",
    [string]$Environment = ""
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
    Write-Error "Environment file not found at $envFile - Please create .env file in project root with JIRA_MCP_LOGIN and JIRA_MCP_TOKEN"
    exit 1
}

# JIRA Configuration
$JIRA_URL = "https://compstak.atlassian.net"
$EMAIL = $env:JIRA_MCP_LOGIN
$API_TOKEN = $env:JIRA_MCP_TOKEN

if (-not $EMAIL -or -not $API_TOKEN) {
    Write-Error "JIRA_MCP_LOGIN or JIRA_MCP_TOKEN environment variables not set"
    exit 1
}

# Create auth header
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $EMAIL, $API_TOKEN)))
$headers = @{Authorization=("Basic {0}" -f $base64AuthInfo); "Content-Type"="application/json"}

Write-Host ""
Write-Host "Create JIRA Ticket - Comprehensive Bug Reporter" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan

# Get current user info
try {
    Write-Host "Getting user information..." -ForegroundColor Yellow
    $userResponse = Invoke-RestMethod -Uri "$JIRA_URL/rest/api/3/myself" -Headers $headers -Method Get
    $accountId = $userResponse.accountId
    $displayName = $userResponse.displayName
    Write-Host "Current User: $displayName ($accountId)" -ForegroundColor Green
} catch {
    Write-Error "Failed to get user information: $_"
    exit 1
}

# Function to get user input with validation
function Get-UserInput {
    param(
        [string]$Prompt,
        [scriptblock]$Validation = { $true }
    )
    
    do {
        $input = Read-Host $Prompt
        $isValid = & $Validation $input
        if (-not $isValid) {
            Write-Host "Invalid input. Please try again." -ForegroundColor Red
        }
    } while (-not $isValid)
    
    return $input
}

# Get inputs if not provided as parameters
if (-not $Title) {
    Write-Host ""
    Write-Host "Enter ticket title:" -ForegroundColor Cyan
    $Title = Get-UserInput -Prompt "Title" -Validation { -not [string]::IsNullOrWhiteSpace($args[0]) }
}

if (-not $Description) {
    Write-Host ""
    Write-Host "Describe the bug (include technical details, URLs, root cause if known):" -ForegroundColor Cyan
    $Description = Get-UserInput -Prompt "Description" -Validation { -not [string]::IsNullOrWhiteSpace($args[0]) }
}

if (-not $Environment) {
    Write-Host ""
    Write-Host "Available environments: dev, stage, prod" -ForegroundColor White
    $Environment = Get-UserInput -Prompt "Environment" -Validation { $args[0] -in @("dev", "stage", "prod") }
}

# Ensure QA Framework Testing prefix
if (-not $Title.StartsWith("[QA Manual Framework Testing]")) {
    $Title = "[QA Manual Framework Testing] " + $Title
}

Write-Host ""
Write-Host "QA Assignee automatically set to: $displayName ($accountId)" -ForegroundColor Yellow

# Detect if this is a technical bug report
$isTechnicalReport = $Description -match "(TECHNICAL|WORKING|BROKEN|Root cause|Testing URL|ES document|API response|JSON|{ |} |Expected.*Actual|Stage.*Production|Investigation reveals)"

if ($isTechnicalReport) {
    Write-Host "Detected technical bug report - generating comprehensive structure..." -ForegroundColor Yellow
    $priority = @{ id = "3" }  # Major
    $priorityDisplay = "Major (3)"
} else {
    $priority = @{ id = "4" }  # Low
    $priorityDisplay = "Low (4)"
}

# Create comprehensive bug ticket with proper ADF structure
$ticketData = @{
    fields = @{
        project = @{ key = "AP" }
        issuetype = @{ id = "1" }  # Bug (t)
        summary = $Title
        priority = $priority
        description = @{
            type = "doc"
            version = 1
            content = @(
                @{
                    type = "heading"
                    attrs = @{ level = 3 }
                    content = @(
                        @{
                            type = "text"
                            text = "Description"
                        }
                    )
                },
                @{
                    type = "paragraph"
                    content = @(
                        @{
                            type = "text"
                            text = $Description
                        }
                    )
                },
                @{
                    type = "heading"
                    attrs = @{ level = 3 }
                    content = @(
                        @{
                            type = "text"
                            text = "Environment"
                        }
                    )
                },
                @{
                    type = "paragraph"
                    content = @(
                        @{
                            type = "text"
                            text = "Environment: "
                            marks = @(@{ type = "strong" })
                        },
                        @{
                            type = "text"
                            text = $Environment
                        }
                    )
                },
                @{
                    type = "heading"
                    attrs = @{ level = 3 }
                    content = @(
                        @{
                            type = "text"
                            text = "Next Steps"
                        }
                    )
                },
                @{
                    type = "bulletList"
                    content = @(
                        @{
                            type = "listItem"
                            content = @(
                                @{
                                    type = "paragraph"
                                    content = @(
                                        @{
                                            type = "text"
                                            text = "Add detailed steps to reproduce"
                                        }
                                    )
                                }
                            )
                        },
                        @{
                            type = "listItem"
                            content = @(
                                @{
                                    type = "paragraph"
                                    content = @(
                                        @{
                                            type = "text"
                                            text = "Attach screenshots and evidence"
                                        }
                                    )
                                }
                            )
                        },
                        @{
                            type = "listItem"
                            content = @(
                                @{
                                    type = "paragraph"
                                    content = @(
                                        @{
                                            type = "text"
                                            text = "Verify expected vs actual behavior"
                                        }
                                    )
                                }
                            )
                        }
                    )
                },
                @{
                    type = "paragraph"
                    content = @(
                        @{
                            type = "text"
                            text = "Generated via QA Manual Framework Testing"
                            marks = @(@{ type = "em" })
                        }
                    )
                }
            )
        }
        customfield_11207 = @{ accountId = $accountId }  # QA Assignee
        customfield_11332 = @{ value = $Environment }    # Environment  
        customfield_10007 = 375                          # Sprint (Active Sprint)
    }
}

# For technical reports, enhance the description with comprehensive structure
if ($isTechnicalReport) {
    # Parse technical details from description
    $testingUrl = ""
    $rootCause = ""
    
    if ($Description -match "Testing URL:\s*([^\s]+)") {
        $testingUrl = $matches[1].Trim()
    }
    if ($Description -match "Root cause:\s*([^.]+\.?)") {
        $rootCause = $matches[1].Trim()
    }
    
    # Generate enhanced technical description
    $ticketData.fields.description = @{
        type = "doc"
        version = 1
        content = @(
            @{
                type = "heading"
                attrs = @{ level = 3 }
                content = @(
                    @{
                        type = "text"
                        text = "Description"
                    }
                )
            },
            @{
                type = "paragraph"
                content = @(
                    @{
                        type = "text"
                        text = $Description.Split('.')[0] + "."
                    }
                )
            },
            @{
                type = "heading"
                attrs = @{ level = 3 }
                content = @(
                    @{
                        type = "text"
                        text = "Expected vs Actual Behavior"
                    }
                )
            },
            @{
                type = "paragraph"
                content = @(
                    @{
                        type = "text"
                        text = "Expected: System functions correctly with complete data structure in Production environment."
                    }
                )
            },
            @{
                type = "paragraph"
                content = @(
                    @{
                        type = "text"
                        text = "Actual: System exhibits data inconsistencies or missing functionality in " + $Environment + " environment."
                    }
                )
            },
            @{
                type = "heading"
                attrs = @{ level = 3 }
                content = @(
                    @{
                        type = "text"
                        text = "Steps to Reproduce"
                    }
                )
            },
            @{
                type = "orderedList"
                content = @(
                    @{
                        type = "listItem"
                        content = @(
                            @{
                                type = "paragraph"
                                content = @(
                                    @{
                                        type = "text"
                                        text = "Login as enterprise user for example"
                                    }
                                )
                            }
                        )
                    },
                    @{
                        type = "listItem"
                        content = @(
                            @{
                                type = "paragraph"
                                content = @(
                                    @{
                                        type = "text"
                                        text = "Navigate to the affected system in " + $Environment + " environment"
                                    }
                                )
                            }
                        )
                    },
                    @{
                        type = "listItem"
                        content = @(
                            @{
                                type = "paragraph"
                                content = @(
                                    @{
                                        type = "text"
                                        text = "Observe the issue described in the bug report"
                                    }
                                )
                            }
                        )
                    }
                )
            },
            @{
                type = "heading"
                attrs = @{ level = 3 }
                content = @(
                    @{
                        type = "text"
                        text = "Technical Evidence"
                    }
                )
            }
        )
    }
    
    # Extract and format JSON content as proper code blocks
    if ($Description -match '\{.*\}') {
        # Extract Working JSON structure
        $workingMatch = [regex]::Match($Description, 'Working[^{]*(\{[^}]*\}[^}]*\})')
        $brokenMatch = [regex]::Match($Description, 'Broken[^{]*(\{[^}]*\}[^}]*\})')
        
        if ($workingMatch.Success) {
            $workingJson = $workingMatch.Groups[1].Value
            $ticketData.fields.description.content += @(
                @{
                    type = "paragraph"
                    content = @(
                        @{
                            type = "text"
                            text = "Production Environment (Working):"
                            marks = @(@{ type = "strong" })
                        }
                    )
                },
                @{
                    type = "codeBlock"
                    attrs = @{ language = "json" }
                    content = @(
                        @{
                            type = "text"
                            text = $workingJson
                        }
                    )
                }
            )
        }
        
        if ($brokenMatch.Success) {
            $brokenJson = $brokenMatch.Groups[1].Value
            $ticketData.fields.description.content += @(
                @{
                    type = "paragraph"
                    content = @(
                        @{
                            type = "text"
                            text = "Stage Environment (Broken):"
                            marks = @(@{ type = "strong" })
                        }
                    )
                },
                @{
                    type = "codeBlock"
                    attrs = @{ language = "json" }
                    content = @(
                        @{
                            type = "text"
                            text = $brokenJson
                        }
                    )
                }
            )
        }
    }
    
    # Add testing URL if available
    if ($testingUrl) {
        $ticketData.fields.description.content += @{
            type = "paragraph"
            content = @(
                @{
                    type = "text"
                    text = "Testing URL: "
                    marks = @(@{ type = "strong" })
                },
                @{
                    type = "text"
                    text = $testingUrl
                }
            )
        }
    }
    
    # Add root cause if available
    if ($rootCause) {
        $ticketData.fields.description.content += @(
            @{
                type = "heading"
                attrs = @{ level = 3 }
                content = @(
                    @{
                        type = "text"
                        text = "Root Cause Analysis"
                    }
                )
            },
            @{
                type = "paragraph"
                content = @(
                    @{
                        type = "text"
                        text = $rootCause
                    }
                )
            }
        )
    }
    
    # Add framework footer
    $ticketData.fields.description.content += @{
        type = "paragraph"
        content = @(
            @{
                type = "text"
                text = "Generated via QA Manual Framework Testing"
                marks = @(@{ type = "em" })
            }
        )
    }
}

# Show ticket preview
Write-Host ""
Write-Host "Ticket Summary:" -ForegroundColor Green
Write-Host "===============" -ForegroundColor Green
Write-Host "Title: $Title" -ForegroundColor White
Write-Host "Issue Type: Bug (t) (ID: 1)" -ForegroundColor Yellow
Write-Host "Priority: $priorityDisplay" -ForegroundColor Yellow
Write-Host "Environment: $Environment" -ForegroundColor White
Write-Host "QA Assignee: $displayName ($accountId)" -ForegroundColor White
Write-Host "Sprint: Active Sprint (375)" -ForegroundColor White

if ($isTechnicalReport) {
    Write-Host "Type: Technical Bug Report with comprehensive analysis" -ForegroundColor Yellow
    Write-Host "Content blocks: $($ticketData.fields.description.content.Count)" -ForegroundColor Cyan
} else {
    Write-Host "Type: Standard Bug Report" -ForegroundColor White
    Write-Host "Content blocks: $($ticketData.fields.description.content.Count)" -ForegroundColor Cyan
}

Write-Host ""
$confirm = Read-Host "Create this ticket? (y/N)"

if ($confirm -ne 'y' -and $confirm -ne 'Y') {
    Write-Host "Ticket creation cancelled." -ForegroundColor Yellow
    exit 0
}

# Create the ticket
try {
    Write-Host "Creating Bug (t) ticket..." -ForegroundColor Yellow
    
    $jsonBody = $ticketData | ConvertTo-Json -Depth 15
    $response = Invoke-RestMethod -Uri "$JIRA_URL/rest/api/3/issue" -Headers $headers -Method Post -Body $jsonBody
    
    Write-Host ""
    Write-Host "✅ Ticket created successfully!" -ForegroundColor Green
    Write-Host "Ticket Key: $($response.key)" -ForegroundColor Cyan
    Write-Host "Ticket URL: $JIRA_URL/browse/$($response.key)" -ForegroundColor Cyan
    Write-Host "Issue Type: Bug (t) with proper ADF formatting" -ForegroundColor Yellow
    
} catch {
    Write-Host ""
    Write-Host "❌ Failed to create ticket:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response: $responseBody" -ForegroundColor Red
    }
    exit 1
}