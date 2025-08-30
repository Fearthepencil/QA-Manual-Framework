#!/bin/bash

# Show Ready for QA Tickets - QA Engineer Command
# Purpose: Show tickets assigned to the current QA Engineer that are ready for QA testing (status "Ready for QA")
# Usage: ./show_ready_for_qa_tickets.sh

# Load environment variables from .env file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Navigate up to find QA-Manual-Framework directory
PROJECT_ROOT="$(cd "$SCRIPT_DIR" && while [[ "$PWD" != "/" && "$(basename "$PWD")" != "QA-Manual-Framework" ]]; do cd ..; done && pwd)"
ENV_FILE="$PROJECT_ROOT/.env"

if [ -f "$ENV_FILE" ]; then
    echo "Loading environment from $ENV_FILE" >&2
    export JIRA_MCP_LOGIN=$(grep '^JIRA_MCP_LOGIN=' "$ENV_FILE" | cut -d'=' -f2-)
    export JIRA_MCP_TOKEN=$(grep '^JIRA_MCP_TOKEN=' "$ENV_FILE" | cut -d'=' -f2-)
else
    echo "Error: .env file not found at $ENV_FILE - Please create .env file in project root" >&2
    exit 1
fi

# Check if required credentials are available
if [ -z "$JIRA_MCP_LOGIN" ] || [ -z "$JIRA_MCP_TOKEN" ]; then
    echo "Error: JIRA credentials not available (check project root .env file)" >&2
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
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}Show Ready for QA Tickets - QA Engineer Dashboard${NC}"
echo "==================================================="

# Get current user info
echo -e "${YELLOW}Getting user information...${NC}"
USER_INFO=$(curl -s -u "$EMAIL:$API_TOKEN" "$JIRA_URL/rest/api/3/myself")
ACCOUNT_ID=$(echo "$USER_INFO" | grep -o '"accountId":"[^"]*"' | cut -d'"' -f4)
DISPLAY_NAME=$(echo "$USER_INFO" | grep -o '"displayName":"[^"]*"' | cut -d'"' -f4)

echo -e "${GREEN}Current User: $DISPLAY_NAME ($ACCOUNT_ID)${NC}"
echo ""

# Search for tickets where current user is QA Assignee and status is "Ready for QA"
echo -e "${YELLOW}Searching for tickets ready for QA testing...${NC}"

# JQL query to find tickets where current user is QA Assignee and status is "Ready for QA"
JQL_QUERY="cf[YOUR_QA_ASSIGNEE_FIELD_ID] = \"$ACCOUNT_ID\" AND project = YOUR_PROJECT AND status = \"Ready for QA\" ORDER BY updated DESC"
# Use the exact encoding that works (same as PowerShell)
ENCODED_JQL="cf%5BYOUR_QA_ASSIGNEE_FIELD_ID%5D%20%3D%20%22$ACCOUNT_ID%22%20AND%20project%20%3D%20YOUR_PROJECT%20AND%20status%20%3D%20%22Ready%20for%20QA%22%20ORDER%20BY%20updated%20DESC"
SEARCH_URL="$JIRA_URL/rest/api/3/search?jql=$ENCODED_JQL&maxResults=50&fields=key,summary,status,priority,assignee,updated,customfield_YOUR_ENVIRONMENT_FIELD_ID"

RESPONSE=$(curl -s -u "$EMAIL:$API_TOKEN" "$SEARCH_URL")

# Check if response contains error
if echo "$RESPONSE" | grep -q "errorMessages"; then
    echo -e "${RED}Error: Failed to retrieve ready for QA tickets${NC}"
    echo "$RESPONSE"
    exit 1
fi

# Parse and display tickets
TOTAL=$(echo "$RESPONSE" | grep -o '"total":[0-9]*' | cut -d':' -f2)
if [ -z "$TOTAL" ]; then
    TOTAL=0
fi
echo -e "${GREEN}Found $TOTAL tickets ready for QA testing${NC}"
echo ""

if [ "$TOTAL" -eq 0 ]; then
    echo -e "${YELLOW}No tickets found ready for QA testing.${NC}"
    echo -e "${CYAN}These tickets have completed development and peer review and are waiting for QA testing to begin.${NC}"
    exit 0
fi

# Display tickets in a formatted table
echo "==============================================================================================================="
echo "Ticket Key  | Summary                                                     | Status      | Priority    | Last Updated        "
echo "==============================================================================================================="

# Parse the JSON response properly using a more robust approach
echo "$RESPONSE" | sed 's/},{/}\n{/g' | grep '"key":"YOUR_PROJECT-' | while read -r line; do
    # Extract ticket information using jq-like parsing
    KEY=$(echo "$line" | grep -o '"key":"[^"]*"' | cut -d'"' -f4)
    SUMMARY=$(echo "$line" | grep -o '"summary":"[^"]*"' | cut -d'"' -f4)
    STATUS=$(echo "$line" | grep -o '"name":"[^"]*"' | head -1 | cut -d'"' -f4)
    PRIORITY=$(echo "$line" | grep -o '"name":"[^"]*"' | tail -1 | cut -d'"' -f4)
    UPDATED=$(echo "$line" | grep -o '"updated":"[^"]*"' | cut -d'"' -f4)
    
    # Format the date
    if [ -n "$UPDATED" ]; then
        FORMATTED_DATE=$(echo "$UPDATED" | cut -d'T' -f1,2 | sed 's/T/ /' | cut -d'.' -f1)
    else
        FORMATTED_DATE="N/A"
    fi
    
    # Truncate summary if too long
    if [ ${#SUMMARY} -gt 50 ]; then
        SUMMARY="${SUMMARY:0:47}..."
    fi
    
    # Pad fields for alignment
    KEY_PADDED=$(printf "%-12s" "$KEY")
    SUMMARY_PADDED=$(printf "%-53s" "$SUMMARY")
    STATUS_PADDED=$(printf "%-12s" "$STATUS")
    PRIORITY_PADDED=$(printf "%-12s" "$PRIORITY")
    
    # Display the ticket information
    echo "$KEY_PADDED | $SUMMARY_PADDED | $STATUS_PADDED | $PRIORITY_PADDED | $FORMATTED_DATE"
done

echo "==============================================================================================================="
echo ""
echo -e "${CYAN}Ready for QA tickets are waiting for you to begin testing.${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Update ticket status to 'QA Testing' when you begin testing"
echo -e "2. Use enhanced test case templates from 03-test-plans/template/"
echo -e "3. Document test results and any issues found"
echo -e "4. Move to 'To Deploy' only after comprehensive testing is complete"
