# Testing the Ownership Entity System (OES)

## Overview

The Ownership Entity System (OES) is designed to link recorded owners to landlord entities in the CompStak Services database. This system consists of several interconnected databases that import data, process it, and export it back into the CompStak Services database.

## System Architecture

### Databases Involved
- **Entity Ownership PostgreSQL Database** (Primary OES database)
- **PPM PostgreSQL Database** (Property Portfolio Management)
- **CompStak Services MySQL Database** (Main services database)

### Data Flow
1. **Import Phase**: Data is imported from source databases into OES
2. **Processing Phase**: Data is parsed, compared, and matched
3. **Export Phase**: New/updated records are exported back to CompStak Services

## Database Tables and Relationships

### Entity Ownership Database Tables
- `cs_landlords` (CSL) - Imported from CompStak Services landlords table
- `ppm_building_info_submission` (PBIS) - Imported from PPM building_info_submission table
- `cs_landlord_import_results` - Import logs and statistics
- `ppm_building_info_submission_import_results` - Import logs and statistics
- `missing_ppm_landlords_export_into_cs_export_results` - Export logs and statistics

### CompStak Services Database Tables
- `landlords` - Main landlords table
- `landlord_display_name_mapping` - Display name mappings
- `landlord_display_name` - Display names

### PPM Database Tables
- `building_info_submission` - Building information with owner data in JSON format

## Data Processing Workflow

### 1. Landlord Import Process
- **Source**: CompStak Services `landlords` table
- **Destination**: Entity Ownership `cs_landlords` table
- **Trigger**: API endpoint `/compstak-services/landlords/import`
- **Frequency**: Automated cronjob runs every hour

### 2. Building Info Import Process
- **Source**: PPM `building_info_submission` table
- **Destination**: Entity Ownership `ppm_building_info_submission` table
- **Data Processing**: JSON data from `cherre` column parsed into `cherre_owners` column
- **Trigger**: API endpoint `/ppm/building-info-submission/import`

### 3. Owner Matching and Export Process
- **Process**: Compare owner names between CSL and PBIS tables
- **Matching Logic**: 
  - If match found: Link Recorded Owner to corresponding raw landlord ID
  - If no match found: Create new raw landlord record
- **Export**: New landlord records exported to CompStak Services DB
- **Trigger**: API endpoint `/landlords/export-missing-ppm-landlords-into-compstak-services`

## API Endpoints for Testing

### 1. Landlord Import
```
POST /compstak-services/landlords/import
```

**Request Body Parameters:**
```json
{
  "lastUpdated": "2025-04-09T09:20:30Z",  // lastupdated/date_created in mysql.landlords table
  "maxJobDurationInMinutes": 2            // desired duration job run
}
```

### 2. Building Info Import
```
POST /ppm/building-info-submission/import
```

**Request Body Parameters:**
```json
{
  "lastUpdated": "2025-04-29T15:20:51.705391977Z",  // lastupdated/created date in ppm.building_info_submission table
  "maxJobDurationInMinutes": 1                      // desired duration job run
}
```

### 3. Export Missing PPM Landlords
```
POST /landlords/export-missing-ppm-landlords-into-compstak-services
```

**Request Body Parameters:**
```json
{
  "landlordLastUpdated": "2025-04-13T10:48:51.705391977Z",           // lastupdated date in oes.cs_landlords
  "buildingInfoSubmissionLastUpdated": "2025-04-13T10:48:51.705391977Z", // lastupdated date in oes.ppm_building_info_submissions table
  "maxJobDurationInMinutes": 3                                        // desired duration job run
}
```

## Testing Requirements

### Prerequisites
- Postman access
- CompStak Services MySQL DB access
- PPM PostgreSQL DB access
- Entity Ownership PostgreSQL DB access
- (Optional) Admin account with access to PPM page

### Testing Objectives
1. **Data Import Validation**: Verify all appropriate data is imported, parsed, and exported
2. **Automated Process Validation**: Ensure automated cronjob runs properly
3. **Data Integrity**: Validate correct number of rows imported/exported/ignored

## Testing Workflows

### Testing Landlord Import
1. Create new landlord entries on the PPM application
2. Check the CompStak Services landlord table
3. Run the landlords import API call
4. Check the Entity Ownership cs_landlords table for new landlord entries

### Testing PBIS Owner Export
1. Edit several rows of data in the PBIS table
   - In the `cherre_owners` column, edit the pairs under `OwnerName`
2. Run the export API call
3. Check the CompStak Services DB - there should be new rows in the landlord table with the edited OwnerNames

## Monitoring and Validation

