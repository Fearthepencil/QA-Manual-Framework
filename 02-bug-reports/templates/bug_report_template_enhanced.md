# Enhanced Bug Report Template (ISTQB & JIRA Aligned)

## Bug Report Header
**[READY] [<MODULE OR PAGE>] <Short, clear bug title>**

---

## 1. Environment Context
**Environment:** [dev/staging/production]  
**Users:** [specific user accounts used for testing]  
**Application:** [enterprise/exchange/exchange+]  
**Browser:** [Chrome/Firefox/Safari/Edge] (if applicable)  
**Device:** [Desktop/Mobile/Tablet] (if applicable)  
**Date Tested:** [YYYY-MM-DD]

---

## 2. Bug Description
**Summary**: Brief description of the issue (1-2 sentences)

**Detailed Description**: 
- What is the problem?
- When does it occur?
- Who is affected?

---

## 3. Expected vs Actual Behavior
**Expected Behavior**: What should happen when the feature is used correctly?

**Actual Behavior**: What actually happens when the issue occurs?

---

## 4. Steps to Reproduce
1. Step 1: [Specific action]
2. Step 2: [Specific action]
3. Step 3: [Specific action]
4. Step 4: [Specific action]
5. [Continue as needed...]

**Prerequisites**: Any setup or conditions required before reproducing

---

## 5. Evidence
**Screenshots/Videos**: 
- [ ] Screenshot of the issue
- [ ] Video recording of reproduction steps
- [ ] Before/after screenshots if applicable

**Technical Details**:
- **URL**: [Page where issue occurs]
- **Browser Console Errors**: [Any JavaScript errors]
- **Network Tab**: [Any failed requests or unusual responses]

---

## 6. Impact Assessment
**Severity Level**:
- [ ] **Critical**: System crash, data loss, security vulnerability
- [ ] **High**: Major functionality broken, significant user impact
- [ ] **Medium**: Minor functionality broken, moderate user impact
- [ ] **Low**: Cosmetic issue, minimal user impact

**User Impact**: How does this affect end users?

**Business Impact**: How does this affect business operations?

---

## 7. Traceability & Coverage
**Related Test Cases**: [TC-001, TC-002] (comma-separated test case IDs)
**Requirements**: [REQ-001, REQ-002] (comma-separated requirement IDs)
**Component**: [Frontend/Backend/API/Database/Infrastructure]
**Feature Area**: [Folder Filter/User Management/Data Processing/etc.]
**Jira Ticket**: [JIRA-123] (if applicable)
**Regression Impact**: [High/Medium/Low] - Likelihood of affecting other features
**Test Coverage Gap**: [Yes/No] - Whether this bug indicates missing test coverage

---

## 8. Test Plan Traceability
**Test Case ID**: [TC-XXX]
**Test Type**: [Functional, Non-functional, Security, Performance, etc.]
**Risk Level**: [High, Medium, Low]
**Test Charter**: [If exploratory testing was used]

---

## 9. Reproducibility
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

## 10. Bug Report Metadata
**Severity/Priority**: [High/Medium/Low] - Brief justification
**Suggested Fix**: [Brief description of potential solution]
**Additional Notes**: [Any other relevant information]

---

## 11. JIRA Integration Fields
**Environment**: [Dev/Stage/Prod]
**Engineering Team**: [Polaris/Vega/Sirius/Helios/Hydrus/Compstak]
**Stack**: [api/apps/data/devops]
**Components**: [Relevant component IDs]
**Labels**: [Relevant labels for categorization]
