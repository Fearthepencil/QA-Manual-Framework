#!/bin/bash
# Show Ticket Details - QA Engineer Command
# Purpose: Show detailed information for a specific JIRA ticket
# Usage: ./show_ticket.sh AP-12345

# Check if ticket key is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <TICKET_KEY>"
    echo "Example: $0 AP-12345"
    exit 1
fi

TICKET_KEY=$1

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
    echo "Error: .env file not found at $ENV_FILE - Please create .env file in project root" >&2
    exit 1
fi

# Check if required credentials are available
if [ -z "$JIRA_MCP_LOGIN" ] || [ -z "$JIRA_MCP_TOKEN" ]; then
    echo "Error: JIRA credentials not available (check project root .env file)" >&2
    exit 1
fi

# Configuration
JIRA_URL="https://compstak.atlassian.net"

# Function to extract text from JSON using basic tools
get_json_value() {
    local json="$1"
    local key="$2"
    echo "$json" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    keys = '$key'.split('.')
    result = data
    for k in keys:
        if k.isdigit():
            result = result[int(k)]
        else:
            result = result.get(k, '')
    print(result if result is not None else '')
except:
    print('')
" 2>/dev/null || echo ""
}

# Function to extract text from ADF format
extract_adf_text() {
    local adf_content="$1"
    
    # Simple text extraction using Python
    echo "$adf_content" | python3 -c "
import json, sys
def extract_text(obj):
    if isinstance(obj, dict):
        if obj.get('type') == 'text':
            return obj.get('text', '')
        elif obj.get('type') == 'paragraph':
            content = obj.get('content', [])
            return ''.join(extract_text(item) for item in content) + '\\n'
        elif obj.get('type') == 'bulletList':
            content = obj.get('content', [])
            result = ''
            for item in content:
                if isinstance(item, dict) and item.get('content'):
                    result += '• ' + ''.join(extract_text(c) for c in item['content']) + '\\n'
            return result
        elif obj.get('type') == 'orderedList':
            content = obj.get('content', [])
            result = ''
            for i, item in enumerate(content, 1):
                if isinstance(item, dict) and item.get('content'):
                    result += str(i) + '. ' + ''.join(extract_text(c) for c in item['content']) + '\\n'
            return result
        elif obj.get('type') == 'codeBlock':
            lang = obj.get('attrs', {}).get('language', '')
            content = obj.get('content', [])
            code = ''.join(extract_text(item) for item in content)
            return '```' + lang + '\\n' + code + '\\n```\\n'
        elif obj.get('type') == 'heading':
            level = obj.get('attrs', {}).get('level', 1)
            content = obj.get('content', [])
            text = ''.join(extract_text(item) for item in content)
            return '#' * level + ' ' + text + '\\n'
        elif obj.get('content'):
            return ''.join(extract_text(item) for item in obj['content'])
    elif isinstance(obj, list):
        return ''.join(extract_text(item) for item in obj)
    elif isinstance(obj, str):
        return obj
    return ''

try:
    data = json.load(sys.stdin)
    print(extract_text(data))
except:
    print('')
" 2>/dev/null || echo "[Complex formatting - view in JIRA for full details]"
}

# Function to format date
format_date() {
    local date_str="$1"
    # Try to format the date, fallback to original if failed
    date -d "$date_str" "+%d/%m/%Y %H:%M" 2>/dev/null || echo "$date_str"
}

echo ""
echo -e "\033[36mShow Ticket Details - QA Engineer Dashboard\033[0m"
echo -e "\033[34m===========================================\033[0m"
echo ""

# Get current user info first
echo -e "\033[33mGetting user information...\033[0m"
USER_RESPONSE=$(curl -s -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
    -H "Content-Type: application/json" \
    "$JIRA_URL/rest/api/3/myself")

if [ $? -ne 0 ]; then
    echo -e "\033[31mError: Failed to authenticate with JIRA\033[0m" >&2
    exit 1
fi

CURRENT_USER=$(get_json_value "$USER_RESPONSE" "displayName")
CURRENT_USER_ID=$(get_json_value "$USER_RESPONSE" "accountId")
echo -e "\033[32mCurrent User: $CURRENT_USER ($CURRENT_USER_ID)\033[0m"
echo ""

# Get ticket details with expanded fields including comments
echo -e "\033[33mRetrieving details for ticket: $TICKET_KEY...\033[0m"
TICKET_RESPONSE=$(curl -s -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
    -H "Content-Type: application/json" \
    "$JIRA_URL/rest/api/3/issue/$TICKET_KEY?expand=renderedFields,comments")

