# JIRA Workflow Guide - Manual QA Framework

## 🎯 Overview

This guide explains the JIRA workflow, status definitions, and best practices for QA engineers working with the Manual QA Framework.

## 📋 JIRA Status Definitions

### **📋 To Do**
- **Definition**: Ticket has **not begun development yet**
- **What it means**:
  - Ticket is in the backlog
  - Requirements are defined
  - Waiting for development to begin
- **Next step**: Start development
- **QA Action**: Review requirements, create test plan

### **🏭 In Progress**
- **Definition**: Ticket is **being worked on by a developer**
- **What it means**:
  - Development is actively in progress
  - Code is being written and tested
  - Not ready for QA testing yet
- **Next step**: Complete development and move to "Peer Review"
- **QA Action**: Monitor progress, prepare test cases

### **👥 Peer Review**
- **Definition**: Code is **being reviewed by peers**
- **What it means**:
  - Development is complete
  - Code is under review by other developers
  - Waiting for review approval
- **Next step**: Address review feedback or move to "Ready for QA"
- **QA Action**: Monitor review progress, prepare for testing

### **🎯 Ready for QA**
- **Definition**: Ticket is **ready for testing but testing work has not started yet**
- **What it means**:
  - Development and peer review are complete
  - Code is ready for QA testing
  - QA testing has not begun
- **Next step**: Begin QA testing
- **QA Action**: Start testing on development environment

### **🧪 QA Testing**
- **Definition**: Ticket is **currently being tested**
- **What it means**:
  - QA engineer is actively testing the feature/bug fix
  - Test cases are being executed
  - Issues may be found and reported
- **Next step**: Complete testing and move to "To Deploy" or report issues
- **QA Action**: Execute test cases, report bugs, document results

### **🚀 To Deploy**
- **Definition**: Ticket has been **tested on the dev environment and has not been deployed to stage yet**
- **What it means**:
  - QA testing is complete on development environment
  - All test cases pass
  - Ready to be deployed to staging environment
  - Waiting for deployment pipeline/process
- **Next step**: Deploy to staging environment
- **QA Action**: Update ticket with test results and move to "To Deploy"

### **🌐 Deployed**
- **Definition**: Ticket has been **tested on the stage env and is ready for deploy to production**
- **What it means**:
  - Code has been deployed to staging
  - QA testing on staging is complete
  - Ready for production deployment
  - Final validation passed
- **Next step**: Deploy to production
- **QA Action**: Perform final validation on staging environment

### **✅ Done**
- **Definition**: Ticket has been **deployed to production and regression tests have been run**
- **What it means**:
  - Feature/bug fix is live in production
  - Regression testing is complete
  - No issues found in production
  - Ticket is fully complete
- **Next step**: Close ticket
- **QA Action**: Perform regression testing after production deployment

## 🔄 Typical Workflow

```
To Do → In Progress → Peer Review → Ready for QA → QA Testing → To Deploy → Deployed → Done
   ↓         ↓            ↓            ↓            ↓           ↓          ↓        ↓
Planning  Development   Code Review   Ready for    Testing    Dev QA     Staging   Production
          Active        Complete      Testing      Active     Complete   Testing   Complete
```

## 📊 Status Progression for QA Engineers

### **Phase 1: Preparation**
- **Status**: To Do → In Progress → Peer Review
- **QA Action**: Monitor development progress, prepare test cases
- **Tools**: Use enhanced test case templates from `03-test-plans/template/`
- **Documentation**: Create test plan and test cases

### **Phase 2: Testing Initiation**
- **Status**: Ready for QA
- **QA Action**: Begin testing on development environment
- **Tools**: Use enhanced test case templates from `03-test-plans/template/`
- **Documentation**: Start test execution documentation

### **Phase 3: Active Testing**
- **Status**: QA Testing
- **QA Action**: Execute test cases, report bugs, document results
- **Tools**: Use enhanced bug report templates from `02-bug-reports/templates/`
- **Documentation**: Document test results and any issues found

