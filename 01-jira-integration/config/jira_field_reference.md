# JIRA Field Reference - Generic JIRA Bug(t) Creation

## 🆕 NEW: User-Related Fields (Discovered via JIRA API)

### QA Assignee Fields
| Field | Field ID | Type | Description | Format |
|-------|----------|------|-------------|--------|
| QA Assignee (Single) | `customfield_11207` | User Picker | Primary QA assignee (single user) | `{"accountId": "USER_ACCOUNT_ID"}` |
| QA Assignee (Multi - Project 12382) | `customfield_11313` | People Picker | QA assignees (multiple users) | `[{"accountId": "USER1"}, {"accountId": "USER2"}]` |
| QA Assignee (Multi - Project 12366) | `customfield_11308` | People Picker | QA assignees (multiple users) | `[{"accountId": "USER1"}, {"accountId": "USER2"}]` |

### Standard User Fields
| Field | Field ID | Type | Description | Format |
|-------|----------|------|-------------|--------|
| Assignee | `assignee` | System | Issue assignee | `{"accountId": "USER_ACCOUNT_ID"}` |
| Reporter | `reporter` | System | Issue reporter | `{"accountId": "USER_ACCOUNT_ID"}` |
| Creator | `creator` | System | Issue creator | `{"accountId": "USER_ACCOUNT_ID"}` |

### Additional Assignee Fields
| Field | Field ID | Type | Description | Format |
|-------|----------|------|-------------|--------|
| Data Assignee | `customfield_11244` | People Picker | Data team assignee | `[{"accountId": "USER_ACCOUNT_ID"}]` |
| Research Assignee | `customfield_11245` | People Picker | Research team assignee | `[{"accountId": "USER_ACCOUNT_ID"}]` |
| Exchange Team Contact(s) | `customfield_11259` | People Picker | Exchange team contacts | `[{"accountId": "USER_ACCOUNT_ID"}]` |

### Field Usage Examples for User Fields

#### Creating a Bug with QA Assignee
```json
{
  "fields": {
    "project": {"key": "YOUR_PROJECT"},
    "issuetype": {"name": "Bug"},
    "summary": "Login button not working on mobile",
    "customfield_11332": {"value": "Production"},
    "customfield_11207": {"accountId": "5f7b5c8d9e0f1a2b3c4d5e6f"},
    "assignee": {"accountId": "5f7b5c8d9e0f1a2b3c4d5e6f"},
    "reporter": {"accountId": "5f7b5c8d9e0f1a2b3c4d5e6f"},
    "priority": {"name": "High"},
    "customfield_11311": {"value": "Critical"}
  }
}
```

#### Creating a Bug with Multiple QA Assignees
```json
{
  "fields": {
    "project": {"key": "YOUR_PROJECT"},
    "issuetype": {"name": "Bug"},
    "summary": "Database connection timeout",
    "customfield_11332": {"value": "Staging"},
    "customfield_11313": [
      {"accountId": "5f7b5c8d9e0f1a2b3c4d5e6f"},
      {"accountId": "6f8c6d9e0f1a2b3c4d5e6f7g"}
    ],
    "assignee": {"accountId": "5f7b5c8d9e0f1a2b3c4d5e6f"},
    "priority": {"name": "Medium"}
  }
}
```

### Field Discovery Notes
- **Primary QA Assignee**: Use `customfield_11207` for single QA assignee
- **Multi QA Assignee**: Use `customfield_11313` or `customfield_11308` based on project
- **User Account IDs**: Required format is `{"accountId": "USER_ACCOUNT_ID"}`
- **Multi-user Fields**: Use array format for people picker fields
- **Project Scope**: Some fields are project-specific (e.g., customfield_11313 for project 12382)

---

## Project Information
- **Project Key**: YOUR_PROJECT
- **Project Name**: All Tech Projects  
- **Issue Type**: Bug (t)
- **Issue Type ID**: 1
  
## Required Fields
These fields MUST be included in every Bug(t) ticket:
  
| Field | Field Name | Type | Format |
|-------|------------|------|--------|
| `project` | Project | project | `{"key": "YOUR_PROJECT"}` |
| `issuetype` | Issue Type | issuetype | `{"id": "1"}` |
| `summary` | Summary | string | `"Your ticket title"` |
| `customfield_11332` | Environment | option | `{"value": "Dev"}` |

