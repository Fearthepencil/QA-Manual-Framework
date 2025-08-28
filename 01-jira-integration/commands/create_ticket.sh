#!/bin/bash

# Create JIRA Ticket - Comprehensive Bug Report Generator (Bash)
# Purpose: Create Bug (t) tickets with proper ADF formatting and company compliance
# Usage: ./create_ticket.sh [Title] [Description] [Environment]

# Load environment variables from .env file (same approach as working scripts)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR" && while [[ "$PWD" != "/" && ! -f "01-jira-integration/config/.env" ]]; do cd ..; done && pwd)"
ENV_FILE="$PROJECT_ROOT/01-jira-integration/config/.env"

load_env() {
    if [ -f "$ENV_FILE" ]; then
        echo "Loading environment from $ENV_FILE"
        export JIRA_MCP_LOGIN=$(grep '^JIRA_MCP_LOGIN=' "$ENV_FILE" | cut -d'=' -f2-)
        export JIRA_MCP_TOKEN=$(grep '^JIRA_MCP_TOKEN=' "$ENV_FILE" | cut -d'=' -f2-)
    else
        echo "Error: .env file not found at $ENV_FILE" >&2
        exit 1
    fi
    
    # Check if required credentials are available
    if [ -z "$JIRA_MCP_LOGIN" ] || [ -z "$JIRA_MCP_TOKEN" ]; then
        echo "Error: JIRA credentials not available (check .env file)" >&2
        exit 1
    fi
}

# Function to get user input with validation
get_user_input() {
    local prompt="$1"
    local input=""
    
    while [ -z "$input" ]; do
        echo -n "$prompt: "
        read input
        if [ -z "$input" ]; then
            echo "Invalid input. Please try again."
        fi
    done
    
    echo "$input"
}

# Function to get environment input with validation
get_environment_input() {
    local env=""
    
    while [[ ! "$env" =~ ^(dev|stage|prod)$ ]]; do
        echo "Available environments: dev, stage, prod"
        echo -n "Environment: "
        read env
        if [[ ! "$env" =~ ^(dev|stage|prod)$ ]]; then
            echo "Invalid environment. Please choose dev, stage, or prod."
        fi
    done
    
    echo "$env"
}

# Initialize variables
TITLE="$1"
DESCRIPTION="$2"
ENVIRONMENT="$3"

# Load environment
load_env

# Configuration from environment variables  
JIRA_URL="https://compstak.atlassian.net"
EMAIL="$JIRA_MCP_LOGIN"
API_TOKEN="$JIRA_MCP_TOKEN"

echo ""
echo "Create JIRA Ticket - Comprehensive Bug Reporter"
echo "=============================================="

# Get current user info
echo "Getting user information..."
USER_RESPONSE=$(curl -s -u "$EMAIL:$API_TOKEN" \
    -H "Content-Type: application/json" \
    "$JIRA_URL/rest/api/3/myself")

if echo "$USER_RESPONSE" | grep -q "errorMessages"; then
    echo "Error: Failed to get user information"
    echo "$USER_RESPONSE"
    exit 1
fi

ACCOUNT_ID=$(echo "$USER_RESPONSE" | grep -o '"accountId":"[^"]*"' | cut -d'"' -f4)
DISPLAY_NAME=$(echo "$USER_RESPONSE" | grep -o '"displayName":"[^"]*"' | cut -d'"' -f4)

echo "Current User: $DISPLAY_NAME ($ACCOUNT_ID)"

# Get inputs if not provided as parameters
if [ -z "$TITLE" ]; then
    echo ""
    echo "Enter ticket title:"
    TITLE=$(get_user_input "Title")
fi

if [ -z "$DESCRIPTION" ]; then
    echo ""
    echo "Describe the bug (include technical details, URLs, root cause if known):"
    DESCRIPTION=$(get_user_input "Description")
fi

if [ -z "$ENVIRONMENT" ]; then
    echo ""
    ENVIRONMENT=$(get_environment_input)
fi

# Ensure QA Framework Testing prefix
if [[ ! "$TITLE" =~ ^\[QA\ Manual\ Framework\ Testing\] ]]; then
    TITLE="[QA Manual Framework Testing] $TITLE"
