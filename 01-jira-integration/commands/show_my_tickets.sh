#!/bin/bash

# Show My Tickets - QA Engineer Command
# Purpose: Show tickets assigned to the current QA Engineer
# Usage: ./show_my_tickets.sh

# Load environment variables from .env file in QA-Manual-Framework root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Navigate up to find QA-Manual-Framework directory
PROJECT_ROOT="$(cd "$SCRIPT_DIR" && while [[ "$PWD" != "/" && "$(basename "$PWD")" != "QA-Manual-Framework" ]]; do cd ..; done && pwd)"
ENV_FILE="$PROJECT_ROOT/.env"

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

# Configuration from environment variables
JIRA_URL="https://your-domain.atlassian.net"
EMAIL="$JIRA_MCP_LOGIN"
API_TOKEN="$JIRA_MCP_TOKEN"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Show My Tickets - QA Engineer Dashboard${NC}"
echo "================================================"

# Get current user info
echo -e "${YELLOW}Getting user information...${NC}"
USER_INFO=$(curl -s -u "$EMAIL:$API_TOKEN" "$JIRA_URL/rest/api/3/myself")
ACCOUNT_ID=$(echo "$USER_INFO" | grep -o '"accountId":"[^"]*"' | cut -d'"' -f4)
DISPLAY_NAME=$(echo "$USER_INFO" | grep -o '"displayName":"[^"]*"' | cut -d'"' -f4)

echo -e "${GREEN}Current User: $DISPLAY_NAME ($ACCOUNT_ID)${NC}"
echo ""

# Search for tickets where current user is QA Assignee
echo -e "${YELLOW}Searching for tickets assigned to you as QA Assignee...${NC}"

# JQL query to find tickets where current user is QA Assignee
JQL_QUERY="cf[11207] = \"$ACCOUNT_ID\" AND project = YOUR_PROJECT ORDER BY updated DESC"
# Use the exact encoding that works (same as PowerShell)
ENCODED_JQL="cf%5B11207%5D%20%3D%20%22$ACCOUNT_ID%22%20AND%20project%20%3D%20YOUR_PROJECT%20ORDER%20BY%20updated%20DESC"
SEARCH_URL="$JIRA_URL/rest/api/3/search?jql=$ENCODED_JQL&maxResults=50&fields=key,summary,status,priority,assignee,updated,customfield_11332"

RESPONSE=$(curl -s -u "$EMAIL:$API_TOKEN" "$SEARCH_URL")

# Check if response contains error
if echo "$RESPONSE" | grep -q "errorMessages"; then
    echo -e "${RED}Error: Failed to retrieve tickets${NC}"
    echo "$RESPONSE"
    exit 1
fi

# Parse and display tickets
TOTAL=$(echo "$RESPONSE" | grep -o '"total":[0-9]*' | cut -d':' -f2)
if [ -z "$TOTAL" ]; then
    TOTAL=0
fi
echo -e "${GREEN}Found $TOTAL tickets assigned to you as QA Assignee${NC}"
echo ""

if [ "$TOTAL" -eq 0 ]; then
    echo -e "${YELLOW}No tickets found assigned to you as QA Assignee.${NC}"
    exit 0
fi

# Display tickets in a formatted table
echo "==============================================================================================================="
echo "Ticket Key  | Summary                                                     | Status      | Priority    | Last Updated        "
echo "==============================================================================================================="

# Parse the JSON response properly using a more robust approach
echo "$RESPONSE" | sed 's/},{/}\n{/g' | grep '"key":"YOUR_PROJECT-' | while read -r line; do
    # Extract key
    KEY=$(echo "$line" | grep -o '"key":"[^"]*"' | cut -d'"' -f4)
    
    # Extract summary
    SUMMARY=$(echo "$line" | grep -o '"summary":"[^"]*"' | cut -d'"' -f4)
    
    # Extract status name
    STATUS=$(echo "$line" | sed 's/.*"status":{[^}]*"name":"\([^"]*\)"[^}]*}.*/\1/')
    
    # Extract priority name
    PRIORITY=$(echo "$line" | sed 's/.*"priority":{[^}]*"name":"\([^"]*\)"[^}]*}.*/\1/')
    
    # Extract updated date
    UPDATED=$(echo "$line" | grep -o '"updated":"[^"]*"' | cut -d'"' -f4)
    
    # Format date
    FORMATTED_DATE=$(date -d "$UPDATED" +"%Y-%m-%d %H:%M" 2>/dev/null || echo "$UPDATED")
    
    # Truncate summary if too long
    SHORT_SUMMARY=$(echo "$SUMMARY" | cut -c1-50)
    if [ ${#SUMMARY} -gt 50 ]; then
        SHORT_SUMMARY="$SHORT_SUMMARY..."
    fi
    
    # Color coding based on status
    STATUS_COLOR=""
    case "$STATUS" in
        "Done"|"Closed") STATUS_COLOR="$GREEN" ;;
        "In Progress") STATUS_COLOR="$YELLOW" ;;
        "To Do"|"Open") STATUS_COLOR="$RED" ;;
        *) STATUS_COLOR="$NC" ;;
    esac
    
    printf "%-11s | %-55s | ${STATUS_COLOR}%-11s${NC} | %-11s | %-19s\n" \
        "$KEY" "$SHORT_SUMMARY" "$STATUS" "$PRIORITY" "$FORMATTED_DATE"
done

echo "==============================================================================================================="

echo ""
echo -e "${YELLOW}Tips:${NC}"
echo "  - Use 'jira show-ticket [KEY]' to view detailed ticket information"
echo "  - Use 'jira update-status [KEY] [STATUS]' to update ticket status"
echo "  - Use 'jira add-comment [KEY]' to add comments to tickets"
echo ""
echo -e "${GREEN}Command completed successfully!${NC}"