## Optional Fields with Predefined Values

### Environment (customfield_11332) - REQUIRED
```json
"customfield_11332": {"value": "OPTION"}
```
**Options:**
- `"Preview"` (ID: 10520)
- `"Dev"` (ID: 10521) 
- `"Stage"` (ID: 10522)
- `"Prod"` (ID: 10523)

### Engineering Team (customfield_11287)
```json
"customfield_11287": {"value": "TEAM"}
```
**Options:**
- `"Team Alpha"` (ID: 10370)
- `"Team Beta"` (ID: 10371)
- `"Team Gamma"` (ID: 10443)
- `"Team Delta"` (ID: 10583)
- `"Team Epsilon"` (ID: 10584)
- `"Your Company"` (ID: 10437)

### Stack (customfield_11330)
```json
"customfield_11330": [{"value": "STACK1"}, {"value": "STACK2"}]
```
**Options (Array - can select multiple):**
- `"api"` (ID: 10516)
- `"apps"` (ID: 10517)
- `"data"` (ID: 10518)
- `"devops"` (ID: 10519)

### Priority
```json
"priority": {"id": "ID"}
```
**Options:**
- ID: 1 (Highest)
- ID: 2 (High)  
- ID: 3 (Medium)
- ID: 4 (Low)
- ID: 10000 (Lowest)

### Severity (customfield_11311)
```json
"customfield_11311": {"value": "SEVERITY"}
```
**Options:**
- `"P0 - Site Outage"` (ID: 10489)
- `"P1 - Trust/Data/Datafeed/API Issue"` (ID: 10490)
- `"P2 - Broken Functionality With No Work Around"` (ID: 10491)
- `"P3 - Broken Functionality With Work Around"` (ID: 10492)
- `"P4 - Usability Concern"` (ID: 10493)
- `"FMF - Five Minute Fix"` (ID: 10494)

### Components
```json
"components": [{"id": "ID1"}, {"id": "ID2"}]
```
**Available Components:**
- Admin (ID: 11635)
- Apps Build System (ID: 11683)
- Apps Enterprise (ID: 11678)
- Apps Exchange (ID: 11682)
- Belaz + Client Data Feed (ID: 11675)
- Bottleneck 2nd gen (ID: 11695)
- ChartBuilder (ID: 11719)
- ChurnZero (ID: 11684)
- CI/CD (ID: 11644)
- Columns (ID: 11716)
- Authentication Services (ID: 11677)
- Data Processing Services (ID: 11688)
- Exchange Services (ID: 11638)
- Search & Indexing Services (ID: 11640)
- CoreLogic (ID: 11689)
- Costs (ID: 11724)
- Credits (ID: 11725)
- Design (ID: 11727)
- Elastic Search (ID: 11681)
- Exchange Dashboard (ID: 11692)
- Export (ID: 11717)
- External/Public API (ID: 11633)
- Filters (ID: 11715)
- First American (ID: 11694)
- Gateway (ID: 11714)
- lease-comp-pipeline (ID: 11722)
- Map analytics (ID: 11691)
- NewAuthentication (ID: 11699)
- PDF-generator (ID: 11686)
- Portfolio Analytics (ID: 11690)
- ppm (ID: 11672)
- sales-comps (ID: 11718)
- Salesforce DataSync (ID: 11679)
- specialk (ID: 11632)
- spk-lease-comps (ID: 11723)
- spk-sales-comps (ID: 11720)
- spk-submissions-and-tasks (ID: 11721)
- SSO (ID: 11713)
- Stytch Integration (ID: 11760)

### Pass Product UAT (customfield_11307)
```json
"customfield_11307": [{"value": "Yes"}]
```
**Options:**
- `"Yes"` (ID: 10461)

## Text Fields (Free Form)

### Description - CRITICAL: ADF Format Required
❌ **NEVER use plain text - causes 400 Bad Request:**
```json
"description": "Plain text causes error"
```