if [ $? -ne 0 ]; then
    echo -e "\033[31mError: Failed to retrieve ticket details\033[0m" >&2
    exit 1
fi

# Check if ticket exists
ERROR_MSG=$(get_json_value "$TICKET_RESPONSE" "errorMessages.0")
if [ -n "$ERROR_MSG" ]; then
    echo -e "\033[31mError: $ERROR_MSG\033[0m" >&2
    exit 1
fi

echo -e "\033[32mTicket found!\033[0m"
echo ""

# Extract ticket information
SUMMARY=$(get_json_value "$TICKET_RESPONSE" "fields.summary")
STATUS=$(get_json_value "$TICKET_RESPONSE" "fields.status.name")
PRIORITY=$(get_json_value "$TICKET_RESPONSE" "fields.priority.name")
CREATED=$(get_json_value "$TICKET_RESPONSE" "fields.created")
UPDATED=$(get_json_value "$TICKET_RESPONSE" "fields.updated")
REPORTER=$(get_json_value "$TICKET_RESPONSE" "fields.reporter.displayName")
ASSIGNEE=$(get_json_value "$TICKET_RESPONSE" "fields.assignee.displayName")
ENVIRONMENT=$(get_json_value "$TICKET_RESPONSE" "fields.customfield_11332.value")
QA_ASSIGNEE=$(get_json_value "$TICKET_RESPONSE" "fields.customfield_11207.displayName")

# Get description as JSON for ADF parsing
DESCRIPTION=$(echo "$TICKET_RESPONSE" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    desc = data.get('fields', {}).get('description')
    if desc:
        json.dump(desc, sys.stdout)
    else:
        print('null')
except:
    print('null')
" 2>/dev/null)

# Format dates
CREATED_DATE=$(format_date "$CREATED")
UPDATED_DATE=$(format_date "$UPDATED")

# Display ticket details
echo -e "\033[34m===============================================================================================================\033[0m"
echo -e "\033[36mTICKET DETAILS\033[0m"
echo -e "\033[34m===============================================================================================================\033[0m"
echo ""
echo -e "\033[37mKey:           $TICKET_KEY\033[0m"
echo -e "\033[37mSummary:       $SUMMARY\033[0m"

# Color code status
case "$STATUS" in
    "Done")
        echo -e "\033[37mStatus:        \033[32m$STATUS\033[0m"
        ;;
    *"QA"*)
        echo -e "\033[37mStatus:        \033[33m$STATUS\033[0m"
        ;;
    *)
        echo -e "\033[37mStatus:        \033[37m$STATUS\033[0m"
        ;;
esac

# Color code priority
case "$PRIORITY" in
    "Critical")
        echo -e "\033[37mPriority:      \033[31m$PRIORITY\033[0m"
        ;;
    "Major")
        echo -e "\033[37mPriority:      \033[33m$PRIORITY\033[0m"
        ;;
    *)
        echo -e "\033[37mPriority:      \033[37m$PRIORITY\033[0m"
        ;;
esac

echo -e "\033[37mEnvironment:   $ENVIRONMENT\033[0m"
echo ""
echo -e "\033[37mReporter:      $REPORTER\033[0m"
echo -e "\033[37mAssignee:      $ASSIGNEE\033[0m"
echo -e "\033[37mQA Assignee:   $QA_ASSIGNEE\033[0m"
echo ""
echo -e "\033[37mCreated:       $CREATED_DATE\033[0m"
echo -e "\033[37mUpdated:       $UPDATED_DATE\033[0m"
echo ""
echo -e "\033[36mURL:           $JIRA_URL/browse/$TICKET_KEY\033[0m"
echo ""

# Display description if available
if [ "$DESCRIPTION" != "null" ] && [ -n "$DESCRIPTION" ]; then
    echo -e "\033[34m===============================================================================================================\033[0m"
    echo -e "\033[36mDESCRIPTION\033[0m"
    echo -e "\033[34m===============================================================================================================\033[0m"
    echo ""
    
    # Try to get rendered description first, then fall back to parsing ADF
    RENDERED_DESC=$(get_json_value "$TICKET_RESPONSE" "renderedFields.description")
    
    if [ "$RENDERED_DESC" != "null" ] && [ -n "$RENDERED_DESC" ]; then
        # Strip HTML tags and decode entities
        DESCRIPTION_TEXT=$(echo "$RENDERED_DESC" | sed 's/<[^>]*>//g' | sed 's/&nbsp;/ /g; s/&lt;/</g; s/&gt;/>/g; s/&amp;/\&/g')
        echo -e "\033[37m$DESCRIPTION_TEXT\033[0m"
    else
        # Parse ADF format
        DESCRIPTION_TEXT=$(extract_adf_text "$DESCRIPTION")
        if [ -n "$DESCRIPTION_TEXT" ] && [ "$DESCRIPTION_TEXT" != "null" ]; then
            echo -e "\033[37m$DESCRIPTION_TEXT\033[0m"
        else
            echo -e "\033[37m[Complex formatting - view in JIRA for full details]\033[0m"
        fi
    fi
    echo ""
