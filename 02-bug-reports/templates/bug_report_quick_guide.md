# Bug Report Quick Reference Guide (Company Standards)

## PRE-REPORTING CHECKLIST (Mandatory)
Before creating any bug report, ensure you have completed ALL of these tasks:

1. ✅ I have reproduced the bug 2 - 3 times
2. ✅ I have verified in Tech bug board (using keywords) whether someone else already posted the same issue
3. ✅ I have ascertained whether the same issue is available in the related modules
4. ✅ I have written the detailed steps to reproduce the bug
5. ✅ I have attached relevant videos, screenshots or logs
6. ✅ I haven't missed any mandatory field from bug template

## Essential Elements (Must Include)

### 1. Header Format
```
[Feature / Functionality Name] Title
```
**Examples:**
- `[Checkout] Payment form validation fails for international cards`
- `[Search] Product search returns no results for valid queries`
- `[Login] User session expires immediately after login`

### 2. Mandatory JIRA Fields
- **Project**: "All Tech Projects (AP)" must be selected
- **Issue Type**: "Bug" must be selected
- **Summary**: [Feature / Functionality Name] Title format
- **Environment**: Specify environment (dev, stage, prod) - use highest affected environment
- **User**: User login/email and link to secret value in Vault

### 3. Critical Information to Capture
- **Visual Proof**: Screenshots MUST contain page URL and opened developer console with captured JavaScript errors
- **Console Errors**: Open browser dev tools (F12) and check Console tab
- **Network Issues**: Check Network tab for failed requests
- **Steps**: Be specific and sequential (starting with "Login as [user type]")
- **System Information**: Browser version, OS version, device type

### 4. Severity Guidelines (Company Standards)
- **P0**: Site Outage
- **P1**: Trust/Data Issues & Data Feed/API issues
- **P2**: Broken Functionality With No Work Around
- **P3**: Broken Functionality With Work Around
- **P4**: Usability Concerns
- **5MF**: Five Minute Fix

### 5. Optional JIRA Fields
- **Priority**: "Normal" (default)
- **QA Assignee**: Select QA team member if known
- **Labels**: Team label if you recognize the team working on the feature
- **Mayer's Sprint Report Fields**: Set to "Tech"
- **Story Points**: Empty by default
- **Epic Link**: Empty by default
- **Sprint**: Empty by default

### 6. Evidence Best Practices
- Screenshot the entire screen, not just the error
- Include URL in screenshot or document separately
- Record video for complex interactions
- Save browser console logs
- Document any error messages exactly as shown

### 7. Steps to Reproduce Checklist
- [ ] Clear, sequential steps
- [ ] Specific data/values used
- [ ] Prerequisites mentioned
- [ ] Expected vs actual results
- [ ] Can someone else follow these steps?

### 8. Technical Details to Include
- **Browser**: Version number (e.g., Chrome 120.0.6099.109)
- **OS**: Version (e.g., Windows 11, macOS 14.1)
- **Device**: Desktop/laptop/mobile/tablet
- **Screen Resolution**: If relevant
- **Network**: WiFi/cable, any VPN/proxy

### 9. Requirement Mapping
- Identify which requirement(s) this bug violates
- Be specific about how the requirement is not met
- Reference the exact requirement ID (Req-1-X)

## Common Mistakes to Avoid
- ❌ Vague descriptions ("it doesn't work")
- ❌ Missing screenshots
- ❌ Incomplete reproduction steps
- ❌ No technical details
- ❌ Missing severity assessment
- ❌ No requirement mapping

## Template Usage Tips
1. Copy the template for each new bug
2. Fill out sections in order
3. Use checkboxes to track completion
4. Save evidence files with descriptive names
5. Review before submitting

## Competition Scoring Impact
- **Quality evidence** = Higher defect acceptance rate
- **Clear reproduction** = Faster developer resolution
- **Proper severity** = Better prioritization
- **Requirement mapping** = Full traceability points
- **Technical details** = Professional documentation
