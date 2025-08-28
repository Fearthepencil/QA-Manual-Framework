# Project Harvest - Comprehensive Documentation

## 📋 Project Overview

**Project Name**: Harvest  
**Phase**: I (Document Gathering and Classification)  
**Status**: Requirements Review / In Progress  
**Primary Goal**: Establish automated OM (Offering Memorandum) harvesting pipeline  

## 🎯 Business Context

### Strategic Importance
CompStak's competitive advantage lies in comprehensive commercial lease data through crowdsourcing. However, **Offering Memorandums (OMs)** represent a largely untapped data source that competitors like Crexi are already leveraging.

### Market Position
- **Competitor Advantage**: Competitors have amassed hundreds of thousands of OMs
- **Risk**: Losing ground in lease comp coverage  
- **Opportunity**: OMs contain valuable property-level financial data (NOI, cap rates, occupancy)

### Business Value
- **Enhanced Data Coverage**: Access to property financial metrics
- **Advanced Analytics**: Support for deeper property performance insights
- **Sales Comp Enrichment**: More complete view of property performance

## 🎯 Project Goals & Phases

### Phase I Goals (Current)
1. **Automated OM Gathering**: Establish scalable document collection
2. **Classification System**: Dedupe and classify by property type, tenancy structure, lease presence
3. **Metadata Enrichment**: Tag for prioritization and future processing
4. **Target Isolation**: Focus on net-leased and shopping center OMs with active lease data

### Success Metrics
- **Company KPI**: 40,000 active leases in shopping center properties
- **Phase I Targets**:
  - 5,000 net lease OMs with unexpired leases
  - 2,500 shopping center OMs with unexpired leases

### Future Phases
- **Phase II**: Lease comp extraction and integration
- **Phase III**: Property financial data extraction, sales comp enrichment

## 🔧 Technical Architecture

### Core Components

#### 1. File Harvesting Service (AP-20649)
**Purpose**: Continuous web searching and OM ingestion

**Key Features**:
- **Google Search API Integration**: Automated querying with predefined search hints
- **S3 Storage**: Secure file storage for downloaded OMs
- **Postgres Metadata**: Store filename, URL, domain, timestamp, file hash
- **Duplicate Prevention**: Hash/URL checking before ingestion
- **Monitoring/Logging**: Query volume, downloads, error tracking

**Technical Scope**:
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────┐
│   Search Hints  │───▶│ Google Search API │───▶│   S3 Storage│
│   + Site Domains│    └──────────────────┘    └─────────────┘
└─────────────────┘              │                     │
                                 ▼                     ▼
                    ┌──────────────────┐    ┌─────────────────┐
                    │ Candidate Files  │───▶│ Postgres        │
                    │ Download Logic   │    │ Metadata Store  │
                    └──────────────────┘    └─────────────────┘
```

#### 2. Configuration Management Service (AP-20665)
**Purpose**: Dynamic configuration without code redeployment

**Configurable Parameters**:
- **Search Hints**: Keywords like "OM", "offering memorandum"
- **Target Domains**: Specific websites to focus on
- **URL Paths**: Targeted URL patterns
- **Run Frequency**: Scheduling parameters

**Benefits**:
- **Rapid Iteration**: Tune pipeline without deployment
- **Dynamic Updates**: Service respects config changes real-time
- **Audit Trail**: Logging for config changes

## 📊 Expected Deliverables

### Phase I Outputs
1. **Lightweight Pipeline**: Scalable OM location, recording, and classification
2. **Metadata Tagging System**: 
   - Tenant count
   - Property type
   - Document date
   - Source URL
   - Active lease count
   - Sales comp presence
3. **Classification Logic**: Irrelevant files flagged with minimal metadata
4. **Batch Refresh Capability**: Sustainable ongoing intake (not real-time)

## 🚫 Non-Goals

- **Raw OM Exposure**: No client access to raw documents (legal concerns)
- **Search Interface**: No OM discovery UI
- **Real-time Processing**: Batch updates sufficient

## 🔍 Quality Assurance Considerations

### Testing Focus Areas

#### 1. API Integration Testing
- **Google Search API**: Rate limiting, query optimization, error handling
- **S3 Operations**: Upload reliability, storage verification
- **Database Operations**: Metadata persistence, query performance

#### 2. Data Quality Testing
- **Duplicate Detection**: Hash collision testing, URL uniqueness
- **File Classification**: Accuracy of property type detection
- **Metadata Extraction**: Consistency and completeness

#### 3. Configuration Management Testing
- **Dynamic Updates**: Config changes without restart
- **Validation**: Invalid configuration handling
- **Rollback Capability**: Safe config change reversal

#### 4. Performance Testing
- **Search Volume**: High-frequency query handling
- **Download Throughput**: Concurrent file processing
- **Storage Scalability**: Large file volume management

#### 5. Error Handling & Monitoring
- **API Failures**: Graceful degradation strategies
- **Network Issues**: Retry logic and timeout handling
- **Monitoring Accuracy**: Metric collection and alerting

### Test Data Requirements
- **Sample OMs**: Various property types and formats
- **Control Files**: Non-OM documents for classification testing
- **Mock APIs**: Google Search API simulation for testing
- **Configuration Variants**: Different search hint combinations

## 🔗 Related JIRA Tickets

- **[AP-20627](https://compstak.atlassian.net/browse/AP-20627)**: Project Harvest - Phase I (Master Epic)
- **[AP-20649](https://compstak.atlassian.net/browse/AP-20649)**: [BE] File harvesting service (Core Service)
- **[AP-20665](https://compstak.atlassian.net/browse/AP-20665)**: [BE] Config management for Harvest service (Configuration)

## 📅 Timeline & Dependencies

### Current Status
- **AP-20627**: In Progress (Master Epic)
- **AP-20649**: Requirements Review (Core Service)
- **AP-20665**: Requirements Review (Config Management)

### Dependencies
1. **Google Search API Access**: Required for core functionality
2. **S3 Bucket Configuration**: Storage infrastructure setup
3. **Postgres Schema**: Metadata table design and implementation
4. **Configuration Management**: Dynamic parameter system

## 🎯 Success Criteria

### Functional Requirements
- ✅ Service runs continuously with configurable intervals
- ✅ Files downloaded and stored in S3 successfully
- ✅ Metadata persisted in Postgres with required fields
- ✅ Duplicate files skipped without errors
- ✅ Config updates applied without service restart

### Performance Requirements
- **Search Efficiency**: Optimal query frequency vs. result quality
- **Download Speed**: Acceptable file processing throughput
- **Storage Optimization**: Efficient S3 utilization
- **Monitoring Coverage**: Comprehensive metric collection

### Quality Requirements
- **Reliability**: 99%+ uptime for harvesting service
- **Accuracy**: High precision in OM classification
- **Maintainability**: Clear logging and error reporting
- **Scalability**: Handle increasing document volumes

---

*This document serves as the comprehensive project reference for QA testing, development coordination, and stakeholder communication for Project Harvest Phase I.*
