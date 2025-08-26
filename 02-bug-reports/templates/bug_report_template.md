# Bug Report Template (Following Established Standards)

## 🆕 NEW: JIRA Field Mapping
When creating this bug in JIRA, use the following field mappings:

```json
{
  "fields": {
    "project": {"key": "AP"},
    "issuetype": {"name": "Bug"},
    "summary": "[Bug title]",
    "customfield_11332": {"value": "[Environment]"},
    "customfield_11207": {"accountId": "[QA_ASSIGNEE_ACCOUNT_ID]"},
    "assignee": {"accountId": "[ASSIGNEE_ACCOUNT_ID]"},
    "reporter": {"accountId": "[REPORTER_ACCOUNT_ID]"},
    "priority": {"name": "[Priority]"},
    "customfield_11311": {"value": "[Severity]"},
    "labels": ["[label1]", "[label2]"],
    "customfield_11287": {"value": "[Engineering Team]"},
    "customfield_11330": [{"value": "[Stack1]"}, {"value": "[Stack2]"}]
  }
}
```

**Note**: Replace `[QA_ASSIGNEE_ACCOUNT_ID]` with the actual JIRA account ID of the QA assignee. The QA Assignee field ID is `customfield_11207` for single user assignment.

---

## Bug Report Header
**[READY] [<MODULE OR PAGE>] <Short, clear bug title>**

---

## 1. Bug Description
**Summary**: Brief description of the issue (1-2 sentences)

**Detailed Description**: 
- What is the problem?
- When does it occur?
- Who is affected?

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
**Screenshots/Videos**: 
- [ ] Screenshot of the issue
- [ ] Video recording of reproduction steps
- [ ] Before/after screenshots if applicable

**Technical Details**:
- **URL**: [Page where issue occurs]
- **Browser(s)**: [Chrome, Firefox, Safari, Edge, etc.]
- **OS**: [Windows, macOS, Linux, etc.]
- **Browser Console Errors**: [Any JavaScript errors]
- **Network Tab**: [Any failed requests or unusual responses]
- **Device**: [Desktop, Mobile, Tablet]

---

## 5. Impact Assessment
**Severity Level**:
- [ ] **Critical**: System crash, data loss, security vulnerability
- [ ] **High**: Major functionality broken, significant user impact
- [ ] **Medium**: Minor functionality broken, moderate user impact
- [ ] **Low**: Cosmetic issue, minimal user impact

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
**Priority**: [P1, P2, P3, P4]
**Assigned To**: [Developer name if known]

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