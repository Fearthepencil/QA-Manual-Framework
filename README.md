# 🧪 Manual QA Framework

A comprehensive testing framework for modern QA teams with JIRA integration, standardized bug reporting, and test planning templates.

![Testing Framework](https://img.shields.io/badge/Testing-Framework-blue)
![JIRA Integration](https://img.shields.io/badge/JIRA-Integration-green)
![Bug Reports](https://img.shields.io/badge/Bug-Reports-orange)
![Test Plans](https://img.shields.io/badge/Test-Plans-purple)

## 🎯 Overview

**Manual QA Framework** provides:
- **Standardized bug reporting** with JIRA integration
- **Test planning templates** and execution guides
- **Project-specific testing** workflows
- **Quality metrics** and best practices

## 📁 Framework Structure

```
qa-manual-framework/
├── 01-jira-integration/          # JIRA setup, templates, examples
├── 02-bug-reports/               # Bug reporting system
├── 03-test-plans/                # Test planning and execution
├── 04-projects/                  # Project-specific testing
│   └── ownership-entity/         # Ownership Entity System (OES)
│       ├── project documentation/ # OES system documentation
│       └── project rules/        # OES testing guidelines
├── 05-utilities/                 # Testing tools and scripts
├── 06-documentation/             # Guides, standards, references
└── .cursor/                      # Cursor IDE configuration
```

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/Fearthepencil/QA-Manual-Framework.git
cd QA-Manual-Framework
```

### 2. Set Up JIRA Integration
Follow the [JIRA Environment Setup Guide](06-documentation/guides/jira_env_setup_guide.md)

### 3. Choose Your Workflow
- **Bug Reporting**: Use enhanced templates in `02-bug-reports/templates/`
- **Test Planning**: Start with enhanced templates in `03-test-plans/template/`
- **Project Testing**: Check `04-projects/ownership-entity/project rules/`
- **AI Assistant**: Use Igor for test case generation and QA guidance

### 4. Quick Start Guide
For detailed setup instructions, see the [Quick Start Guide](06-documentation/guides/quick_start_guide.md)

## 🖥️ Available Commands

The framework includes cross-platform command-line tools for JIRA integration and QA workflow automation.

### 📋 Show My Tickets

Display all JIRA tickets assigned to you as QA Assignee.

**Windows (PowerShell):**
```powershell
powershell -ExecutionPolicy Bypass -File "01-jira-integration/commands/show_my_tickets.ps1"
```

**Mac/Linux (Bash):**
```bash
bash "01-jira-integration/commands/show_my_tickets.sh"
```

**Features:**
- ✅ Cross-platform compatibility (Windows, Mac, Linux)
- ✅ Real-time JIRA API integration
- ✅ Color-coded status display
- ✅ Formatted table output
- ✅ Error handling and user feedback

**Output Example:**
```
Show My Tickets - QA Engineer Dashboard
================================================
Current User: Pavle Stefanovic (712020:016ad54d-5387-4067-b5c5-6bd187f523d2)
Found 26 tickets assigned to you as QA Assignee

===============================================================================================================
Ticket Key  | Summary                                                     | Status      | Priority    | Last Updated        
===============================================================================================================
AP-20715    | [BE] Buyer/Seller Fields Missing from Enterprise S...   | To Do       | Major       | 2025-08-25 15:27
AP-20344    | Missing Buyer and Seller Information in New Sales ...   | Ready for QA | Normal      | 2025-08-22 10:18
...
```

**Prerequisites:**
- JIRA API credentials configured
- Network access to JIRA instance
- PowerShell (Windows) or Bash (Mac/Linux)

**Troubleshooting:**
- **Authentication Error**: Verify your JIRA API token in the script
- **No Tickets Found**: Check if you're assigned as QA Assignee in JIRA
- **Permission Denied**: Ensure script execution is allowed on your system

### 🔧 Command Configuration

All commands use the same JIRA configuration:
- **JIRA URL**: `https://compstak.atlassian.net`
- **Authentication**: Basic Auth with email and API token
- **API Version**: JIRA REST API v3

### 📚 Command Documentation

For detailed command documentation and advanced usage:
- [JIRA Integration Guide](01-jira-integration/)
- [Command Configuration](01-jira-integration/config/)
- [Field Reference](01-jira-integration/config/jira_field_reference.md)

### 🚧 Upcoming Commands

The framework is actively being developed with additional commands:

**Planned Commands:**
- `show-ticket [KEY]` - Display detailed ticket information
- `update-status [KEY] [STATUS]` - Update ticket status
- `add-comment [KEY]` - Add comments to tickets
- `create-bug-report` - Generate standardized bug reports
- `test-plan-generator` - Create test plans from templates

**Contributing New Commands:**
See the [Contributing](#-contributing) section for guidelines on adding new commands to the framework.

## 🛠️ Key Features

### 🔗 JIRA Integration
- **Ticket Creation**: Automated bug report → JIRA ticket creation with MCP server
- **Ticket Reading**: Comprehensive ticket information extraction and JQL searching
- **Field Mapping**: Standardized formats for all JIRA project types
- **ADF Formatting**: Rich descriptions with environment tracking
- **QA Workload Management**: Track assignments and workload distribution
- **Enhanced Scripts**: Shell-based integration with JSON output

### 📊 Bug Reporting System
- Enhanced templates with environment context and traceability
- Quality metrics for reproducible reports
- Category organization (UI, API, Data, Performance)
- ISTQB-aligned structure with JIRA integration fields

### 📋 Test Planning
- Enhanced ISTQB-aligned templates with environment context
- Performance testing integration
- Comprehensive traceability matrix support
- AI-assisted test case generation

### 🤖 AI Assistant (Igor)
- AI-powered test case and bug report generation
- ISTQB knowledge base integration
- Environment-aware template usage
- Best practices enforcement and guidance

## 📚 Documentation

### 🎓 Guides
- [Quick Start Guide](06-documentation/guides/quick_start_guide.md)
- [JIRA Environment Setup](06-documentation/guides/jira_env_setup_guide.md)
- [Enhanced JIRA Integration](01-jira-integration/README.md)
- [Bug Report Quality Standards](02-bug-reports/templates/bug_metrics_reference.md)
- [Test Plan Creation](03-test-plans/template/test_plan_template.md)

### 📖 References
- [JIRA Field Reference](01-jira-integration/config/jira_field_reference.md)
- [Framework Rules](.cursor/rules/cursor_rules.mdc)
- [AI Assistant Rules](.cursor/rules/ai_assistant_rules.mdc)
- [ISTQB Knowledge Base](.cursor/Additional context/)

## 🔧 Configuration

Create a `.env` file in the project root:
```env
JIRA_MCP_LOGIN=your.email@compstak.com
JIRA_MCP_TOKEN=your_api_token_here
```

## 🤝 Contributing

### Branching and Pull Request Workflow

**All changes require Pull Request review:**

**1. Create Your Feature Branch**
```bash
git clone https://github.com/Fearthepencil/QA-Manual-Framework.git
cd QA-Manual-Framework
git checkout -b feature/your-feature-name
```

**2. Make Your Changes**
```bash
# Make changes, test locally
git add .
git commit -m "Add new bug report template for API testing"
```

**3. Push and Create Pull Request**
```bash
git push origin feature/your-feature-name
# Go to GitHub and create Pull Request
```

**4. Review Process**
- Repository owner reviews all Pull Requests
- Approval required before merge
- No direct pushes to main allowed

#### ✅ **Requirements**
- Clear title and description
- Testing completed
- Documentation updated if needed
- No sensitive data in commits

## 📈 Quality Standards

### Bug Report Quality
- Summary follows WHERE > WHAT > WHEN format
- Steps are exactly reproducible
- Expected vs Actual shows clear contrast

### Test Plan Quality
- ISTQB-aligned structure
- Clear scope and objectives
- Comprehensive test scenarios

## 🔒 Security

- Environment files excluded from version control
- API tokens stored securely in `.env` files
- Access controls maintained for all integrations

## 📞 Support

For questions or issues:
1. Check the [documentation](06-documentation/)
2. Create an issue using the framework's bug reporting system
3. Contact the maintainers for complex integrations

---

**Built with ❤️ for the testing community**

*Manual QA Framework - Where Quality Meets Efficiency*
