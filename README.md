# 🧪 Manual QA Framework

A comprehensive testing framework for QA teams with JIRA integration, standardized bug reporting, and test planning templates aligned with company standards.

![Testing Framework](https://img.shields.io/badge/Testing-Framework-blue)
![JIRA Integration](https://img.shields.io/badge/JIRA-Integration-green)
![Bug Reports](https://img.shields.io/badge/Bug-Reports-orange)
![Test Plans](https://img.shields.io/badge/Test-Plans-purple)

## 🎯 Overview

**Manual QA Framework** provides company-standardized:
- **Bug reporting templates** with Confluence alignment and JIRA integration
- **Test planning workflows** and execution guides
- **Project-specific testing** documentation and rules
- **Quality metrics** and best practices for consistent QA processes

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
git clone https://github.com/compstak/QA-Manual-Framework.git
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

### 5. JIRA Workflow
For JIRA status definitions and workflow processes, see the [JIRA Workflow Guide](06-documentation/guides/jira_workflow_guide.md)

## 🖥️ Available Commands

The framework includes cross-platform command-line tools for JIRA integration and QA workflow automation.

### 📋 Show My Tickets

Display all JIRA tickets assigned to you as QA Assignee (regardless of status).

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

**Prerequisites:**
- JIRA API credentials configured in `.env` file (see Configuration section)
- Network access to JIRA instance
- PowerShell (Windows) or Bash (Mac/Linux)

**Security Note:** Credentials are now loaded from `.env` file instead of being hardcoded in scripts.

### 🚀 Show Deployment Tickets

Display tickets assigned to you as QA Assignee that are ready for deployment (status "To Deploy").

**Windows (PowerShell):**
```powershell
powershell -ExecutionPolicy Bypass -File "01-jira-integration/commands/show_deployment_tickets.ps1"
```

**Mac/Linux (Bash):**
```bash
bash "01-jira-integration/commands/show_deployment_tickets.sh"
```

**Features:**
- ✅ Shows only tickets with "To Deploy" status
- ✅ Cross-platform compatibility (Windows, Mac, Linux)
- ✅ Real-time JIRA API integration
- ✅ Deployment-specific information and guidance
- ✅ Formatted table output with deployment context

**Use Case:** Identify tickets that have been tested on development environment and are ready to be deployed to staging environment.

### 🎯 Show Ready for QA Tickets

Display tickets assigned to you as QA Assignee that are ready for QA testing (status "Ready for QA").

**Windows (PowerShell):**
```powershell
powershell -ExecutionPolicy Bypass -File "01-jira-integration/commands/show_ready_for_qa_tickets.ps1"
```

**Mac/Linux (Bash):**
```bash
bash "01-jira-integration/commands/show_ready_for_qa_tickets.sh"
```

**Features:**
- ✅ Shows only tickets with "Ready for QA" status
- ✅ Cross-platform compatibility (Windows, Mac, Linux)
- ✅ Real-time JIRA API integration
- ✅ QA testing workflow guidance
- ✅ Formatted table output with next steps

**Use Case:** Identify tickets that have completed development and peer review and are ready for you to begin QA testing.

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
- [Deployment Rules](06-documentation/guides/deployment_rules.md)

### 🚧 Additional Commands

Additional commands available:
- Enhanced JIRA MCP server integration
- Ticket creation and management tools
- Bug report generation utilities

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
- Project-specific test plans and rules

### 🤖 AI Assistant (Igor)
- AI-powered test case and bug report generation
- ISTQB knowledge base integration
- Environment-aware template usage
- Best practices enforcement and guidance

## 📚 Documentation

### 🎓 Guides
- [Quick Start Guide](06-documentation/guides/quick_start_guide.md)
- [JIRA Environment Setup](06-documentation/guides/jira_env_setup_guide.md)
- [JIRA Integration Scripts](01-jira-integration/scripts/)
- [Bug Report Quality Standards](02-bug-reports/templates/bug_metrics_reference.md)
- [Test Plan Creation](03-test-plans/template/test_plan_template.md)

### 📖 References
- [JIRA Field Reference](01-jira-integration/config/jira_field_reference.md)
- [Framework Rules](.cursor/rules/cursor_rules.mdc)
- [AI Assistant Rules](.cursor/rules/ai_assistant_rules.mdc)
- [ISTQB Knowledge Base](.cursor/Additional context/)

### 🏗️ Projects
- [Folders Project](04-projects/folders/) - Folder management functionality (Phase 1)
- [Ownership Entity](04-projects/ownership-entity/) - OES system documentation

## 🔧 Configuration

### **Environment File Setup**

**Important**: Create your `.env` file in the exact location shown below for the scripts to work properly.

#### **File Location:**
```
QA-Manual-Framework/
├── 01-jira-integration/
│   ├── config/
│   │   └── .env  ← Place your .env file here
│   ├── commands/
│   └── scripts/
└── ...
```

#### **Step-by-Step Setup:**

1. **Navigate to the config folder:**
   ```bash
   cd 01-jira-integration/config/
   ```

2. **Create the .env file:**
   ```bash
   # Windows (PowerShell)
   New-Item -Path ".env" -ItemType File
   
   # Mac/Linux (Bash)
   touch .env
   ```

3. **Add your JIRA credentials to the .env file:**
   ```env
   JIRA_MCP_LOGIN=your.email@compstak.com
   JIRA_MCP_TOKEN=your_api_token_here
   ```

#### **Example .env file content:**
```env
JIRA_MCP_LOGIN=pavle.stefanovic@compstak.com
JIRA_MCP_TOKEN=your_actual_api_token_here
```

**Security Features:**
- All scripts automatically load credentials from `.env` file
- No hardcoded credentials in any scripts
- Environment file excluded from version control
- Proper error handling for missing credentials

## 🤝 Contributing

### Branching Strategy

**Branch Structure:**
- **`main`**: Production-ready code, stable releases
- **`develop`**: Development branch for active work and testing
- **`feature/*`**: Feature branches for specific development tasks

### Development Workflow

**For Active Development:**
```bash
# Clone and set up
git clone https://github.com/compstak/QA-Manual-Framework.git
cd QA-Manual-Framework

# Switch to develop branch for active work
git checkout develop
git pull origin develop

# Create feature branch for specific work
git checkout -b feature/your-feature-name
```

**For Feature Development:**
```bash
# Create feature branch from develop
git checkout develop
git pull origin develop
git checkout -b feature/your-feature-name

# Make changes, test locally
git add .
git commit -m "Add new feature or enhancement"

# Push feature branch
git push origin feature/your-feature-name
```

**For Direct Development (Maintainers):**
```bash
# Work directly on develop branch
git checkout develop
git pull origin develop

# Make changes and push
git add .
git commit -m "Development update"
git push origin develop
```

### Pull Request Process

**1. Create Pull Request**
- Feature branches → develop (for new features)
- Develop → main (for releases)

**2. Review Process**
- Repository maintainers review all Pull Requests
- Approval required before merge
- No direct pushes to main allowed

**3. Maintainers**
- **Pavle Stefanovic**: Primary maintainer
- **Ogi**: Development collaborator (can push to develop branch)

**4. Branch Protection Rules**
- **Main Branch**: Protected - No direct pushes allowed, Pull Request required
- **Develop Branch**: Protected - No direct pushes allowed, Pull Request required
- **Feature Branches**: Unprotected - Direct pushes allowed for development
- **Review Required**: All Pull Requests require maintainer approval
- **Status Checks**: Must pass before merge (when implemented)

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
