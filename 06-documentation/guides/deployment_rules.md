# Deployment Rules - Manual QA Framework

## 🚀 Overview

This document defines the rules and criteria for identifying tickets that are ready for deployment from development to staging environment.

## 📋 Deployment Criteria

### **Tickets Ready for Deployment**

A ticket is considered ready for deployment when **ALL** of the following criteria are met:

1. **Status**: Ticket status is `"To Deploy"`
2. **QA Assignment**: Current user is assigned as QA Assignee (customfield_11207)
3. **Project**: Ticket belongs to the AP project
4. **Testing Complete**: All QA testing has been completed on development environment
5. **Test Results**: All test cases have passed
6. **No Blockers**: No critical issues preventing deployment

### **JQL Query Used**

The deployment command uses the following JQL query to identify ready tickets:

```sql
project = AP AND status = "To Deploy" AND "QA Assignee" = currentUser()
```

## 🎯 Deployment Process

### **Phase 1: Identification**
- **Command**: Use `show_deployment_tickets` command
- **Purpose**: Identify all tickets ready for deployment
- **Output**: Formatted list of tickets with key information

### **Phase 2: Validation**
- **Review**: Verify all test cases are complete
- **Check**: Ensure no critical bugs are open
- **Confirm**: Validate deployment readiness with team

### **Phase 3: Deployment**
- **Coordinate**: Work with DevOps team for deployment
- **Monitor**: Track deployment progress
- **Validate**: Perform post-deployment verification

### **Phase 4: Status Update**
- **Update**: Move tickets from "To Deploy" to "Deployed"
- **Document**: Record deployment results
- **Notify**: Inform stakeholders of deployment completion

## 📊 Deployment Information Display

The `show_deployment_tickets` command displays:

- **Ticket Key**: JIRA ticket identifier (e.g., AP-12345)
- **Summary**: Brief description of the ticket
- **Status**: Current status (should be "To Deploy")
- **Priority**: Ticket priority level
- **Last Updated**: When the ticket was last modified
- **Environment**: Development environment where testing was completed

## 🔄 Workflow Integration

### **Pre-Deployment Checklist**
- [ ] All test cases executed and passed
- [ ] No critical bugs open
- [ ] Code review completed
- [ ] Documentation updated
- [ ] Stakeholder approval received

### **Post-Deployment Actions**
- [ ] Update ticket status to "Deployed"
- [ ] Perform staging environment validation
- [ ] Document deployment results
- [ ] Notify relevant teams
- [ ] Monitor for any post-deployment issues

## 🛠️ Command Usage

### **PowerShell (Windows)**
```powershell
.\01-jira-integration\commands\show_deployment_tickets.ps1
```

### **Bash (Mac/Linux)**
```bash
bash 01-jira-integration/commands/show_deployment_tickets.sh
```

## 📈 Best Practices

### **For QA Engineers**
1. **Regular Monitoring**: Check deployment tickets daily
2. **Thorough Testing**: Ensure comprehensive testing before marking as "To Deploy"
3. **Clear Communication**: Coordinate with DevOps team for deployment timing
4. **Documentation**: Maintain clear records of testing and deployment activities

### **For DevOps Team**
1. **Batch Deployments**: Group multiple tickets for efficient deployment
2. **Rollback Plan**: Have rollback procedures ready
3. **Monitoring**: Monitor deployment success and performance
4. **Communication**: Provide deployment status updates

## 🔗 Related Documentation

- **[JIRA Workflow Guide](jira_workflow_guide.md)**: Complete JIRA status definitions and workflow
- **[Quick Start Guide](quick_start_guide.md)**: Getting started with the framework
- **[JIRA Environment Setup](jira_env_setup_guide.md)**: Setting up JIRA integration

---

**Note**: These deployment rules should be reviewed and updated as deployment processes evolve. Always coordinate with your DevOps team for current deployment procedures.
