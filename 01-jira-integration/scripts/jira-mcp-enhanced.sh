#!/bin/bash

# Enhanced Jira MCP Server Wrapper
# Combines ticket creation and reading capabilities
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
    echo "Warning: .env file not found at $ENV_FILE" >&2
fi

# Check if required credentials are available
if [ -z "$JIRA_MCP_LOGIN" ]; then
    echo "Error: JIRA_MCP_LOGIN not available (check .env file)" >&2
    exit 1
fi

if [ -z "$JIRA_MCP_TOKEN" ]; then
    echo "Error: JIRA_MCP_TOKEN not available (check .env file)" >&2
    exit 1
fi

# Function to show available commands
show_help() {
    echo "Enhanced JIRA MCP Integration"
    echo "============================="
    echo ""
    echo "Available commands:"
    echo "  server     - Start MCP server for ticket creation"
    echo "  read       - Read ticket information"
    echo "  search     - Search tickets using JQL"
    echo "  workload   - Get QA workload"
    echo "  comments   - Get ticket comments"
    echo "  help       - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 server"
    echo "  $0 read AP-20641"
    echo "  $0 search \"project = AP AND status = 'In Progress'\""
    echo "  $0 workload \"To Do\" AP"
    echo "  $0 comments AP-20641"
}

# Function to read a single ticket
read_ticket() {
    local ticket_id="$1"
    echo "Reading ticket: $ticket_id"
    echo "============================================================"
    
    local response=$(curl -s -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
        "https://compstak.atlassian.net/rest/api/3/issue/$ticket_id?expand=names,schema")
    
    if echo "$response" | jq -e '.errorMessages' > /dev/null 2>&1; then
        echo "Error: $(echo "$response" | jq -r '.errorMessages[0]')"
        return 1
    fi
    
    echo "Ticket: $(echo "$response" | jq -r '.key')"
    echo "Summary: $(echo "$response" | jq -r '.fields.summary')"
    echo "Status: $(echo "$response" | jq -r '.fields.status.name')"
    echo "Priority: $(echo "$response" | jq -r '.fields.priority.name')"
    echo "Assignee: $(echo "$response" | jq -r '.fields.assignee.displayName // "Unassigned"')"
    echo "Reporter: $(echo "$response" | jq -r '.fields.reporter.displayName')"
    echo "Created: $(echo "$response" | jq -r '.fields.created')"
    echo "Updated: $(echo "$response" | jq -r '.fields.updated')"
    echo "Description: $(echo "$response" | jq -r '.fields.description // "No description"')"
}

# Function to search tickets using JQL
search_tickets() {
    local jql="$1"
    local max_results="${2:-50}"
    
    echo "Searching tickets with JQL: $jql"
    echo "============================================================"
    
    local response=$(curl -s -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
        "https://compstak.atlassian.net/rest/api/3/search" \
        -H "Content-Type: application/json" \
        -d "{
            \"jql\": \"$jql\",
            \"maxResults\": $max_results,
            \"fields\": [\"summary\", \"status\", \"priority\", \"assignee\", \"reporter\", \"created\", \"updated\"]
        }")
    
    if echo "$response" | jq -e '.errorMessages' > /dev/null 2>&1; then
        echo "Error: $(echo "$response" | jq -r '.errorMessages[0]')"
        return 1
    fi
    
    local total=$(echo "$response" | jq -r '.total')
    echo "Found $total tickets"
    echo ""
    
    echo "$response" | jq -r '.issues[] | "\(.key) | \(.fields.summary) | \(.fields.status.name) | \(.fields.priority.name) | \(.fields.assignee.displayName // "Unassigned")"'
}

# Function to get QA workload (tickets assigned to current user as QA)
get_qa_workload() {
    local status_filter="$1"
    local project="$2"
    
    local jql="project = $project"
    if [ -n "$status_filter" ]; then
        jql="$jql AND status = '$status_filter'"
    fi
    
    # Try QA Assignee field first, fallback to standard assignee
    local qa_jql="$jql AND assignee = currentUser()"
    
    echo "Getting QA workload for project: $project"
    if [ -n "$status_filter" ]; then
        echo "Status filter: $status_filter"
    fi
    echo "============================================================"
    
    search_tickets "$qa_jql"
}

# Function to get comments for a ticket
get_comments() {
    local ticket_id="$1"
    
    echo "Getting comments for ticket: $ticket_id"
    echo "============================================================"
    
    local response=$(curl -s -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
        "https://compstak.atlassian.net/rest/api/3/issue/$ticket_id/comment")
    
    if echo "$response" | jq -e '.errorMessages' > /dev/null 2>&1; then
        echo "Error: $(echo "$response" | jq -r '.errorMessages[0]')"
        return 1
    fi
    
    local total=$(echo "$response" | jq -r '.total')
    echo "Found $total comments"
    echo ""
    
    echo "$response" | jq -r '.comments[] | "---\nAuthor: \(.author.displayName)\nCreated: \(.created)\nBody: \(.body // "No content")\n---"'
}

# Main script logic
case "${1:-help}" in
    "server")
        echo "Starting JIRA MCP Server for ticket creation..."
        echo "============================================================"
        npx @timbreeding/jira-mcp-server@latest \
            --jira-base-url=https://compstak.atlassian.net \
            --jira-username="$JIRA_MCP_LOGIN" \
            --jira-api-token="$JIRA_MCP_TOKEN"
        ;;
    "read")
        if [ -z "$2" ]; then
            echo "Usage: $0 read <ticket_id>"
            exit 1
        fi
        read_ticket "$2"
        ;;
    "search")
        if [ -z "$2" ]; then
            echo "Usage: $0 search \"<jql_query>\" [max_results]"
            exit 1
        fi
        search_tickets "$2" "$3"
        ;;
    "workload")
        get_qa_workload "$2" "$3"
        ;;
    "comments")
        if [ -z "$2" ]; then
            echo "Usage: $0 comments <ticket_id>"
            exit 1
        fi
        get_comments "$2"
        ;;
    "help"|*)
        show_help
        ;;
esac