### **Phase 4: Development Testing Complete**
- **Status**: To Deploy
- **QA Action**: Update ticket with comprehensive test results
- **Tools**: Use enhanced bug report templates from `02-bug-reports/templates/`
- **Documentation**: Link test cases and bug reports

### **Phase 5: Staging Validation**
- **Status**: Deployed
- **QA Action**: Final validation on staging environment
- **Tools**: Cross-browser testing, integration testing
- **Documentation**: Final test summary and approval

### **Phase 6: Production Complete**
- **Status**: Done
- **QA Action**: Regression testing after production deployment
- **Tools**: Automated regression suites, smoke tests
- **Documentation**: Update traceability matrix

## 🎯 Best Practices

### **For QA Engineers**
1. **Monitor "Ready for QA" tickets**: Use `show_ready_for_qa_tickets` command to identify tickets ready for testing
2. **Update "QA Testing" status**: When you begin testing
3. **Move to "To Deploy"**: Only after comprehensive testing is complete
4. **Validate "Deployed" tickets**: Perform final staging checks
5. **Use templates**: Leverage enhanced templates for consistency
6. **Document everything**: Maintain clear test documentation

### **Status Update Guidelines**
- **Move to "QA Testing"**: When you begin testing the ticket
- **Move to "To Deploy"**: Only after comprehensive testing is complete
- **Move to "Deployed"**: After staging deployment is confirmed
- **Add comments**: Include test results, screenshots, and evidence
- **Link related tickets**: Reference related bugs, test cases, or requirements

### **Deployment Management**
- **Use "Show Deployment Tickets"**: To identify tickets ready for deployment
- **Coordinate with DevOps**: Provide deployment list from the command output
- **Track deployment progress**: Monitor tickets moving from "To Deploy" to "Deployed"
- **Validate staging deployment**: Perform final QA checks after deployment

### **Communication**
- **Daily standups**: Report on testing progress
- **Blockers**: Immediately update status if blocked
- **Escalation**: Escalate issues that prevent testing completion

## 🛠️ Tools and Templates

### **Test Planning**
- **Enhanced Test Case Template**: `03-test-plans/template/test_case_template_enhanced.md`
- **Test Plan Template**: `03-test-plans/template/test_plan_template.md`

### **Bug Reporting**
- **Enhanced Bug Report Template**: `02-bug-reports/templates/bug_report_template_enhanced.md`
- **Bug Metrics Reference**: `02-bug-reports/templates/bug_metrics_reference.md`

### **JIRA Integration**
- **Enhanced MCP Script**: `01-jira-integration/scripts/jira-mcp-enhanced.sh`
- **Show My Tickets**: `01-jira-integration/commands/show_my_tickets.sh` (all assigned tickets regardless of status)
- **Show Ready for QA Tickets**: `01-jira-integration/commands/show_ready_for_qa_tickets.sh` (tickets ready for QA testing)
- **Show Deployment Tickets**: `01-jira-integration/commands/show_deployment_tickets.sh` (tickets ready for deployment)

## 📈 Metrics and Reporting

### **Key Metrics to Track**
- **Testing Cycle Time**: Time from "Done" to "To Deploy"
- **Defect Detection Rate**: Bugs found during testing
- **Test Coverage**: Percentage of requirements covered by tests
- **Deployment Success Rate**: Successful staging deployments

### **Reporting Templates**
- **Weekly QA Report**: Summary of testing activities
- **Sprint QA Summary**: End-of-sprint testing results
- **Release QA Report**: Pre-production testing summary

## 🔗 Related Documentation

- **[Quick Start Guide](quick_start_guide.md)**: Getting started with the framework
- **[JIRA Environment Setup](jira_env_setup_guide.md)**: Setting up JIRA integration
- **[Deployment Rules](deployment_rules.md)**: Rules and criteria for deployment-ready tickets
- **[AI Assistant Rules](../.cursor/rules/ai_assistant_rules.mdc)**: Using Igor for QA assistance

---

**Note**: This workflow guide should be updated as JIRA processes evolve. Always check with your team lead for the most current workflow practices.
