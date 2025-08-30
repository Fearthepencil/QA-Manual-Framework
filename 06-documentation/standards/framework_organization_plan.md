# Manual QA Framework Organization Plan

## 📁 Proposed Folder Structure

```
qa-manual-framework/
├── .cursor/
│   └── rules/                    # Cursor-specific rules (keep as-is)
│       ├── cursor_rules.mdc
│       └── jira_creation_rules.mdc
│
├── 01-jira-integration/
│   ├── config/                   # JIRA setup & configuration
│   │   ├── jira-mcp-wrapper.sh
│   │   └── jira_field_reference.md
├── .env (excluded from git, moved to project root)
│   ├── templates/                # JIRA ticket templates
│   │   ├── bug-ticket-template.json
│   │   ├── task-ticket-template.json
│   │   └── update-ticket-template.json
│   └── examples/                 # Real ticket examples
│       ├── example-*.json files
│       ├── bt-ticket.json
│       ├── test-*.json files
│       └── update-*.json files
│
├── 02-bug-reports/
│   ├── templates/                # Bug report templates
│   │   ├── bug_metrics_reference.md
│   │   ├── bug_report_template.md
│   │   └── bug_report_quick_guide.md
│   ├── examples/                 # Example bug reports
│   │   ├── ui-bugs/
│   │   ├── api-bugs/
│   │   ├── data-bugs/
│   │   └── performance-bugs/
│   └── current/                  # Active/recent bug reports
│       └── buyer_seller_missing_stage_bug_report.txt
│
├── 03-test-plans/
│   ├── templates/
│   │   ├── test_plan_template.md
│   │   └── summary_test_report_template.md
│   ├── functional/
│   │   ├── demoqa_test_plan.md
│   │   └── ecommerce_test_plan.txt
│   ├── performance/
│   │   ├── perf_test_concurrent.py
│   │   ├── performance_test_report_build1.md
│   │   └── performance_test_report_build2.md
│   └── build-specific/
│       ├── test_plan_build1.md
│       ├── test_plan_build2.md
│       └── summary_test_report_build1_build2.md
│
├── 04-projects/                  # Project examples and templates
│   ├── template/                 # Generic project template
│   ├── example-ecommerce/        # E-commerce testing example
│   ├── example-api/              # API testing example
│   └── README.md                 # Project usage guide
│
├── 05-utilities/
│   ├── traceability_matrix.txt
│   └── scripts/                  # Future automation scripts
│
└── 06-documentation/
    ├── standards/
    │   └── ISTQB_CTFL_Syllabus_v4.0.1.pdf
    └── references/
        └── (future reference materials)
```

## 🎯 File Distribution Plan

### **01-jira-integration/ (19 files)**
**Config:**
- jira-mcp-wrapper.sh
- jira_field_reference.md

**Project Root:**
- .env (JIRA credentials)

**Templates:**
- Create generalized templates from current examples

**Examples:**
- example-ticket-1.json, example-ticket-2.json, example-ticket-3.json
- example-ticket-4.json, example-ticket-5.json
- bt-ticket.json, test-ticket-bt.json, test-ticket.json
- simple-ticket.json, test-comment.json
- update-description.json, update-ticket-*.json files
- buyer-seller-stage-bug.json

### **02-bug-reports/ (21 files)**
**Templates:**
- bug_metrics_reference.md
- bug_report_quick_guide.md
- bug_report_template_consistent.txt

**Examples by Category:**
- **UI Bugs:** floating_header, product_page_404, 404_reload
- **API Bugs:** socket_timeout, specialk_address_verification
- **Data Bugs:** buyer_seller, owner_attributes, data_duplication
- **Performance:** socket_timeout (performance aspect)

### **03-test-plans/ (8 files)**
**Templates:**
- test_plan_template.md
- summary_test_report_template.md

**Functional:**
- demoqa_test_plan.md
- ecommerce_test_plan.txt

**Performance:**
- perf_test_concurrent.py
- performance_test_report_*.md

### **04-projects/ownership-entity/ (2 files)**
- **project documentation/OES_System_Documentation.md** - Comprehensive OES system documentation
- **project rules/.rules** - OES testing guidelines and rules

### **05-utilities/ (2 files)**
- traceability_matrix.txt
- (future scripts)

### **06-documentation/ (1 file)**
- ISTQB_CTFL_Syllabus_v4.0.1.pdf

## 🚀 Benefits of This Organization

1. **Clear Separation**: Each testing discipline has its own space
2. **Template vs Examples**: Clear distinction between reusable templates and specific examples
3. **Easy Navigation**: Logical grouping makes finding files intuitive
4. **Scalability**: Easy to add new categories or subcategories
5. **JIRA Integration**: Centralized JIRA setup and examples
6. **Bug Report Quality**: Standardized templates with examples by category
7. **Project-Specific**: OES testing has dedicated space with organized documentation and rules

## 🔧 Next Steps

1. Create folder structure
2. Move files to appropriate locations
3. Create generalized templates from current examples
4. Update .cursor/rules to reference new structure
5. Add .gitignore for sensitive files (project root .env)
