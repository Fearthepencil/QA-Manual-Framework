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
- **Bug Reporting**: Use templates in `02-bug-reports/templates/`
- **Test Planning**: Start with `03-test-plans/template/test_plan_template.md`
- **Project Testing**: Check `04-projects/ownership-entity/project rules/`

## 🛠️ Key Features

### 🔗 JIRA Integration
- Automated ticket creation with standardized formats
- Field mapping for all JIRA project types
- ADF formatting support for rich descriptions

### 📊 Bug Reporting System
- Standardized templates following WHERE > WHAT > WHEN format
- Quality metrics for reproducible reports
- Category organization (UI, API, Data, Performance)

### 📋 Test Planning
- ISTQB-aligned templates
- Performance testing integration
- Traceability matrix support

## 📚 Documentation

### 🎓 Guides
- [JIRA Environment Setup](06-documentation/guides/jira_env_setup_guide.md)
- [Bug Report Quality Standards](02-bug-reports/templates/bug_metrics_reference.md)
- [Test Plan Creation](03-test-plans/template/test_plan_template.md)

### 📖 References
- [JIRA Field Reference](01-jira-integration/config/jira_field_reference.md)
- [Framework Rules](.cursor/rules/cursor_rules.mdc)

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
