#!/bin/bash

# Script to find all tickets where Ognjen Putniković is assigned as QA Assignee
# Loads credentials from .env file

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR" && while [[ "$PWD" != "/" && ! -f ".env" ]]; do cd ..; done && pwd)"
ENV_FILE="$PROJECT_ROOT/.env"

# Load .env file if it exists
if [ -f "$ENV_FILE" ]; then
    echo "Loading environment from $ENV_FILE" >&2
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

echo "🔍 Finding tickets where Ognjen Putniković is QA Assignee..."
echo "============================================================"
echo ""

# Get all QA-related tickets
echo "📋 Step 1: Getting QA-related tickets..."
qa_tickets=$(curl -s -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
    "https://compstak.atlassian.net/rest/api/3/search" \
    -H "Content-Type: application/json" \
    -d '{
        "jql": "project = AP AND (summary ~ \"QA\" OR summary ~ \"test\" OR summary ~ \"Test\") AND status != \"Done\"",
        "maxResults": 1000,
        "fields": ["summary", "status", "priority", "assignee"]
    }')

if echo "$qa_tickets" | jq -e '.errorMessages' > /dev/null 2>&1; then
    echo "Error: $(echo "$qa_tickets" | jq -r '.errorMessages[0]')"
    exit 1
fi

total_tickets=$(echo "$qa_tickets" | jq -r '.total')
echo "Found $total_tickets QA-related tickets to check"
echo ""

# Initialize counters
found_count=0
checked_count=0

echo "🔍 Step 2: Checking QA Assignee field for each ticket..."
echo "============================================================"
echo ""

# Process each ticket
echo "$qa_tickets" | jq -r '.issues[] | .key' | while read -r ticket_key; do
    checked_count=$((checked_count + 1))
    
    # Get ticket details with QA Assignee field
    ticket_data=$(curl -s -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
        "https://compstak.atlassian.net/rest/api/3/issue/$ticket_key?expand=names,schema")
    
    # Check if QA Assignee field exists and is set to Ognjen Putniković
    qa_assignee=$(echo "$ticket_data" | jq -r '.fields.customfield_11207.displayName // empty')
    
    if [ "$qa_assignee" = "Ognjen Putniković" ]; then
        found_count=$((found_count + 1))
        summary=$(echo "$ticket_data" | jq -r '.fields.summary')
        status=$(echo "$ticket_data" | jq -r '.fields.status.name')
        priority=$(echo "$ticket_data" | jq -r '.fields.priority.name // "null"')
        
        echo "✅ $ticket_key | $summary | $status | $priority"
    fi
    
    # Progress indicator
    if [ $((checked_count % 10)) -eq 0 ]; then
        echo "   Checked $checked_count/$total_tickets tickets..." >&2
    fi
done

echo ""
echo "============================================================"
echo "🎯 Summary:"
echo "   Total QA-related tickets checked: $checked_count"
echo "   Tickets with Ognjen Putniković as QA Assignee: $found_count"
echo "============================================================"
