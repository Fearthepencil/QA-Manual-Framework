# Bug Report Template (Following Company Standards)

## 🆕 UPDATED: JIRA Field Mapping - Company Standards
When creating this bug in JIRA, use the following field mappings based on company Confluence template:

```json
{
  "fields": {
    "project": {"key": "AP"},
    "issuetype": {"name": "Bug"},
    "summary": "[Feature / Functionality Name] Title",
    "description": "[See detailed description sections below]",
    "customfield_11332": {"value": "[Environment]"},
    "customfield_11207": {"accountId": "[QA_ASSIGNEE_ACCOUNT_ID]"},
    "assignee": {"accountId": "[ASSIGNEE_ACCOUNT_ID]"},
    "reporter": {"accountId": "[REPORTER_ACCOUNT_ID]"},
    "priority": {"name": "Normal"},
    "customfield_11311": {"value": "[Severity]"},
    "labels": ["[team_label_if_known]"],
    "customfield_11287": {"value": "[Engineering Team]"},
    "customfield_11330": [{"value": "[Stack1]"}, {"value": "[Stack2]"}]
  }
}
```

**Note**: Replace `[QA_ASSIGNEE_ACCOUNT_ID]` with the actual JIRA account ID of the QA assignee. The QA Assignee field ID is `customfield_11207` for single user assignment. **Update this field ID to match your JIRA configuration.**

## 🆕 PRE-REPORTING CHECKLIST
Before creating this bug report, ensure you have completed all of these tasks:

1. ✅ I have reproduced the bug 2 - 3 times
2. ✅ I have verified in Tech bug board (using keywords) whether someone else already posted the same issue
3. ✅ I have ascertained whether the same issue is available in the related modules
4. ✅ I have written the detailed steps to reproduce the bug
5. ✅ I have attached relevant videos, screenshots or logs
6. ✅ I haven't missed any mandatory field from bug template

---

## Bug Report Header
**[READY] [<MODULE OR PAGE>] <Short, clear bug title>**

---

## 1. Bug Description
**Summary**: [Feature / Functionality Name] Title

**Detailed Description**: 
- What is the problem?
- When does it occur?
- Who is affected?

**Environment**: Specify environment (dev, stage, prod)
**User**: The user login/email and link to the secret value (password) stored in Vault

---

## 2. Expected vs Actual Behavior
**Expected Behavior**: What should happen when the feature is used correctly?

**Actual Behavior**: What actually happens when the issue occurs?

---

## 3. Steps to Reproduce
1. Step 1: [Specific action]
2. Step 2: [Specific action]
3. Step 3: [Specific action]
4. Step 4: [Specific action]
5. [Continue as needed...]

**Prerequisites**: Any setup or conditions required before reproducing

---

## 4. Evidence
**Visual Proof**: 
- [ ] Screenshots of the issue (must contain page URL and opened developer console with captured JavaScript errors)
- [ ] Video recording of reproduction steps
- [ ] Before/after screenshots if applicable
- [ ] Logs and full-story documentation

**Technical Details**:
- **URL**: [Page where issue occurs]
- **Browser(s)**: [Chrome, Firefox, Safari, Edge, etc.] (include version)
- **OS**: [Windows, macOS, Linux, etc.] (include version)
- **Browser Console Errors**: [Any JavaScript errors]
- **Network Tab**: [Any failed requests or unusual responses]
- **Device**: [Desktop, Mobile, Tablet]

**System Information**:
- Operating system (version)
- Browser (version)

---

## 5. Impact Assessment
**Severity Level** (Company Standards):
- [ ] **P0**: Site Outage
- [ ] **P1**: Trust/Data Issues & Data Feed/API issues
- [ ] **P2**: Broken Functionality With No Work Around
- [ ] **P3**: Broken Functionality With Work Around
- [ ] **P4**: Usability Concerns
- [ ] **5MF**: Five Minute Fix

**Environment Specification**: The "highest" environment must be specified. If you find a bug on Dev, but it is also actual for Stage, then Environment is Stage.

**User Impact**: How does this affect end users?

**Business Impact**: How does this affect business operations?

---

## 6. Requirement Coverage
**Affected Requirements**: 
- [ ] Req-1-1: [Requirement description]
- [ ] Req-1-2: [Requirement description]
- [ ] [Add more as needed]

**Requirement Violation**: How does this bug violate the specified requirements?

---

## 7. Test Plan Traceability
**Test Case ID**: [TC-XXX]
**Test Type**: [Functional, Non-functional, Security, Performance, etc.]
**Risk Level**: [High, Medium, Low]
**Test Charter**: [If exploratory testing was used]

---

## 8. Reproducibility
**Frequency**: 
- [ ] Always (100%)
- [ ] Often (80-99%)
- [ ] Sometimes (50-79%)
- [ ] Rarely (1-49%)
- [ ] Once (0%)

**Conditions**: 
- [ ] Specific time of day
- [ ] Specific user role/permissions
- [ ] Specific data conditions
- [ ] Specific browser/environment
- [ ] Other: [Specify]

---

## 9. Bug Report Metadata
**Reporter**: [Your name]
**Date Reported**: [YYYY-MM-DD]
**Bug ID**: [BUG-XXX]
**Status**: [New, In Progress, Fixed, Verified, Closed]
**Priority**: [Normal (default)]
**Assigned To**: [Developer name if known]
**QA Assignee**: [QA team member if known]

**Optional Fields**:
- **Story Points**: [Empty by default]
- **Epic Link**: [Empty by default]
- **Sprint**: [Empty by default]
- **Labels**: [Team label if known]
- **Mayer's Sprint Report Fields**: [Set to "Tech"]

**Requirement Reference**: [Explicit reference to requirement IDs]

---

## 10. Additional Information
**Workarounds**: Any temporary solutions users can apply?

**Related Bugs**: Any similar or related issues?

**Notes**: Any additional context or observations

---

## 11. Verification Checklist
- [ ] Bug is clearly described
- [ ] Steps to reproduce are complete and accurate
- [ ] Evidence is provided (screenshots, logs, etc.)
- [ ] Impact is properly assessed
- [ ] Requirements are mapped
- [ ] Technical details are included
- [ ] Reproducibility is documented
- [ ] All metadata fields are completed

---

**Template Version**: 1.0
**Last Updated**: [Date]
**Standards Compliance**: ISTQB/EESTQB Competition Standards 