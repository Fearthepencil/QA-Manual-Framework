# JIRA Bug Report Metrics & Structure

## Key Metrics for Effective Bug Reports

### 1. **Summary Format**
**Pattern**: `[WHERE] > [WHAT] > [WHEN]`

**Examples**:
- `[BE] Enterprise Stage > Buyer/Seller Fields Missing > During Sales Search`
- `[FE] Retool Dashboard > API Timeout Error > On Large Dataset Load`
- `[API] OES /landlords/find-or-create > Returns Deleted Owner > When Name Exists in MySQL`

**Components**:
- **WHERE**: Location/system (BE, FE, API, specific service)
- **WHAT**: Specific issue/behavior
- **WHEN**: Trigger condition/context

### 2. **Preconditions Section**
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
- Manhattan market data available
- Sales records with transaction size 10-100K
- Sorting functionality enabled
```

### 3. **Reproduction Steps**
What to do - clear, numbered steps:
- Start from a known state
- Each step should be actionable
- Include specific values/inputs
- Be specific about UI interactions

**Example**:
```
Steps to Reproduce:
1. Navigate to Stage Enterprise sales search
2. Filter for Manhattan market
3. Set transaction size range: 10-100,000
4. Sort by Total Sale Price (descending)
5. Examine top 5 results
6. Click on any high-value transaction
```

### 4. **Expected vs Actual Results**
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

### 5. **Additional Information** (Bottom Section)
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

## Quality Checklist

### Summary Quality
- [ ] Immediately clear what/where the problem is
- [ ] Includes environment context
- [ ] Specific enough to differentiate from similar issues

### Preconditions Quality
- [ ] Someone else can set up the same starting state
- [ ] All dependencies listed
- [ ] Access requirements specified

### Steps Quality
- [ ] Reproducible by following exactly
- [ ] Numbered and ordered logically
- [ ] Include specific inputs/values
- [ ] Start from preconditions state

### Expected/Actual Quality
- [ ] Clear contrast between what should vs does happen
- [ ] Specific observable outcomes
- [ ] No ambiguity about the problem

### Additional Info Quality
- [ ] Separated from main reproduction flow
- [ ] Technical details for developers
- [ ] Related context without cluttering main flow