fi

echo ""
echo "QA Assignee automatically set to: $DISPLAY_NAME ($ACCOUNT_ID)"

# Detect if this is a technical bug report
if echo "$DESCRIPTION" | grep -E -q "(TECHNICAL|WORKING|BROKEN|Root cause|Testing URL|ES document|API response|JSON|\{|\}|Expected.*Actual|Stage.*Production|Investigation reveals)"; then
    echo "Detected technical bug report - generating comprehensive structure..."
    PRIORITY_ID="3"  # Major
    PRIORITY_DISPLAY="Major (3)"
    IS_TECHNICAL=true
else
    PRIORITY_ID="4"  # Low
    PRIORITY_DISPLAY="Low (4)"
    IS_TECHNICAL=false
fi

# Parse technical details if technical report
TESTING_URL=""
ROOT_CAUSE=""

if [ "$IS_TECHNICAL" = true ]; then
    TESTING_URL=$(echo "$DESCRIPTION" | grep -o "Testing URL:[[:space:]]*[^[:space:]]*" | sed 's/Testing URL:[[:space:]]*//')
    ROOT_CAUSE=$(echo "$DESCRIPTION" | grep -o "Root cause:[^.]*\." | sed 's/Root cause:[[:space:]]*//')
fi

# Create comprehensive ticket JSON based on type
if [ "$IS_TECHNICAL" = true ]; then
    # Enhanced technical description with comprehensive structure
    FIRST_SENTENCE=$(echo "$DESCRIPTION" | sed 's/\..*/./')
    
    TICKET_JSON=$(cat <<EOF
{
  "fields": {
    "project": { "key": "AP" },
    "issuetype": { "id": "1" },
    "summary": "$TITLE",
    "priority": { "id": "$PRIORITY_ID" },
    "description": {
      "type": "doc",
      "version": 1,
      "content": [
        {
          "type": "heading",
          "attrs": { "level": 3 },
          "content": [
            {
              "type": "text",
              "text": "Description"
            }
          ]
        },
        {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "$FIRST_SENTENCE"
            }
          ]
        },
        {
          "type": "heading",
          "attrs": { "level": 3 },
          "content": [
            {
              "type": "text",
              "text": "Expected vs Actual Behavior"
            }
          ]
        },
        {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "Expected: System functions correctly with complete data structure in Production environment."
            }
          ]
        },
        {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "Actual: System exhibits data inconsistencies or missing functionality in $ENVIRONMENT environment."
            }
          ]
        },
        {
          "type": "heading",
          "attrs": { "level": 3 },
          "content": [
            {
              "type": "text",
              "text": "Steps to Reproduce"
            }
          ]
        },
        {
          "type": "orderedList",
          "content": [
            {
              "type": "listItem",
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Login as enterprise user for example"
                    }
                  ]
                }
              ]
            },
            {
              "type": "listItem",
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Navigate to the affected system in $ENVIRONMENT environment"
                    }
                  ]
                }
              ]
            },
            {
              "type": "listItem",
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Observe the issue described in the bug report"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "type": "heading",
          "attrs": { "level": 3 },
          "content": [
            {
              "type": "text",
              "text": "Technical Evidence"
            }
          ]
        },
        {
          "type": "heading",
          "attrs": { "level": 3 },
          "content": [
            {
              "type": "text",
              "text": "Additional Information"
            }
          ]
        },
        {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "Environment: $ENVIRONMENT"
            }
          ]
        },
        {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "Testing URL: $TESTING_URL"
            }
          ]
        },
        {
          "type": "heading",
          "attrs": { "level": 3 },
          "content": [
            {
              "type": "text",
              "text": "Technical Evidence"
            }
          ]
        }
