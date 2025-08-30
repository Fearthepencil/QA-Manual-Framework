# JIRA Environment Setup Quick Guide

## 🚀 Quick Setup for JIRA Integration

### Prerequisites
- JIRA account with API access
- API token generated from Atlassian
- Access to the target JIRA project

---

## 📝 Step 1: Generate JIRA API Token

1. **Go to Atlassian Account Settings**
   - Visit: https://id.atlassian.com/manage-profile/security/api-tokens
   - Sign in with your JIRA account

2. **Create New API Token**
   - Click "Create API token"
   - Give it a descriptive name: `JIRA_MCP_Integration`
   - Copy the generated token (you won't see it again!)

---

## 📁 Step 2: Create Environment File

### **Important**: Create `.env` file in the project root

**File Structure:**
```
QA-Manual-Framework/
├── .env  ← Place your .env file here (project root)
├── 01-jira-integration/
│   ├── commands/
│   └── scripts/
└── ...
```

### **Step-by-Step Setup:**

1. **Navigate to the correct directory:**
   ```bash
   cd 01-jira-integration/config/
   ```

2. **Create the .env file in project root:**
   ```bash
   # Windows (PowerShell)
   New-Item -Path ".env" -ItemType File
   
   # Mac/Linux (Bash)
   touch .env
   ```

3. **Add your credentials to the .env file:**
   ```env
   # JIRA MCP Integration Credentials
   JIRA_MCP_LOGIN=your.email@your-domain.com
   JIRA_MCP_TOKEN=your_api_token_here
   ```

### **Example .env file content:**
```env
JIRA_MCP_LOGIN=your.email@your-domain.com
JIRA_MCP_TOKEN=your_api_token_here
```

**Note**: All scripts are configured to look for the .env file in the project root directory. Placing it anywhere else will cause the scripts to fail.

---

## ⚙️ Step 3: Configure MCP Integration

### Update `.cursor/mcp.json`:
```json
{
  "mcpServers": {
    "jira": {
      "command": "C:\\Program Files\\Git\\bin\\bash.exe",
      "args": ["./jira-mcp-wrapper.sh"],
      "cwd": "C:\\Users\\user\\cursor\\QA-Manual-Framework"
    }
  }
}
```

### Verify wrapper script exists:
- Check: `01-jira-integration/config/jira-mcp-wrapper.sh`
- Ensure it has execute permissions

---

## 🔧 Step 4: Test Configuration

### Test JIRA Connection:
```bash
# Test basic connectivity
curl -u "your.email@your-domain.com:your_api_token" \
  https://your-domain.atlassian.net/rest/api/3/myself
```

### Test MCP Server:
- Restart Cursor
- Check if JIRA MCP appears in available tools
- Try listing JIRA projects

---

## 🛡️ Security Best Practices

### ✅ Do's:
- Store `.env` file in project root directory
- Use descriptive token names
- Rotate tokens regularly
- Add `.env` to `.gitignore`

### ❌ Don'ts:
- Never commit `.env` to version control
- Don't share API tokens
- Don't use personal access tokens for production
- Don't hardcode credentials in scripts

---

## 🔍 Troubleshooting

### Common Issues:

**"401 Unauthorized"**
- Check email/token combination
- Verify token hasn't expired
- Ensure account has API access

**"MCP Server Not Found"**
- Verify `jira-mcp-wrapper.sh` exists
- Check file permissions
- Restart Cursor after config changes

**"Token Split Across Lines"**
- Ensure token is on single line in project root `.env`
- No line breaks or spaces in token

---

## 📋 Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| `JIRA_MCP_LOGIN` | Your JIRA email | `user@your-domain.com` |
| `JIRA_MCP_TOKEN` | API token | `your_api_token_here` |

---

## 🗂️ Step 4: Project Task Tracking Setup

### **Important**: Separate Task Tracking for Clean Projects

When using this framework in a new project:

```bash
# Copy the template to create local task tracking
cp .cursor/rules/task_tracking_template.mdc .cursor/rules/task_tracking.mdc
# Edit the new file to add your project details
```

### **Key Points:**
- ✅ **Framework rules** stay in `.cursor/rules/cursor_rules.mdc` (version controlled)
- ✅ **Current tasks** go in `.cursor/rules/task_tracking.mdc` (local, gitignored)  
- ✅ **Each project** gets its own task tracking file
- ✅ **No contamination** of the framework repository with project-specific tasks

### **What Goes Where:**
- **cursor_rules.mdc**: Framework rules, guidelines, standards (version controlled)
- **task_tracking.mdc**: Current work, project status, active tasks (local only)

---

## 🎯 Quick Commands

### Create .env file:
```bash
echo "JIRA_MCP_LOGIN=your.email@your-domain.com" > .env
echo "JIRA_MCP_TOKEN=your_token_here" >> .env
```

### Test connection:
```bash
source .env
curl -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
  https://your-domain.atlassian.net/rest/api/3/myself
```

### Test JIRA commands:
```bash
# Show your assigned tickets
powershell -File 01-jira-integration/commands/show_my_tickets.ps1
bash 01-jira-integration/commands/show_my_tickets.sh

# Show detailed ticket information
powershell -File 01-jira-integration/commands/show_ticket.ps1 -TicketKey "YOUR_PROJECT-12345"
bash 01-jira-integration/commands/show_ticket.sh YOUR_PROJECT-12345
```

---

## 📚 Related Documentation

- **Field Reference**: `01-jira-integration/config/jira_field_reference.md`
- **Bug Metrics**: `02-bug-reports/templates/bug_metrics_reference.md`
- **JIRA Rules**: `.cursor/rules/jira_creation_rules.mdc`

---

## 🆘 Need Help?

1. Check the troubleshooting section above
2. Verify all prerequisites are met
3. Test with curl command first
4. Check JIRA project permissions
5. Contact team lead for API access issues
