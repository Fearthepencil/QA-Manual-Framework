# JIRA Bug Report Metrics & Structure (Framework Standards)

## Pre-Reporting Quality Checklist (Mandatory)
Before creating any bug report, verify ALL of these:

1. ✅ I have reproduced the bug 2 - 3 times
2. ✅ I have verified in Tech bug board (using keywords) whether someone else already posted the same issue
3. ✅ I have ascertained whether the same issue is available in the related modules
4. ✅ I have written the detailed steps to reproduce the bug
5. ✅ I have attached relevant videos, screenshots or logs
6. ✅ I haven't missed any mandatory field from bug template

## Key Metrics for Effective Bug Reports

### 1. **Summary Format (Framework Standard)**
**Pattern**: `[Feature / Functionality Name] Title`

**Examples**:
- `[Checkout] Payment form validation fails for international cards`
- `[Search] Product search returns no results for valid queries`
- `[Login] User session expires immediately after login`
- `[OES] /landlords/find-or-create returns deleted owner when name exists`

**Components**:
- **Feature/Functionality Name**: Clear identification of the affected area
- **Title**: Specific description of the issue

### 2. **Mandatory JIRA Fields**
Ensure these fields are properly filled:

- **Project**: "Your Project Key" must be selected
- **Issue Type**: "Bug" must be selected
- **Environment**: Specify highest affected environment (dev, stage, prod)
- **User**: User login/email and link to secret value stored in Vault

### 3. **Preconditions Section**
Tell me what I need to have to start reproducing:
- Environment setup requirements
- User permissions/access needed
- Data state requirements
- Configuration prerequisites
- External dependencies

**Example**:
```
Preconditions:
- Access to Stage Enterprise environment
- User: enterprise.user@company.com (password in Vault: link)
- Manhattan market data available
- Sales records with transaction size 10-100K
- Sorting functionality enabled
```

### 4. **Reproduction Steps (Company Standard)**
What to do - clear, numbered steps (must start with login):
- Start with "Login as [user type]"
- Each step should be actionable
- Include specific values/inputs
- Be specific about UI interactions

**Example**:
```
Steps to Reproduce:
1. Login as enterprise user (enterprise.user@company.com)
2. Navigate to Stage Enterprise sales search
3. Filter for Manhattan market
4. Set transaction size range: 10-100,000
5. Sort by Total Sale Price (descending)
6. Examine top 5 results
7. Click on any high-value transaction
```

### 5. **Expected vs Actual Results**
Final part - clear comparison:

**Format**:
```
Expected Result:
- Buyer field shows: "The Blackstone Group"
- Seller field shows: "CWCapital Asset Management"

Actual Result:
- Buyer field: Empty/not displayed
- Seller field: Empty/not displayed
- Only Recorded Buyer/Seller fields visible
```

### 6. **Visual Proof Requirements (Framework Standard)**
Screenshots MUST include:
- Page URL visible in browser
- Opened developer console with captured JavaScript errors
- Videos, logs, and full-story documentation
- System information: OS version, browser version

### 7. **Severity Classification (Framework Standard)**
Use these specific levels:
- **P0**: Site Outage
- **P1**: Trust/Data Issues & Data Feed/API issues
- **P2**: Broken Functionality With No Work Around
- **P3**: Broken Functionality With Work Around
- **P4**: Usability Concerns
- **5MF**: Five Minute Fix

### 8. **Additional Information** (Bottom Section)
Separate placement for:
- Environment details
- Browser/client info
- Error messages/logs
- Related tickets
- Workarounds
- Technical investigation notes

## Template Structure

```markdown
## Description
Brief overview of the issue and impact.

## Preconditions
- Requirement 1
- Requirement 2
- Requirement 3

## Steps to Reproduce
1. Step one
2. Step two
3. Step three

## Expected Result
What should happen

## Actual Result
What actually happens

---

## Additional Information
### Environment
- Environment: Stage/Prod/Dev
- Browser: Chrome 120.x
- User: Role/permissions

### Error Details
- Error messages
- Log entries
- Stack traces

### Related Information
- Related tickets
- Workarounds available
- Investigation notes
```

## Quality Checklist (Framework Standards)

### Pre-Reporting Verification
- [ ] Bug reproduced 2-3 times
- [ ] Checked Tech bug board for duplicates using keywords
- [ ] Verified if same issue exists in related modules
- [ ] Written detailed reproduction steps
- [ ] Attached videos, screenshots, and logs
- [ ] All mandatory fields completed

### Summary Quality
- [ ] Follows [Feature / Functionality Name] Title format
- [ ] Immediately clear what/where the problem is
- [ ] Specific enough to differentiate from similar issues

### Mandatory Fields Quality
- [ ] Project set to "Your Project Key"
- [ ] Issue Type set to "Bug"
- [ ] Environment specified (highest affected)
- [ ] User credentials and Vault link provided

### Visual Proof Quality
- [ ] Screenshots include page URL
- [ ] Developer console open with JavaScript errors captured
- [ ] System information included (OS version, browser version)
- [ ] Videos/logs provided when applicable

### Severity Assessment Quality
- [ ] Uses company P0-P4/5MF classification
- [ ] Correctly identifies impact level
- [ ] Environment specification follows "highest affected" rule

### Steps Quality
- [ ] Starts with "Login as [user type]"
- [ ] Reproducible by following exactly
- [ ] Numbered and ordered logically
- [ ] Include specific inputs/values

### Expected/Actual Quality
- [ ] Clear contrast between what should vs does happen
- [ ] Specific observable outcomes
- [ ] No ambiguity about the problem
