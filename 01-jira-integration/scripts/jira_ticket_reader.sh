#!/bin/bash

# JIRA Ticket Reader Script
# Uses MCP server credentials to read comprehensive ticket information

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

# Function to read a single ticket
read_ticket() {
    local ticket_id="$1"
    
    echo "🔍 Reading Ticket $ticket_id..."
    echo "============================================================"
    
    # Get ticket with expanded field data
    curl -s -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
        -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        "https://compstak.atlassian.net/rest/api/2/issue/$ticket_id?expand=names,schema" \
        | jq -r '
        {
            "basic_info": {
                "key": .key,
                "summary": .fields.summary,
                "description": .fields.description,
                "status": .fields.status.name,
                "issue_type": .fields.issuetype.name,
                "priority": (if .fields.priority then .fields.priority.name else null end),
                "labels": .fields.labels,
                "components": [.fields.components[]?.name],
                "project": .fields.project.key
            },
            "people_info": {
                "assignee": {
                    "name": (if .fields.assignee then .fields.assignee.displayName else null end),
                    "email": (if .fields.assignee then .fields.assignee.emailAddress else null end),
                    "account_id": (if .fields.assignee then .fields.assignee.accountId else null end)
                },
                "reporter": {
                    "name": (if .fields.reporter then .fields.reporter.displayName else null end),
                    "email": (if .fields.reporter then .fields.reporter.emailAddress else null end),
                    "account_id": (if .fields.reporter then .fields.reporter.accountId else null end)
                }
            },
            "timeline": {
                "created": .fields.created,
                "updated": .fields.updated,
                "resolution_date": .fields.resolutiondate,
                "due_date": .fields.duedate
            }
        }'
}

# Function to search tickets using JQL
search_tickets() {
    local jql_query="$1"
    local max_results="${2:-50}"
    
    echo "🔍 Searching tickets with JQL: $jql_query"
    echo "============================================================"
    
    # URL encode the JQL query
    local encoded_jql=$(echo "$jql_query" | jq -sRr @uri)
    
    curl -s -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
        -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        "https://compstak.atlassian.net/rest/api/2/search?jql=$encoded_jql&maxResults=$max_results&fields=summary,status,assignee,reporter,created,updated" \
        | jq -r '.issues[] | {
            "key": .key,
            "summary": .fields.summary,
            "status": .fields.status.name,
            "assignee": (if .fields.assignee then .fields.assignee.displayName else "Unassigned" end),
            "reporter": .fields.reporter.displayName,
            "created": .fields.created,
            "updated": .fields.updated
        }'
}

# Function to get QA workload (tickets assigned to current user as QA)
get_qa_workload() {
    local status_filter="$1"
    local project_filter="$2"
    
    echo "🔍 Finding QA workload..."
    echo "============================================================"
    
    # Build JQL query
    local jql_query="assignee = currentUser()"
    
    if [ -n "$status_filter" ]; then
        jql_query="$jql_query AND status = \"$status_filter\""
    fi
    
    if [ -n "$project_filter" ]; then
        jql_query="$jql_query AND project = $project_filter"
    fi
    
    search_tickets "$jql_query"
}

# Function to get comments for a ticket
get_comments() {
    local ticket_id="$1"
    
    echo "💬 Getting comments for $ticket_id..."
    echo "============================================================"
    
    curl -s -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
        -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        "https://compstak.atlassian.net/rest/api/2/issue/$ticket_id/comment" \
        | jq -r '.comments[] | {
            "id": .id,
            "author": .author.displayName,
            "body": .body,
            "created": .created,
            "updated": .updated
        }'
}

# Main script logic
case "${1:-help}" in
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
        echo "JIRA Ticket Reader Script"
        echo "========================="
        echo ""
        echo "Usage:"
        echo "  $0 read <ticket_id>                    - Read comprehensive ticket information"
        echo "  $0 search \"<jql_query>\" [max_results] - Search tickets using JQL"
        echo "  $0 workload [status] [project]         - Get QA workload for current user"
        echo "  $0 comments <ticket_id>                - Get comments for a ticket"
        echo "  $0 help                                 - Show this help message"
        echo ""
        echo "Examples:"
        echo "  $0 read AP-20641"
        echo "  $0 search \"project = AP AND status = 'In Progress'\" 10"
        echo "  $0 workload \"To Do\" AP"
        echo "  $0 comments AP-20641"
        ;;
esac
