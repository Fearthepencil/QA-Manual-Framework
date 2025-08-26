# JIRA Integration TODO

## 🔧 Pending Implementation

### QA Assignee Field Access
**Issue**: The `customfield_11207` (QA Assignee) field has permission restrictions
**Status**: Needs proper implementation
**Details**:
- Field exists but returns "Field does not exist or you do not have permission to view it"
- Most tickets don't have QA Assignee populated
- Need to investigate proper field access permissions
- May require different field ID or permission setup

**Next Steps**:
1. Investigate field permissions in JIRA
2. Check if different field ID is needed
3. Test with different user accounts
4. Update field reference documentation
5. Implement proper QA Assignee search functionality

### Future Enhancements
- Add support for multiple QA Assignee fields
- Implement QA workload dashboard
- Add ticket assignment automation
- Create QA metrics reporting

---
*Last Updated: 2025-01-27*