### Log Tables
Use these tables to validate import/export operations:

1. **`cs_landlord_import_results`** - Landlord import statistics
2. **`ppm_building_info_submission_import_results`** - Building info import statistics  
3. **`missing_ppm_landlords_export_into_cs_export_results`** - Export statistics

### Key Metrics to Monitor
- Number of rows updated
- Number of failed updates
- Import/export durations
- Data consistency between source and destination

## SQL Queries for Testing

### 1. Find Unmatched Owner Names
```sql
SELECT bis.ownerName
FROM
  (SELECT trim(JSONB_ARRAY_ELEMENTS(cherre_owners) ->> 'ownerName') ownerName
   FROM ppm_building_info_submissions
   WHERE last_updated > $lu0 OR created > $lu0) bis LEFT JOIN
  (SELECT id, name
   FROM cs_landlords
   WHERE last_updated > $lu1) l ON lower(bis.ownerName) = lower(trim(l.name))
WHERE l.id IS NULL
```

### 2. Query PPM Building Info Submissions
```sql
SELECT
  legacy_property_id,
  created,
  last_updated,
  cherre -> 'submissionPayload' -> 'owners' AS cherre_owners
FROM building.building_info_submission
WHERE cherre IS NOT NULL
  AND cherre -> 'submissionPayload' -> 'owners' IS NOT NULL 
  AND (last_updated > $lu OR created > $lu)
```

### 3. Query CompStak Services Landlords
```sql
SELECT
  l.id,
  l.name,
  ldn.name AS display_name,
  l.date_created,
  l.last_updated
FROM landlord l
  LEFT JOIN landlord_display_name_mapping ldnm ON l.id = ldnm.landlord_id
  LEFT JOIN landlord_display_name ldn ON ldnm.landlord_display_name_id = ldn.id
WHERE l.deleted = 0 
      AND l.last_updated > $lu
```

## Automation

### Cronjob Schedule
- **Frequency**: Every hour
- **Purpose**: Pick up changes in CompStak Services landlords table and PPM building_info_submission table
- **Process**: New records and changes to existing records are caught and processed

### Data Synchronization
- **Real-time**: Changes are detected and processed automatically
- **Batch Processing**: Large datasets are processed in batches with configurable duration limits
- **Error Handling**: Failed operations are logged for investigation

## Test Cases

### Allure Test Management
Test cases for this project are available in Allure TestOps:
[OES Test Cases in Allure](https://alluretestops.infra.csinfra.zone/project/7/test-cases?treeId=20&search=W3siaWQiOiJjZnYuMyIsInZhbHVlIjpbMzM4M10sImxhYmVsIjpbIk93bmVyc2hpcCBFbnRpdHkgU2VydmljZSJdLCJ0eXBlIjoibG9uZ0FycmF5In1d)

### Test Categories
1. **Import Testing**: Validate data import from source systems
2. **Processing Testing**: Verify data parsing and matching logic
3. **Export Testing**: Ensure correct data export to target systems
4. **Integration Testing**: End-to-end workflow validation
5. **Performance Testing**: Validate system performance under load

## Troubleshooting

### Common Issues
1. **Import Failures**: Check source database connectivity and data format
2. **Matching Failures**: Verify owner name parsing and comparison logic
3. **Export Failures**: Validate target database permissions and constraints
4. **Performance Issues**: Monitor job duration limits and database performance

### Debugging Steps
1. Check log tables for error messages
2. Verify API endpoint responses
3. Validate database connectivity
4. Review cronjob execution logs
5. Check data consistency between systems

## Related Documentation

### Google Docs
- [Project Plan and Execution Steps](https://docs.google.com/document/d/1SABisCPHPiWuuynlojCi_73t33aeTevbNqxp-o7PIkc/edit?pli=1&tab=t.nhdkt6w8z33q#heading=h.7m2fnhwcw4j7)
- [Project One-Pager](https://docs.google.com/document/d/1SABisCPHPiWuuynlojCi_73t33aeTevbNqxp-o7PIkc/edit?pli=1&tab=t.4g6v55lacf51#heading=h.7m2fnhwcw4j7)

### Test Management
- [Allure Test Cases](https://alluretestops.infra.csinfra.zone/project/7/test-cases?treeId=20&search=W3siaWQiOiJjZnYuMyIsInZhbHVlIjpbMzM4M10sImxhYmVsIjpbIk93bmVyc2hpcCBFbnRpdHkgU2VydmljZSJdLCJ0eXBlIjoibG9uZ0FycmF5In1d)

---

*Documentation retrieved from CompStak Atlassian Confluence - Testing the Ownership Entity System (OES)*