EOF
)

    # Extract and add JSON content as code blocks
    if echo "$DESCRIPTION" | grep -q "{.*}"; then
        # Extract JSON structures for code blocks
        WORKING_JSON=$(echo "$DESCRIPTION" | grep -A5 -B2 "Working.*{" | grep -E "\{.*\}" | head -1 | sed 's/.*{\(.*\)}.*/{\1}/')
        BROKEN_JSON=$(echo "$DESCRIPTION" | grep -A5 -B2 "Broken.*{" | grep -E "\{.*\}" | head -1 | sed 's/.*{\(.*\)}.*/{\1}/')
        
        if [ -n "$WORKING_JSON" ] || [ -n "$BROKEN_JSON" ]; then
            TICKET_JSON+=",
        {
          \"type\": \"paragraph\",
          \"content\": [
            {
              \"type\": \"text\",
              \"text\": \"Production Environment (Working):\",
              \"marks\": [{\"type\": \"strong\"}]
            }
          ]
        },
        {
          \"type\": \"codeBlock\",
          \"attrs\": {\"language\": \"json\"},
          \"content\": [
            {
              \"type\": \"text\",
              \"text\": \"$WORKING_JSON\"
            }
          ]
        },
        {
          \"type\": \"paragraph\",
          \"content\": [
            {
              \"type\": \"text\",
              \"text\": \"Stage Environment (Broken):\",
              \"marks\": [{\"type\": \"strong\"}]
            }
          ]
        },
        {
          \"type\": \"codeBlock\",
          \"attrs\": {\"language\": \"json\"},
          \"content\": [
            {
              \"type\": \"text\",
              \"text\": \"$BROKEN_JSON\"
            }
          ]
        }"
        fi
    fi

    # Add testing URL if available
    if [ -n "$TESTING_URL" ]; then
        TICKET_JSON+=",
        {
          \"type\": \"paragraph\",
          \"content\": [
            {
              \"type\": \"text\",
              \"text\": \"Testing URL: \",
              \"marks\": [{\"type\": \"strong\"}]
            },
            {
              \"type\": \"text\",
              \"text\": \"$TESTING_URL\"
            }
          ]
        }"
    fi

    # Add root cause if available
    if [ -n "$ROOT_CAUSE" ]; then
        TICKET_JSON+=",
        {
          \"type\": \"heading\",
          \"attrs\": { \"level\": 3 },
          \"content\": [
            {
              \"type\": \"text\",
              \"text\": \"Root Cause Analysis\"
            }
          ]
        },
        {
          \"type\": \"paragraph\",
          \"content\": [
            {
              \"type\": \"text\",
              \"text\": \"$ROOT_CAUSE\"
            }
          ]
        }"
    fi

    # Add QA Framework Validation section
    TICKET_JSON+=",
        {
          \"type\": \"heading\",
          \"attrs\": { \"level\": 3 },
          \"content\": [
            {
              \"type\": \"text\",
              \"text\": \"QA Framework Validation\"
            }
          ]
        },
        {
          \"type\": \"bulletList\",
          \"content\": [
            {
              \"type\": \"listItem\",
              \"content\": [
                {
                  \"type\": \"paragraph\",
                  \"content\": [
                    {
                      \"type\": \"text\",
                      \"text\": \"Bug reproduced and verified\"
                    }
                  ]
                }
              ]
            },
            {
              \"type\": \"listItem\",
              \"content\": [
                {
                  \"type\": \"paragraph\",
                  \"content\": [
                    {
                      \"type\": \"text\",
                      \"text\": \"Environment comparison completed\"
                    }
                  ]
                }
              ]
            },
            {
              \"type\": \"listItem\",
              \"content\": [
                {
                  \"type\": \"paragraph\",
                  \"content\": [
                    {
                      \"type\": \"text\",
                      \"text\": \"Technical evidence documented\"
                    }
                  ]
                }
              ]
            },
            {
              \"type\": \"listItem\",
              \"content\": [
                {
                  \"type\": \"paragraph\",
                  \"content\": [
                    {
                      \"type\": \"text\",
                      \"text\": \"Root cause analysis provided\"
                    }
                  ]
                }
              ]
            }
          ]
        }"

    # Add framework footer and close JSON
    TICKET_JSON+=",
        {
          \"type\": \"paragraph\",
          \"content\": [
            {
              \"type\": \"text\",
              \"text\": \"Generated via QA Manual Framework Testing\",
              \"marks\": [{\"type\": \"em\"}]
            }
          ]
        }
      ]
    },
    \"customfield_11207\": { \"accountId\": \"$ACCOUNT_ID\" },
    \"customfield_11332\": { \"value\": \"$ENVIRONMENT\" },
    \"customfield_10007\": 375
  }
}"

