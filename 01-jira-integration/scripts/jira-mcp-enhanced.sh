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
    echo "  $0 read YOUR_PROJECT-12345"
    echo "  $0 search \"project = YOUR_PROJECT AND status = 'In Progress'\""
    echo "  $0 workload \"To Do\" YOUR_PROJECT"
    echo "  $0 comments YOUR_PROJECT-12345"
}

# Function to run ticket reader
run_reader() {
    local script_path="$PROJECT_ROOT/01-jira-integration/scripts/jira_ticket_reader.sh"
    if [ -f "$script_path" ]; then
        "$script_path" "$@"
    else
        echo "Error: Ticket reader script not found at $script_path"
        exit 1
    fi
}

# Main script logic
case "${1:-help}" in
    "server")
        echo "Starting JIRA MCP Server for ticket creation..."
        echo "============================================================"
        npx @timbreeding/jira-mcp-server@latest \
            --jira-base-url=https://your-domain.atlassian.net \
            --jira-username="$JIRA_MCP_LOGIN" \
            --jira-api-token="$JIRA_MCP_TOKEN"
        ;;
    "read")
        if [ -z "$2" ]; then
            echo "Usage: $0 read <ticket_id>"
            exit 1
        fi
        run_reader read "$2"
        ;;
    "search")
        if [ -z "$2" ]; then
            echo "Usage: $0 search \"<jql_query>\" [max_results]"
            exit 1
        fi
        run_reader search "$2" "$3"
        ;;
    "workload")
        run_reader workload "$2" "$3"
        ;;
    "comments")
        if [ -z "$2" ]; then
            echo "Usage: $0 comments <ticket_id>"
            exit 1
        fi
        run_reader comments "$2"
        ;;
    "help"|*)
        show_help
        ;;
esac
