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

### Create `.env` file in project root:
```bash
# Create .env file (if it doesn't exist)
touch .env
```

### Add your credentials:
```env
# JIRA MCP Integration Credentials
JIRA_MCP_LOGIN=your.email@compstak.com
JIRA_MCP_TOKEN=ATATT3xFfGF0...your_long_token_here
```

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
curl -u "your.email@compstak.com:your_api_token" \
  https://compstak.atlassian.net/rest/api/3/myself
```

### Test MCP Server:
- Restart Cursor
- Check if JIRA MCP appears in available tools
- Try listing JIRA projects

---

## 🛡️ Security Best Practices

### ✅ Do's:
- Store `.env` file in project root
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
- Ensure token is on single line in `.env`
- No line breaks or spaces in token

---

## 📋 Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| `JIRA_MCP_LOGIN` | Your JIRA email | `user@compstak.com` |
| `JIRA_MCP_TOKEN` | API token | `ATATT3xFfGF0...` |

---

## 🎯 Quick Commands

### Create .env file:
```bash
echo "JIRA_MCP_LOGIN=your.email@compstak.com" > .env
echo "JIRA_MCP_TOKEN=your_token_here" >> .env
```

### Test connection:
```bash
source .env
curl -u "$JIRA_MCP_LOGIN:$JIRA_MCP_TOKEN" \
  https://compstak.atlassian.net/rest/api/3/myself
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