✅ **ALWAYS use Atlassian Document Format (ADF):**
```json
"description": {
  "type": "doc",
  "version": 1,
  "content": [
    {
      "type": "paragraph",
      "content": [
        {
          "type": "text",
          "text": "Your bug description here"
        }
      ]
    }
  ]
}
```

### ADF Formatting Examples

**Simple paragraph:**
```json
{
  "type": "paragraph",
  "content": [
    {"type": "text", "text": "Regular text"}
  ]
}
```

**Bold text:**
```json
{
  "type": "text",
  "text": "Bold text",
  "marks": [{"type": "strong"}]
}
```

**Bullet list:**
```json
{
  "type": "bulletList",
  "content": [
    {
      "type": "listItem",
      "content": [
        {
          "type": "paragraph",
          "content": [
            {"type": "text", "text": "List item text"}
          ]
        }
      ]
    }
  ]
}
```

**Headings:**
```json
{
  "type": "heading",
  "attrs": {"level": 3},
  "content": [
    {"type": "text", "text": "Heading Text"}
  ]
}
```

### Other Optional Text Fields
- `labels`: Array of strings
- `assignee`: `{"accountId": "USER_ACCOUNT_ID"}`
- `reporter`: `{"accountId": "USER_ACCOUNT_ID"}`

## Complete Example JSON

### Minimal Required Ticket
```json
{
  "fields": {
    "project": {"key": "YOUR_PROJECT"},
    "issuetype": {"id": "1"},
    "summary": "Bug title here",
    "customfield_11332": {"value": "Dev"}
  }
}
```

### Comprehensive Ticket Example (with ADF Description)
```json
{
  "fields": {
    "project": {"key": "YOUR_PROJECT"},
    "issuetype": {"id": "1"},
    "summary": "Example Bug Title",
    "description": {
      "type": "doc",
      "version": 1,
      "content": [
        {
          "type": "heading",
          "attrs": {"level": 3},
          "content": [
            {"type": "text", "text": "Description"}
          ]
        },
        {
          "type": "paragraph",
          "content": [
            {
              "type": "text",
              "text": "The example job fails to update attributes in the database from the Elasticsearch index."
            }
          ]
        },
        {
          "type": "heading",
          "attrs": {"level": 3},
          "content": [
            {"type": "text", "text": "Steps to Reproduce"}
          ]
        },
        {
          "type": "bulletList",
          "content": [
            {
              "type": "listItem",
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {"type": "text", "text": "Run the example job"}
                  ]
                }
              ]
            },
            {
              "type": "listItem",
              "content": [
                {
                  "type": "paragraph",
                  "content": [
                    {"type": "text", "text": "Check the database data"}
                  ]
                }
              ]
            }
          ]
        }
      ]
    },
    "customfield_11332": {"value": "Dev"},
    "customfield_11287": {"value": "Team Alpha"},
    "customfield_11330": [{"value": "api"}, {"value": "data"}],
    "customfield_11311": {"value": "P2 - Broken Functionality With No Work Around"},
    "priority": {"id": "3"},
    "components": [
      {"id": "11718"},
      {"id": "11681"}
    ]
  }
}
```

## API Usage

### Authentication
```bash
Authorization: Basic <base64(email:api_token)>
Content-Type: application/json
```

### Create Ticket
```bash
POST https://your-domain.atlassian.net/rest/api/3/issue
```

## Notes
- All tickets will automatically go to **Backlog** status when created
- Environment field is **REQUIRED** for Bug(t) type
- Use `{"value": "OPTION"}` format for single-select fields
- Use `[{"value": "OPTION1"}, {"value": "OPTION2"}]` format for multi-select fields
- Use `{"id": "ID"}` format for system fields like priority and components

## CRITICAL: ADF Format Requirement
**Based on testing experience:**
- ❌ **Plain text descriptions cause 400 Bad Request errors**
- ❌ **String with newlines (\n) also fails**
- ✅ **Only ADF (Atlassian Document Format) works**
- ✅ **Both creation and editing require ADF**
- ✅ **ADF supports rich formatting (bold, lists, headings)**

**Testing Results:**
- Failed attempt 1: `"description": "Plain text"`
- Failed attempt 2: `"description": "Text with\n\nnewlines"`  
- Success: ADF format with proper document structure