else
    # Standard bug report
    TICKET_JSON=$(cat <<EOF
{
  "fields": {
    "project": { "key": "AP" },
    "issuetype": { "id": "1" },
    "summary": "$TITLE",
    "priority": { "id": "$PRIORITY_ID" },
    "description": {
      "type": "doc",
      "version": 1,
      "content": [
        {
          "type": "heading",
          "attrs": { "level": 3 },
          "content": [
            {
              "type": "text",
              "text": "Description"
            }
          ]
        },
        {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "$DESCRIPTION"
            }
          ]
        },
        {
          "type": "heading",
          "attrs": { "level": 3 },
          "content": [
            {
              "type": "text",
              "text": "Environment"
            }
          ]
        },
        {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "Environment: ",
              "marks": [{"type": "strong"}]
            },
            {
              "type": "text",
              "text": "$ENVIRONMENT"
            }
          ]
        },
        {
          "type": "heading",
          "attrs": { "level": 3 },
          "content": [
            {
              "type": "text",
              "text": "Next Steps"
            }
          ]
        },
        {
          "type": "bulletList",
          "content": [
            {
              "type": "listItem",
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Add detailed steps to reproduce"
                    }
                  ]
                }
              ]
            },
            {
              "type": "listItem",
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Attach screenshots and evidence"
                    }
                  ]
                }
              ]
            },
            {
              "type": "listItem",
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {
                      "type": "text",
                      "text": "Verify expected vs actual behavior"
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "Generated via QA Manual Framework Testing",
              "marks": [{"type": "em"}]
            }
          ]
        }
      ]
    },
    "customfield_11207": { "accountId": "$ACCOUNT_ID" },
    "customfield_11332": { "value": "$ENVIRONMENT" },
    "customfield_10007": 375
  }
}
EOF
)
fi

# Count content blocks for display (count content array items)
CONTENT_BLOCKS=$(echo "$TICKET_JSON" | grep -o '"content":[[:space:]]*\[' | wc -l)

# Show ticket preview
echo ""
echo "Ticket Summary:"
echo "==============="
echo "Title: $TITLE"
echo "Issue Type: Bug (t) (ID: 1)"
echo "Priority: $PRIORITY_DISPLAY"
echo "Environment: $ENVIRONMENT"
echo "QA Assignee: $DISPLAY_NAME ($ACCOUNT_ID)"
echo "Sprint: Active Sprint (375)"

if [ "$IS_TECHNICAL" = true ]; then
    echo "Type: Technical Bug Report with comprehensive analysis"
else
    echo "Type: Standard Bug Report"
fi

echo "Content blocks: $CONTENT_BLOCKS"
echo ""

# Ask for confirmation
echo -n "Create this ticket? (y/N): "
read CONFIRM

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Ticket creation cancelled."
    exit 0
fi

# Create the ticket
echo "Creating Bug (t) ticket..."

RESPONSE=$(curl -s -X POST \
    -u "$EMAIL:$API_TOKEN" \
    -H "Content-Type: application/json" \
    -d "$TICKET_JSON" \
    "$JIRA_URL/rest/api/3/issue")

# Check for errors
if echo "$RESPONSE" | grep -q "errorMessages"; then
    echo ""
    echo "❌ Failed to create ticket:"
    echo "$RESPONSE" | grep -o '"errorMessages":\[[^]]*\]' || echo "$RESPONSE"
    exit 1
else
    TICKET_KEY=$(echo "$RESPONSE" | grep -o '"key":"[^"]*"' | cut -d'"' -f4) 
    echo ""
    echo "✅ Ticket created successfully!"
    echo "Ticket Key: $TICKET_KEY"
    echo "Ticket URL: $JIRA_URL/browse/$TICKET_KEY"
    echo "Issue Type: Bug (t) with proper ADF formatting"
fi