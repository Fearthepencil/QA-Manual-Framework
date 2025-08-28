# 🧪 Manual QA Framework

A comprehensive testing framework for internal company QA teams with complete JIRA integration, AI-powered comment generation, and standardized bug reporting aligned with company standards.

![Testing Framework](https://img.shields.io/badge/Testing-Framework-blue)
![JIRA Integration](https://img.shields.io/badge/JIRA-Integration-green)
![AI Comments](https://img.shields.io/badge/AI-Comments-purple)
![Cross Platform](https://img.shields.io/badge/Cross-Platform-orange)

## 🎯 Overview

**Manual QA Framework** provides company-standardized:
- **🎫 Complete JIRA Integration** with cross-platform commands (PowerShell & Bash)
- **🤖 AI-Generated Comments** with perfect JSON formatting and code blocks
- **🐛 Comprehensive Bug Reporting** with proper ADF structure and company compliance
- **📋 Test Planning Workflows** and execution guides
- **📊 Quality Metrics** and traceability matrices

## 📁 Current Framework Structure

```
QA-Manual-Framework/
├── 01-jira-integration/              # JIRA commands and configuration
│   ├── commands/                     # ✅ WORKING SCRIPTS ONLY
│   │   ├── create_ticket.ps1         # Bug ticket creation (PowerShell)
│   │   ├── create_ticket.sh          # Bug ticket creation (Bash)
│   │   ├── generate_and_post_comment.ps1  # AI comment posting (PowerShell)
│   │   ├── generate_and_post_comment.sh   # AI comment posting (Bash)
│   │   ├── show_my_tickets.ps1       # Show QA assigned tickets (PowerShell)
│   │   ├── show_my_tickets.sh        # Show QA assigned tickets (Bash)
│   │   ├── show_deployment_tickets.ps1    # Show deployment tickets (PowerShell)
│   │   ├── show_deployment_tickets.sh     # Show deployment tickets (Bash)
│   │   ├── show_ready_for_qa_tickets.ps1  # Show ready for QA (PowerShell)
│   │   ├── show_ready_for_qa_tickets.sh   # Show ready for QA (Bash)
│   │   ├── show_ticket.ps1           # Show detailed ticket info (PowerShell)
│   │   └── show_ticket.sh            # Show detailed ticket info (Bash)
│   ├── config/                       # JIRA configuration
│   │   ├── (moved to project root)   # .env file location changed
│   │   └── jira_field_reference.md   # JIRA field mappings and ADF guide
│   └── scripts/                      # Additional automation scripts
├── 02-bug-reports/                   # Bug reporting templates and examples
│   ├── templates/                    # Bug report templates
│   │   ├── bug_metrics_reference.md  # Company standards and validation
│   │   ├── bug_report_template.md    # Enhanced bug report template
│   │   └── jira-ap-bug-metadata.json # JIRA field configurations
│   └── reports/                      # Example bug reports (gitignored)
├── 03-test-plans/                    # Test planning templates
│   ├── template/                     # Test plan templates
│   └── demo/                         # Example test plans
├── 04-projects/                      # Project-specific testing (mostly gitignored)
│   ├── ownership-entity/             # OES project testing
│   │   ├── project documentation/    # ✅ ONLY FOLDER PUSHED TO GIT
│   │   └── project rules/            # Project testing guidelines
│   └── folders/                      # General project template
├── 05-utilities/                     # Testing utilities and matrices
├── 06-documentation/                 # Framework guides and standards
│   ├── guides/                       # User guides
│   │   ├── jira_env_setup_guide.md   # JIRA setup instructions
│   │   ├── jira_workflow_guide.md    # JIRA workflow documentation
│   │   └── quick_start_guide.md      # Quick start guide
│   └── standards/                    # Framework standards
│       ├── atlassian_adf_reference.md # ADF formatting reference
│       └── framework_organization_plan.md # Framework structure
└── .cursor/                          # Cursor IDE configuration
    └── rules/                        # AI assistant rules and tracking
```

## 🚀 Quick Start

### 1. Clone and Setup
```bash
git clone https://github.com/compstak/QA-Manual-Framework.git
cd QA-Manual-Framework
```

### 2. JIRA Integration Setup
1. Copy your JIRA credentials to `.env` in project root
2. Follow [JIRA Environment Setup Guide](06-documentation/guides/jira_env_setup_guide.md)
3. Test with: `powershell -File 01-jira-integration/commands/show_my_tickets.ps1`

### 3. Project Task Tracking Setup
**⚠️ IMPORTANT**: This framework uses separate task tracking for clean project management:

```bash
# For new projects, copy the template to create local task tracking
cp .cursor/rules/task_tracking_template.mdc .cursor/rules/task_tracking.mdc
# Edit the new file to add your project details
```

**Key Points:**
- ✅ **Framework rules** stay in `.cursor/rules/cursor_rules.mdc` (version controlled)
- ✅ **Current tasks** go in `.cursor/rules/task_tracking.mdc` (local, gitignored)
- ✅ **Each project** gets its own task tracking file
- ✅ **No task contamination** in the framework repository

### 4. Available Commands

#### 🎫 **Ticket Creation**
```bash
# PowerShell (Windows)
powershell -File 01-jira-integration/commands/create_ticket.ps1 "[Bug Title]" "Bug description" "Environment"

# Bash (Linux/Mac)
bash 01-jira-integration/commands/create_ticket.sh "[Bug Title]" "Bug description" "Environment"
```

#### 🤖 **AI-Generated Comments** 
```bash
# PowerShell
powershell -File 01-jira-integration/commands/generate_and_post_comment.ps1 "TICKET-KEY" "comment.json"

# Bash  
bash 01-jira-integration/commands/generate_and_post_comment.sh "TICKET-KEY" "comment.json"
```

#### 📋 **Ticket Queries**
```bash
# Show my QA assigned tickets
powershell -File 01-jira-integration/commands/show_my_tickets.ps1
bash 01-jira-integration/commands/show_my_tickets.sh

# Show deployment tickets
powershell -File 01-jira-integration/commands/show_deployment_tickets.ps1
bash 01-jira-integration/commands/show_deployment_tickets.sh

# Show ready for QA tickets
powershell -File 01-jira-integration/commands/show_ready_for_qa_tickets.ps1
bash 01-jira-integration/commands/show_ready_for_qa_tickets.sh

# Show detailed ticket information with description and comments
powershell -File 01-jira-integration/commands/show_ticket.ps1 -TicketKey "AP-12345"
bash 01-jira-integration/commands/show_ticket.sh AP-12345
```

## 🤖 AI-Powered Workflows

### **Comment Generation Workflow**
1. **User**: Posts screenshot/text, asks for comment
2. **AI**: Generates comprehensive comment with proper ADF structure and JSON code blocks
3. **AI**: Creates temporary JSON file with generated content
4. **AI**: Posts comment using working scripts
5. **AI**: Auto-deletes temporary JSON file

### **Ticket Creation Workflow**  
1. **User**: Sends screenshot/text describing bug
2. **AI**: Generates properly formatted ADF ticket with company compliance
3. **AI**: Shows preview and asks for confirmation in terminal
4. **User**: Confirms with "y"
5. **AI**: Posts ticket and returns ticket ID

## 🎯 Key Features

### ✅ **Cross-Platform Support**
- **PowerShell scripts** for Windows environments
- **Bash scripts** for Linux/Mac environments  
- **Identical functionality** across all platforms

### ✅ **Perfect JIRA Integration**
- **Proper ADF formatting** for all descriptions and comments
- **JSON code blocks** with syntax highlighting
- **Company-compliant** bug report structure
- **Automatic field mapping** (QA Assignee, Environment, Sprint)

### ✅ **AI-Generated Content**
- **Smart comment generation** from user input
- **Technical analysis** with JSON data formatting
- **Comprehensive bug reports** with all required sections
- **Automatic validation** against company standards

### ✅ **Quality Assurance**
- **Pre-publishing validation** against `bug_metrics_reference.md`
- **Mandatory company compliance** for all tickets
- **Structured ADF content** with proper sections and formatting
- **Error handling** and validation for all operations

## 📚 Documentation

### **User Guides**
- [JIRA Workflow Guide](06-documentation/guides/jira_workflow_guide.md) - Complete workflow documentation
- [JIRA Environment Setup](06-documentation/guides/jira_env_setup_guide.md) - Setup instructions
- [Quick Start Guide](06-documentation/guides/quick_start_guide.md) - Get started quickly

### **Technical References**
- [Atlassian ADF Reference](06-documentation/standards/atlassian_adf_reference.md) - ADF formatting guide
- [JIRA Field Reference](01-jira-integration/config/jira_field_reference.md) - Field mappings and examples
- [Bug Metrics Reference](02-bug-reports/templates/bug_metrics_reference.md) - Company standards

## 🔒 Security & Git Rules

### **Gitignore Rules**
```gitignore
# JIRA Credentials
.env

# Project Testing Files (except documentation)
04-projects/*/
!04-projects/*/project documentation/
!04-projects/*/project rules/

# Bug Reports (examples only)
02-bug-reports/reports/

# Temporary Files
temp_*.json
ai_*.json
test_*.json
```

### **Important Security Notes**
- ⚠️ **Never commit** `.env` file with JIRA credentials (project root)
- ⚠️ **Only documentation folders** in projects can be pushed to git
- ⚠️ **All testing files** (bug reports, test results) are gitignored
- ⚠️ **Temporary JSON files** are auto-cleaned by scripts

## 🛠️ Development

### **Contributing**
1. Follow company coding standards
2. Test all scripts on both PowerShell and Bash
3. Update documentation for any workflow changes
4. Validate against company compliance requirements

### **Branch Strategy**
- `main` - Production-ready framework
- `develop` - Active development
- Feature branches for new functionality

## 📞 Support

For issues or questions:
1. Check the [JIRA Workflow Guide](06-documentation/guides/jira_workflow_guide.md)
2. Review [Technical References](#technical-references)
3. Contact the QA team for framework-specific questions

## 📋 Company Compliance

**All bug tickets MUST comply with [Bug Metrics Reference](02-bug-reports/templates/bug_metrics_reference.md):**
- ✅ Proper summary format: `[QA Manual Framework Testing] [Feature] Title`
- ✅ All mandatory sections: Description, Preconditions, Steps, Expected/Actual Results
- ✅ Visual evidence: Screenshots with page URLs, developer console, error logs
- ✅ Severity classification: P0/P1/P2/P3/P4/5MF (not Major/Minor)
- ✅ Environment specification: dev → stage → prod priority

---

**🎯 Manual QA Framework - Ensuring Quality Through Comprehensive Testing**