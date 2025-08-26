# Enhanced JIRA Integration

This module provides comprehensive JIRA integration capabilities for the Manual QA Framework, combining ticket creation and reading functionality.

## 🚀 Features

### **Ticket Creation** (MCP Server)
- Automated bug report → JIRA ticket creation
- Standardized field mapping for all project types
- ADF formatting support for rich descriptions
- Environment tracking (dev/staging/production)

### **Ticket Reading** (Enhanced Scripts)
- Comprehensive ticket information extraction
- JQL-based ticket searching
- QA workload management
- Comment retrieval and analysis
- Timeline and metadata extraction

## 📁 Structure

```
01-jira-integration/
├── config/
│   ├── jira-mcp-wrapper.sh          # Original MCP server wrapper
│   ├── jira-mcp-enhanced.sh         # Enhanced wrapper with reading capabilities
│   ├── jira_field_reference.md      # Field mapping documentation
│   └── jira_templates.yaml          # Template configurations
├── scripts/
│   └── jira_ticket_reader.sh        # Comprehensive ticket reading script
└── README.md                        # This documentation
```

## ⚙️ Setup

### 1. Environment Configuration

Create a `.env` file in your project root:

```bash
JIRA_MCP_LOGIN=your-email@company.com
JIRA_MCP_TOKEN=your-api-token
```

### 2. Dependencies

Ensure you have the following tools installed:
- `curl` - For API requests
- `jq` - For JSON parsing
- `npx` - For MCP server

## 🛠️ Usage

### **Enhanced MCP Wrapper**

The enhanced wrapper provides both creation and reading capabilities:

```bash
# Start MCP server for ticket creation
./01-jira-integration/config/jira-mcp-enhanced.sh server

# Read comprehensive ticket information
./01-jira-integration/config/jira-mcp-enhanced.sh read AP-20641

# Search tickets using JQL
./01-jira-integration/config/jira-mcp-enhanced.sh search "project = AP AND status = 'In Progress'"

# Get QA workload
./01-jira-integration/config/jira-mcp-enhanced.sh workload "To Do" AP

# Get ticket comments
./01-jira-integration/config/jira-mcp-enhanced.sh comments AP-20641
```

### **Direct Script Usage**

You can also use the ticket reader script directly:

```bash
# Read ticket information
./01-jira-integration/scripts/jira_ticket_reader.sh read AP-20641

# Search with custom JQL
./01-jira-integration/scripts/jira_ticket_reader.sh search "assignee = currentUser() AND status != 'Done'" 20

# Get workload with filters
./01-jira-integration/scripts/jira_ticket_reader.sh workload "In Progress" AP
```

## 📊 Output Formats

### **Ticket Information**

The reading scripts output structured JSON data:

```json
{
  "basic_info": {
    "key": "AP-20641",
    "summary": "Bug description",
    "status": "In Progress",
    "issue_type": "Bug",
    "priority": "High",
    "labels": ["frontend", "ui"],
    "components": ["User Interface"],
    "project": "AP"
  },
  "people_info": {
    "assignee": {
      "name": "John Doe",
      "email": "john@company.com",
      "account_id": "12345"
    },
    "reporter": {
      "name": "Jane Smith",
      "email": "jane@company.com",
      "account_id": "67890"
    }
  },
  "timeline": {
    "created": "2024-01-15T10:30:00.000Z",
    "updated": "2024-01-16T14:20:00.000Z",
    "resolution_date": null,
    "due_date": "2024-01-20T00:00:00.000Z"
  }
}
```

### **Search Results**

Search operations return arrays of ticket summaries:

```json
[
  {
    "key": "AP-20641",
    "summary": "Bug description",
    "status": "In Progress",
    "assignee": "John Doe",
    "reporter": "Jane Smith",
    "created": "2024-01-15T10:30:00.000Z",
    "updated": "2024-01-16T14:20:00.000Z"
  }
]
```

## 🔍 JQL Examples

### **Common Search Patterns**

```bash
# My assigned tickets
"assignee = currentUser()"

# High priority bugs
"priority = High AND issuetype = Bug"

# Recent tickets
"created >= -7d"

# Tickets in specific project
"project = AP"

# Tickets with specific labels
"labels in (frontend, ui)"

# Complex queries
"project = AP AND status in ('To Do', 'In Progress') AND assignee = currentUser()"
```

### **QA-Specific Queries**

```bash
# My QA workload
"assignee = currentUser() AND status != 'Done'"

# Bugs I need to test
"issuetype = Bug AND status = 'Ready for QA'"

# Recent bug reports
"issuetype = Bug AND created >= -3d ORDER BY created DESC"
```

## 🔧 Integration with Framework

### **Bug Report Enhancement**

The enhanced templates include JIRA integration fields:

```markdown
## 8. JIRA Integration
**Project**: [AP/DEV/OTHER]
**Issue Type**: [Bug/Story/Task]
**Priority**: [Highest/High/Medium/Low/Lowest]
**Components**: [Relevant component IDs]
**Labels**: [Relevant labels for categorization]
```

### **Test Case Traceability**

Test cases can be linked to JIRA tickets:

```markdown
## 7. Traceability
**Related JIRA Tickets**: [AP-20641, AP-20642]
**Requirements**: [REQ-001, REQ-002]
**Test Execution**: [Manual/Automated]
```

## 📈 Workflow Integration

### **Daily QA Workflow**

1. **Check Workload**: `./jira-mcp-enhanced.sh workload`
2. **Review Assigned Tickets**: `./jira-mcp-enhanced.sh search "assignee = currentUser() AND status != 'Done'"`
3. **Create Bug Reports**: Use enhanced templates with JIRA fields
4. **Track Progress**: Monitor ticket status and comments

### **Bug Report Workflow**

1. **Create Bug Report**: Use enhanced template
2. **Submit to JIRA**: Use MCP server integration
3. **Track Progress**: Monitor ticket updates
4. **Verify Resolution**: Read ticket details and comments

## 🚨 Troubleshooting

### **Common Issues**

1. **Authentication Errors**
   - Verify `.env` file exists and credentials are correct
   - Check API token permissions

2. **Script Not Found**
   - Ensure scripts are executable: `chmod +x *.sh`
   - Verify script paths in enhanced wrapper

3. **JSON Parsing Errors**
   - Install `jq`: `brew install jq` (macOS) or `apt-get install jq` (Ubuntu)
   - Check JIRA API response format

### **Debug Mode**

Enable debug output by setting environment variable:

```bash
export DEBUG=1
./01-jira-integration/config/jira-mcp-enhanced.sh read AP-20641
```

## 🔄 Migration from Original

### **Backward Compatibility**

The original MCP wrapper is still available:

```bash
# Original functionality
./01-jira-integration/config/jira-mcp-wrapper.sh

# Enhanced functionality
./01-jira-integration/config/jira-mcp-enhanced.sh server
```

### **Upgrade Path**

1. **Keep existing workflows**: Original MCP server still works
2. **Add reading capabilities**: Use enhanced wrapper for new features
3. **Gradual migration**: Move to enhanced templates and scripts
4. **Full integration**: Use comprehensive workflow with both capabilities

## 📚 Related Documentation

- [JIRA Field Reference](config/jira_field_reference.md)
- [Bug Report Templates](../../02-bug-reports/templates/)
- [Test Case Templates](../../03-test-plans/template/)
- [Quick Start Guide](../../06-documentation/guides/quick_start_guide.md)

---

*Enhanced JIRA Integration - Where Creation Meets Intelligence*