fi

# Display comments if available
COMMENT_COUNT=$(echo "$TICKET_RESPONSE" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    comments = data.get('fields', {}).get('comment', {}).get('comments', [])
    print(len(comments))
except:
    print('0')
" 2>/dev/null)

if [ "$COMMENT_COUNT" -gt 0 ]; then
    echo -e "\033[34m===============================================================================================================\033[0m"
    echo -e "\033[36mCOMMENTS ($COMMENT_COUNT)\033[0m"
    echo -e "\033[34m===============================================================================================================\033[0m"
    echo ""
    
    # Extract comments using Python
    echo "$TICKET_RESPONSE" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    comments = data.get('fields', {}).get('comment', {}).get('comments', [])
    for i, comment in enumerate(comments, 1):
        author = comment.get('author', {}).get('displayName', 'Unknown')
        created = comment.get('created', 'N/A')
        updated = comment.get('updated', 'N/A')
        body = comment.get('body', {})
        
        print('COMMENT_NUM=' + str(i))
        print('COMMENT_AUTHOR=' + author)
        print('COMMENT_CREATED=' + created)
        print('COMMENT_UPDATED=' + updated)
        print('COMMENT_BODY_START')
        if body:
            json.dump(body, sys.stdout)
        else:
            print('null')
        print('\nCOMMENT_BODY_END')
        print('---')
except Exception as e:
    pass
" 2>/dev/null | while IFS= read -r line; do
        if [[ $line == COMMENT_NUM=* ]]; then
            COMMENT_NUM=${line#COMMENT_NUM=}
            echo -e "\033[33mComment #$COMMENT_NUM\033[0m"
        elif [[ $line == COMMENT_AUTHOR=* ]]; then
            COMMENT_AUTHOR=${line#COMMENT_AUTHOR=}
            echo -e "\033[37mAuthor: $COMMENT_AUTHOR\033[0m"
        elif [[ $line == COMMENT_CREATED=* ]]; then
            COMMENT_CREATED=${line#COMMENT_CREATED=}
            COMMENT_CREATED_DATE=$(format_date "$COMMENT_CREATED")
            echo -e "\033[37mCreated: $COMMENT_CREATED_DATE\033[0m"
        elif [[ $line == COMMENT_UPDATED=* ]]; then
            COMMENT_UPDATED=${line#COMMENT_UPDATED=}
            if [ "$COMMENT_UPDATED" != "$COMMENT_CREATED" ]; then
                COMMENT_UPDATED_DATE=$(format_date "$COMMENT_UPDATED")
                echo -e "\033[37mUpdated: $COMMENT_UPDATED_DATE\033[0m"
            fi
        elif [[ $line == "COMMENT_BODY_START" ]]; then
            echo -e "\033[90m---\033[0m"
            # Read the JSON body until COMMENT_BODY_END
            COMMENT_BODY=""
            while IFS= read -r body_line && [[ $body_line != "COMMENT_BODY_END" ]]; do
                COMMENT_BODY="$COMMENT_BODY$body_line"
            done
            
            if [ "$COMMENT_BODY" != "null" ] && [ -n "$COMMENT_BODY" ]; then
                COMMENT_TEXT=$(echo "$COMMENT_BODY" | extract_adf_text)
                if [ -n "$COMMENT_TEXT" ] && [ "$COMMENT_TEXT" != "null" ]; then
                    echo -e "\033[37m$COMMENT_TEXT\033[0m"
                else
                    echo -e "\033[90m[Complex formatting in comment - view in JIRA for full details]\033[0m"
                fi
            fi
            echo ""
        fi
    done
fi

echo -e "\033[34m===============================================================================================================\033[0m"
echo ""
echo -e "\033[33mTips:\033[0m"
echo -e "\033[90m  - Use 'jira update-status $TICKET_KEY [STATUS]' to update ticket status\033[0m"
echo -e "\033[90m  - Use 'jira add-comment $TICKET_KEY' to add comments to ticket\033[0m"
echo -e "\033[90m  - View full details at: $JIRA_URL/browse/$TICKET_KEY\033[0m"
echo ""
echo -e "\033[32mCommand completed successfully!\033[0m"
