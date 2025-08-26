# Bug Report Quick Reference Guide

## Essential Elements (Must Include)

### 1. Header Format
```
[READY] [MODULE] Clear, Specific Title
```
**Examples:**
- `[READY] [Checkout] Payment form validation fails for international cards`
- `[READY] [Search] Product search returns no results for valid queries`
- `[READY] [Login] User session expires immediately after login`

### 2. Critical Information to Capture
- **Screenshots**: Take immediately when you find the bug
- **Console Errors**: Open browser dev tools (F12) and check Console tab
- **Network Issues**: Check Network tab for failed requests
- **Steps**: Be specific and sequential
- **Environment**: Browser, OS, device type

### 3. Severity Guidelines
- **Critical**: System crashes, data loss, security holes
- **High**: Major features broken, significant user impact
- **Medium**: Minor features broken, moderate impact
- **Low**: Cosmetic issues, minimal impact

### 4. Evidence Best Practices
- Screenshot the entire screen, not just the error
- Include URL in screenshot or document separately
- Record video for complex interactions
- Save browser console logs
- Document any error messages exactly as shown

### 5. Steps to Reproduce Checklist
- [ ] Clear, sequential steps
- [ ] Specific data/values used
- [ ] Prerequisites mentioned
- [ ] Expected vs actual results
- [ ] Can someone else follow these steps?

### 6. Technical Details to Include
- **Browser**: Version number (e.g., Chrome 120.0.6099.109)
- **OS**: Version (e.g., Windows 11, macOS 14.1)
- **Device**: Desktop/laptop/mobile/tablet
- **Screen Resolution**: If relevant
- **Network**: WiFi/cable, any VPN/proxy

### 7. Requirement Mapping
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
