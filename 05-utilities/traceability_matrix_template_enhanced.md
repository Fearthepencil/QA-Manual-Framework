# Enhanced Traceability Matrix Template (ISTQB & JIRA Aligned)

**Project:** [Project ID] - [Project Name]  
**Created:** [Date]  
**Last Updated:** [Date]  
**QA Lead:** [Name]  
**Environment:** [dev/staging/production]

---

## 📊 Requirements Coverage Matrix

| Requirement ID | Requirement Description | Test Cases | Bug Reports | Status | Coverage % | Notes |
|----------------|------------------------|------------|-------------|---------|------------|-------|
| REQ-001 | [Requirement description] | TC-001, TC-002 | BUG-001 | ✅ Complete | 100% | All test cases pass |
| REQ-002 | [Requirement description] | TC-003, TC-004 | BUG-002 | 🔄 In Progress | 75% | Missing edge case coverage |
| REQ-003 | [Requirement description] | TC-005 | None | ⏳ Not Started | 0% | No test cases created yet |

**Legend:**
- ✅ Complete: All test cases pass, no open bugs
- 🔄 In Progress: Some test cases pass, some bugs open
- ⏳ Not Started: No test cases created yet
- ❌ Blocked: Cannot test due to dependencies

---

## 🧪 Test Case Coverage Matrix

| Test Case ID | Test Case Title | Requirements | Bug Reports | Status | Last Executed | Notes |
|--------------|-----------------|--------------|-------------|---------|---------------|-------|
| TC-001 | [Test case title] | REQ-001 | BUG-001 | ✅ Pass | [Date] | [Notes] |
| TC-002 | [Test case title] | REQ-001 | None | ✅ Pass | [Date] | [Notes] |
| TC-003 | [Test case title] | REQ-002 | BUG-002 | ❌ Fail | [Date] | [Notes] |

**Legend:**
- ✅ Pass: Test case passes consistently
- ❌ Fail: Test case currently failing
- ⏸️ Blocked: Test case blocked by dependencies
- 🔄 In Progress: Test case being executed

---

## 🐛 Bug Report Impact Matrix

| Bug Report ID | Bug Title | Related Test Cases | Requirements | Severity | Status | Regression Impact |
|---------------|-----------|-------------------|--------------|----------|---------|-------------------|
| BUG-001 | [Bug title] | TC-001, TC-002 | REQ-001 | High | Open | High |
| BUG-002 | [Bug title] | TC-003 | REQ-002 | Medium | Fixed | Medium |
| BUG-003 | [Bug title] | None | REQ-003 | Low | Open | Low |

**Legend:**
- **Severity:** Critical/High/Medium/Low
- **Status:** Open/Fixed/Closed/Deferred
- **Regression Impact:** High/Medium/Low

---

## 🎯 JIRA Integration Matrix

| JIRA Ticket | Component | Feature Area | Test Cases | Bug Reports | Status | QA Assignee |
|-------------|-----------|--------------|------------|-------------|---------|-------------|
| AP-XXXXX | [Component] | [Feature Area] | TC-001, TC-002 | BUG-001 | In Progress | [QA Name] |
| AP-XXXXX | [Component] | [Feature Area] | TC-003 | None | To Do | [QA Name] |

**Legend:**
- **Component:** Frontend/Backend/API/Database/Infrastructure
- **Feature Area:** Folder Filter/User Management/Data Processing/etc.
- **Status:** To Do/In Progress/Done/Blocked

---

## 📈 Coverage Summary

### Requirements Coverage
- **Total Requirements:** [Number]
- **Covered Requirements:** [Number]
- **Coverage Percentage:** [Percentage]%

### Test Case Coverage
- **Total Test Cases:** [Number]
- **Passing Test Cases:** [Number]
- **Failing Test Cases:** [Number]
- **Blocked Test Cases:** [Number]

### Bug Coverage
- **Total Bug Reports:** [Number]
- **Open Bug Reports:** [Number]
- **Fixed Bug Reports:** [Number]
- **Bugs with Test Cases:** [Number]

### JIRA Coverage
- **Total JIRA Tickets:** [Number]
- **Tickets with Test Cases:** [Number]
- **Tickets with Bug Reports:** [Number]
- **QA Assigned Tickets:** [Number]

---

## 🔍 Coverage Gaps Analysis

### Missing Test Coverage
- [List requirements without test cases]
- [List features without test cases]

### Missing Bug Coverage
- [List test cases without corresponding bug reports for failures]
- [List areas with potential bugs but no test cases]

### Missing JIRA Coverage
- [List test cases without JIRA tickets]
- [List bug reports without JIRA tickets]

### Recommendations
- [Specific recommendations to improve coverage]
- [Priority order for addressing gaps]

---

## 📝 Notes and Updates

### Recent Changes
- [Date]: [Description of changes made to traceability matrix]
- [Date]: [Description of changes made to traceability matrix]

### Upcoming Actions
- [ ] [Action item 1]
- [ ] [Action item 2]
- [ ] [Action item 3]

---

## 🎯 ISTQB Quality Criteria

### Traceability Quality
- [ ] **Completeness**: All requirements have corresponding test cases
- [ ] **Accuracy**: Test cases accurately verify requirements
- [ ] **Consistency**: Traceability links are consistent throughout
- [ ] **Maintainability**: Matrix is easy to update and maintain

### Coverage Quality
- [ ] **Requirement Coverage**: All requirements are covered by test cases
- [ ] **Risk Coverage**: High-risk areas have adequate test coverage
- [ ] **Code Coverage**: Critical code paths are tested
- [ ] **Feature Coverage**: All features have test coverage

---

*Last Updated:* [Date]  
*Updated By:* [Name]  
*Next Review:* [Date]  
*Environment:* [dev/staging/production]
