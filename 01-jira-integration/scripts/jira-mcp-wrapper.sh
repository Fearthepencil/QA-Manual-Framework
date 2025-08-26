#!/bin/bash

# Jira MCP Server Wrapper
# Loads credentials from .env file

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Find project root by looking for .env file (should be in project using qa_core)
PROJECT_ROOT="$(cd "$SCRIPT_DIR" && while [[ "$PWD" != "/" && ! -f ".env" ]]; do cd ..; done && pwd)"
ENV_FILE="$PROJECT_ROOT/.env"

# Load .env file if it exists
if [ -f "$ENV_FILE" ]; then
    echo "Loading environment from $ENV_FILE" >&2
    # Load only specific variables we need to avoid JSON parsing issues
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

# Run the Jira MCP server with credentials
npx @timbreeding/jira-mcp-server@latest \
    --jira-base-url=https://compstak.atlassian.net \
    --jira-username="$JIRA_MCP_LOGIN" \
    --jira-api-token="$JIRA_MCP_TOKEN"
