#!/bin/bash

# AI-Generated Comment Direct API Call
# Usage: Called by AI with generated JSON file

TICKET_KEY="$1"
JSON_FILE="$2"

# Load environment
ENV_FILE="01-jira-integration/config/.env"
export JIRA_MCP_LOGIN=$(grep '^JIRA_MCP_LOGIN=' "$ENV_FILE" | cut -d'=' -f2-)
export JIRA_MCP_TOKEN=$(grep '^JIRA_MCP_TOKEN=' "$ENV_FILE" | cut -d'=' -f2-)

JIRA_URL="https://compstak.atlassian.net"
EMAIL="$JIRA_MCP_LOGIN"
API_TOKEN="$JIRA_MCP_TOKEN"

# Make direct API call with AI-generated JSON
RESPONSE=$(curl -s -X POST \
    -u "$EMAIL:$API_TOKEN" \
    -H "Content-Type: application/json" \
    -d @"$JSON_FILE" \
    "$JIRA_URL/rest/api/3/issue/$TICKET_KEY/comment")

if echo "$RESPONSE" | grep -q "errorMessages"; then
    echo "❌ Error: $RESPONSE"
    exit 1
else
    COMMENT_ID=$(echo "$RESPONSE" | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
    echo "✅ Comment added successfully!"
    echo "Comment ID: $COMMENT_ID"
    echo "Ticket URL: $JIRA_URL/browse/$TICKET_KEY"
fi

# Clean up
rm -f "$JSON_FILE"
