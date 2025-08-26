# 🧪 Manual QA Framework - Professional Testing Framework

A comprehensive, enterprise-grade testing framework designed for modern software development teams. Built with best practices, automation-ready, and JIRA-integrated.

![Testing Framework](https://img.shields.io/badge/Testing-Framework-blue)
![JIRA Integration](https://img.shields.io/badge/JIRA-Integration-green)
![Bug Reports](https://img.shields.io/badge/Bug-Reports-orange)
![Test Plans](https://img.shields.io/badge/Test-Plans-purple)

## 🎯 Overview

**Manual QA Framework** is a structured testing framework that provides:
- **Standardized bug reporting** with JIRA integration
- **Comprehensive test planning** templates
- **Performance testing** tools and reports
- **Project-specific testing** workflows
- **Quality metrics** and best practices

## 📁 Framework Structure

```
qa-manual-framework/
├── 01-jira-integration/          # JIRA setup, templates, examples
│   ├── config/                   # MCP configuration, field references
│   └── commands/                 # JIRA API commands and examples
├── 02-bug-reports/               # Bug reporting system
│   ├── templates/                # Standardized bug report templates
│   └── reports/                  # Example bug reports by category
├── 03-test-plans/                # Test planning and execution
│   ├── template/                 # Test plan templates
│   └── demo/                     # Example test plans
├── 04-oes-project-testing/       # Project-specific testing
│   └── project rules/            # OES testing guidelines
├── 05-utilities/                 # Testing tools and scripts
├── 06-documentation/             # Guides, standards, references
│   ├── guides/                   # Setup and usage guides
│   └── standards/                # Testing standards and best practices
└── .cursor/                      # Cursor IDE configuration
    └── rules/                    # Framework rules and guidelines
```

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/qa-manual-framework.git
cd qa-manual-framework
```

### 2. Set Up JIRA Integration
Follow the [JIRA Environment Setup Guide](06-documentation/guides/jira_env_setup_guide.md) to configure:
- API token generation
- Environment file setup
- MCP server configuration

### 3. Choose Your Testing Workflow

#### 🐛 Bug Reporting
```bash
# Use standardized templates
02-bug-reports/templates/bug_metrics_reference.md
02-bug-reports/templates/bug_report_template.md
```

#### 📋 Test Planning
```bash
# Start with templates
03-test-plans/template/test_plan_template.md
```

#### 🔧 Project Testing
```bash
# Project-specific guidelines
04-oes-project-testing/project rules/
```

## 🛠️ Key Features

### 🔗 JIRA Integration
- **Automated ticket creation** with standardized formats
- **Field mapping** for all JIRA project types
- **ADF formatting** support for rich descriptions
- **MCP server** integration for seamless workflow

### 📊 Bug Reporting System
- **Standardized templates** following WHERE > WHAT > WHEN format
- **Quality metrics** for reproducible reports
- **Category organization** (UI, API, Data, Performance)
- **JIRA-ready** formatting

### 📋 Test Planning
- **ISTQB-aligned** templates
- **Performance testing** integration
- **Build-specific** test plans
- **Traceability matrix** support

### 🎯 Project-Specific Testing
- **OES (Ownership Entity Service)** testing workflows
- **Custom checklists** and scenarios
- **BDD test cases** in Gherkin format
- **Project rules** and guidelines

## 📚 Documentation

### 🎓 Guides
- [JIRA Environment Setup](06-documentation/guides/jira_env_setup_guide.md)
- [Bug Report Quality Standards](02-bug-reports/templates/bug_metrics_reference.md)
- [Test Plan Creation](03-test-plans/template/test_plan_template.md)

### 📖 References
- [JIRA Field Reference](01-jira-integration/config/jira_field_reference.md)
- [JIRA Creation Rules](.cursor/rules/jira_creation_rules.mdc)
- [Framework Rules](.cursor/rules/cursor_rules.mdc)

## 🔧 Configuration

### Environment Setup
Create a `.env` file in the project root:
```env
JIRA_MCP_LOGIN=your.email@compstak.com
JIRA_MCP_TOKEN=your_api_token_here
```

### Cursor IDE Integration
The framework includes Cursor-specific rules and configurations for seamless integration.

## 🎯 Usage Examples

### Creating a Bug Report
1. Use the [bug metrics reference](02-bug-reports/templates/bug_metrics_reference.md)
2. Follow the WHERE > WHAT > WHEN summary format
3. Include preconditions, steps, expected/actual results
4. Add technical details in the additional information section

### Planning Tests
1. Start with the [test plan template](03-test-plans/template/test_plan_template.md)
2. Customize for your specific project needs
3. Include performance testing considerations
4. Create traceability matrices

### JIRA Integration
1. Configure your environment using the setup guide
2. Use the field reference for proper ticket creation
3. Follow ADF formatting for descriptions
4. Leverage MCP server for automated workflows

## 🤝 Contributing

### Adding New Templates
1. Follow the existing folder structure
2. Use consistent naming conventions
3. Include examples and documentation
4. Update relevant references

### Improving Documentation
1. Keep guides up-to-date with latest changes
2. Add troubleshooting sections
3. Include practical examples
4. Maintain cross-references

### Bug Reports and Issues
- Use the framework's own bug reporting system
- Follow the established quality standards
- Include reproduction steps and expected/actual results

## 📈 Quality Standards

### Bug Report Quality
- ✅ Summary follows WHERE > WHAT > WHEN format
- ✅ Preconditions enable reproduction setup
- ✅ Steps are exactly reproducible
- ✅ Expected vs Actual shows clear contrast
- ✅ Additional info separated from main flow

### Test Plan Quality
- ✅ ISTQB-aligned structure
- ✅ Clear scope and objectives
- ✅ Comprehensive test scenarios
- ✅ Performance considerations included
- ✅ Traceability maintained

### JIRA Integration Quality
- ✅ Proper field mapping
- ✅ ADF formatting used
- ✅ Environment-specific configuration
- ✅ Security best practices followed

## 🔒 Security

- **Environment files** are excluded from version control
- **API tokens** are stored securely in `.env` files
- **Credentials** are never hardcoded in scripts
- **Access controls** are maintained for all integrations

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **ISTQB** for testing standards and best practices
- **Atlassian** for JIRA integration capabilities
- **Testing community** for continuous improvement feedback

## 📞 Support

For questions, issues, or contributions:
1. Check the [documentation](06-documentation/)
2. Review [troubleshooting guides](06-documentation/guides/)
3. Create an issue using the framework's bug reporting system
4. Contact the maintainers for complex integrations

---

**Built with ❤️ for the testing community**

*Manual QA Framework - Where Quality Meets Efficiency*
