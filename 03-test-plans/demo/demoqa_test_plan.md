# Test Plan for DemoQA Web Application

## 1. Test Plan Overview (Maps to STR §2)
- **System Under Test (SUT):** DemoQA Web Application ([https://demoqa.com/](https://demoqa.com/))
- **Test Team:** [Your Team Name/Members]
- **Test Period:** [Planned Start/End]
- **Test Environment:** Chrome, Firefox, Edge, Windows 10/11, macOS, mobile devices, tools: Selenium, Playwright, Cypress, Lighthouse, axe DevTools

### 1.1 Test Objectives
- Validate core functionalities (forms, widgets, elements, tables, alerts, file upload/download, dynamic properties)
- Assess non-functional aspects: performance, accessibility, usability, basic security
- Ensure cross-browser and cross-device compatibility
- Identify and document defects with clear evidence and traceability

### 1.2 Test Scope
- **In Scope:**
  - Practice Form (form validation, submission)
  - Elements (buttons, checkboxes, radio buttons, links)
  - Widgets (date pickers, sliders, accordions)
  - Web Tables (add/edit/delete rows)
  - Alerts, Frames & Windows (alert dialogs, browser windows)
  - File Upload/Download
  - Dynamic Properties
- **Out of Scope:**
  - Backend/API testing (unless exposed via UI)
  - Non-public or admin-only features

### 1.3 Test Types to be Performed
- Functional (manual and automated)
- Non-functional (performance, accessibility, usability, basic security)
- Exploratory (session-based charters)
- Regression (core flows after changes)
- Cross-browser/device

### 1.4 Risk-Based Focus
- High risk: Form validation, file upload/download, dynamic UI elements
- Medium risk: Table operations, alert handling, cross-browser compatibility
- Low risk: Static content, simple navigation

### 1.5 Time Management
- **Planned Time Allocation:**
  - Test planning & design: 1 hour
  - Functional testing: 2 hours
  - Non-functional testing: 1 hour
  - Exploratory sessions: 1 hour
  - Reporting & documentation: 1 hour
- **Milestones:**
  - Test plan ready: [Date/Time]
  - Test execution: [Date/Time]
  - Reporting: [Date/Time]

---

## 2. Test Items & Features (Maps to STR §2, §3)
- **Test Items:**
  - Practice Form
  - Elements (buttons, checkboxes, radio buttons, links)
  - Widgets (date pickers, sliders, accordions)
  - Web Tables
  - Alerts, Frames & Windows
  - File Upload/Download
  - Dynamic Properties
- **Features to be Tested:**
  - All user-facing features listed above
- **Features Not to be Tested:**
  - Backend/API endpoints not exposed via UI

---

## 3. Test Design & Approach (Maps to STR §3)
- **Test Design Techniques:**
  - Equivalence partitioning, boundary value analysis (for forms)
  - Exploratory charters (for dynamic/complex features)
  - Checklist-based (for cross-browser/device)
- **Test Case/Charter Overview:**
  - Test cases for each feature/module
  - Charters for exploratory sessions (e.g., "Explore Practice Form for edge cases")
- **Prioritization:**
  - Risk-based: focus on high-impact and complex features first
- **Traceability:**
  - Each test case/charter mapped to feature/risk in this plan

---

## 4. Test Data & Environment (Maps to STR §3, §7)
- **Test Data:**
  - Valid/invalid form inputs (names, emails, phone numbers, files)
  - Edge cases (empty fields, special characters, large files)
- **Test Environment Setup:**
  - Browsers: Chrome, Firefox, Edge
  - OS: Windows 10/11, macOS
  - Devices: Desktop, mobile
- **Test Tools:**
  - Selenium, Playwright, Cypress (automation)
  - Lighthouse, axe DevTools (performance/accessibility)
  - Browser dev tools (debugging, logs)

---

## 5. Entry & Exit Criteria
- **Entry Criteria:**
  - Access to https://demoqa.com/
  - Test plan and data prepared
  - Tools installed and configured
- **Exit Criteria:**
  - All planned test cases/charters executed
  - All critical defects reported
  - Summary Test Report completed

---

## 6. Roles & Responsibilities
- Test Lead: [Name] (planning, reporting)
- Testers: [Names] (execution, documentation)
- Automation Engineer: [Name] (automation scripts)

---

## 7. Risk Management (Maps to STR §2, §5)
- **Product Risks:**
  - Data loss/corruption in forms or tables
  - Broken file upload/download
  - Accessibility issues
- **Project Risks:**
  - Limited time for cross-browser/device testing
  - Tool configuration issues
- **Mitigation Strategies:**
  - Prioritize high-risk features
  - Prepare test data and tools in advance

---

## 8. Reporting & Communication
- **Defect Reporting:**
  - Use bug report template (aligned with STR)
  - Store evidence (screenshots, logs) in shared drive
- **Test Reporting:**
  - Daily status updates (if multi-day)
  - Final STR following template
- **Documentation Standards:**
  - English, structured templates, evidence for all findings

---

## 9. Non-Functional Testing Plan (Maps to STR §2, §4)
- **Performance:**
  - Use Lighthouse to measure page load, responsiveness
  - Note any slow widgets or dynamic elements
- **Accessibility:**
  - Use axe DevTools and Lighthouse accessibility audits
  - Check keyboard navigation, color contrast, labels
- **Usability:**
  - Heuristic evaluation of navigation, feedback, error messages
- **Security (Basic):**
  - Input validation, XSS attempts in forms
  - File upload restrictions

---

## 10. AI Usage Plan (Maps to STR §7)
- **AI Tools/Approaches:**
  - Use AI (e.g., ChatGPT) to generate test data, test cases, and bug report drafts
- **Evidence Collection:**
  - Save AI prompts and outputs as evidence for STR

---

## 11. Appendices
- **References:**
  - [DemoQA Practice Site](https://demoqa.com/)
  - [Bug Report Template]
  - [Summary Test Report Template]
- **Glossary:**
  - SUT: System Under Test
  - STR: Summary Test Report
- **Other Attachments:**
  - Test data sets
  - Automation scripts 