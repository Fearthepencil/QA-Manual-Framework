# Manual QA Framework - Quick Start Guide

**Welcome to the Manual QA Framework!** This guide will help you set up the framework and start using it for your QA work in just a few minutes.

---

## 🚀 **Prerequisites**

Before you start, make sure you have:

- **Git** installed for cloning the repository
- **A Jira account** with API access (for Jira integration features)
- **Basic familiarity with command line/terminal**
- **Cursor IDE** (recommended for AI assistant features)

---

## 📥 **Step 1: Clone the Repository**

Open your terminal and run:

```bash
git clone https://github.com/Fearthepencil/QA-Manual-Framework.git
cd QA-Manual-Framework
```

---

## ⚙️ **Step 2: Configure Jira Integration**

### **2.1: Get Your Jira API Token**

1. Go to [Atlassian Account Settings](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Click **"Create API token"**
3. Give it a name (e.g., "Manual QA Framework")
4. Copy the generated token (you'll need it in the next step)

### **2.2: Create Environment File**

Create a `.env` file in the project root:

```bash
# Create the .env file
touch .env
```

### **2.3: Add Your Jira Credentials**

Open the `.env` file and add your Jira credentials:

```env
JIRA_MCP_LOGIN=your-email@compstak.com
JIRA_MCP_TOKEN=your-api-token-here
```

**Replace with your actual values:**
- `your-email@compstak.com` → Your CompStak Jira email address
- `your-api-token-here` → The API token you created in step 2.1

---

## 🎯 **Step 3: Choose Your Workflow**

### **Option A: Bug Reporting**
1. Use templates in `02-bug-reports/templates/`
2. Follow the [Bug Report Quick Guide](02-bug-reports/templates/bug_report_quick_guide.md)
3. Use enhanced template: `bug_report_template_enhanced.md`

### **Option B: Test Planning**
1. Start with `03-test-plans/template/test_plan_template.md`
2. Use enhanced test case template: `test_case_template_enhanced.md`
3. Follow ISTQB standards for comprehensive test planning

### **Option C: Project Testing**
1. Check `04-projects/` for project-specific testing
2. Use traceability matrix: `05-utilities/traceability_matrix_template_enhanced.md`
3. Follow project-specific rules and documentation

---

## 🤖 **Step 4: Using the AI Assistant**

### **With Cursor IDE (Recommended)**
1. Open the project in Cursor IDE
2. The AI assistant (Igor) will automatically be available
3. Ask for help with:
   - Test case generation
   - Bug report writing
   - QA best practices
   - ISTQB guidance

### **Example AI Interactions**
```
"Generate test cases for user login functionality"
"Write a bug report for a broken search feature"
"Help me create a test plan for the new API"
"What are the ISTQB best practices for test case design?"
```

---

## 📁 **Step 5: Project Structure Overview**

```
QA-Manual-Framework/
├── 01-jira-integration/          # JIRA setup, templates, examples
├── 02-bug-reports/               # Bug reporting system
├── 03-test-plans/                # Test planning and execution
├── 04-projects/                  # Project-specific testing
├── 05-utilities/                 # Testing tools and scripts
├── 06-documentation/             # Guides, standards, references
└── .cursor/                      # AI assistant configuration
```

---

## 🔧 **Step 6: JIRA Integration Setup**

### **Test JIRA Connection**
```bash
# Run the JIRA MCP wrapper
./01-jira-integration/config/jira-mcp-wrapper.sh
```

### **Create Your First Bug Report**
1. Use the enhanced bug report template
2. Fill in all required fields
3. Copy to JIRA using the field mapping guide
4. Submit via JIRA MCP integration

---

## 📚 **Step 7: Documentation & Resources**

### **Essential Guides**
- [JIRA Environment Setup](06-documentation/guides/jira_env_setup_guide.md)
- [Bug Report Quality Standards](02-bug-reports/templates/bug_metrics_reference.md)
- [Test Plan Creation](03-test-plans/template/test_plan_template.md)

### **Reference Materials**
- [JIRA Field Reference](01-jira-integration/config/jira_field_reference.md)
- [Framework Rules](.cursor/rules/cursor_rules.mdc)
- [AI Assistant Rules](.cursor/rules/ai_assistant_rules.mdc)

### **ISTQB Knowledge Base**
- Foundation Level (v4.0.1) - `.cursor/Additional context/pdfs/`
- Advanced Test Analyst (v4.0) - `.cursor/Additional context/pdfs/`

---

## 🚀 **Step 8: Quick Commands**

### **JIRA Integration**
```bash
# Test JIRA connection
./01-jira-integration/config/jira-mcp-wrapper.sh

# View JIRA field reference
cat 01-jira-integration/config/jira_field_reference.md
```

### **Template Usage**
```bash
# View enhanced bug report template
cat 02-bug-reports/templates/bug_report_template_enhanced.md

# View enhanced test case template
cat 03-test-plans/template/test_case_template_enhanced.md

# View traceability matrix template
cat 05-utilities/traceability_matrix_template_enhanced.md
```

---

## 🎯 **Next Steps**

1. **Explore Templates**: Review all enhanced templates
2. **Practice with AI**: Try asking the AI assistant for help
3. **Set Up Project**: Create your first project in `04-projects/`
4. **Learn ISTQB**: Review the knowledge base in `.cursor/Additional context/`
5. **Join the Community**: Contribute to the framework development

---

## 🆘 **Need Help?**

- **Check Documentation**: Review guides in `06-documentation/`
- **Use AI Assistant**: Ask Igor for help with any QA tasks
- **Review Examples**: Look at demo files in `03-test-plans/demo/`
- **Follow Standards**: Use ISTQB knowledge for best practices

---

**Happy Testing! 🧪**

*The Manual QA Framework - Where Quality Meets Efficiency*
