# Harvest Project - Technical Requirements

## 🔧 System Architecture

### High-Level Architecture
```
┌─────────────────────────────────────────────────────────────┐
│                    Project Harvest Architecture             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────┐    ┌──────────────────────────────────┐│
│  │ Configuration   │    │        Harvesting Service        ││
│  │ Management      │───▶│                                  ││
│  │ Service         │    │  ┌─────────────┐ ┌─────────────┐ ││
│  │                 │    │  │   Search    │ │  Download   │ ││
│  │ - Search Hints  │    │  │   Engine    │ │   Manager   │ ││
│  │ - Domains       │    │  └─────────────┘ └─────────────┘ ││
│  │ - Schedule      │    │                                  ││
│  │ - URL Paths     │    │  ┌─────────────┐ ┌─────────────┐ ││
│  └─────────────────┘    │  │  Duplicate  │ │  Metadata   │ ││
│                         │  │  Detection  │ │  Manager    │ ││
│                         │  └─────────────┘ └─────────────┘ ││
│                         └──────────────────────────────────┘│
│                                      │              │       │
│                                      ▼              ▼       │
│  ┌─────────────────┐    ┌─────────────────┐ ┌─────────────┐ │
│  │ Google Search   │    │   S3 Storage    │ │  Postgres   │ │
│  │ API             │    │   - Files       │ │  Database   │ │
│  │                 │    │   - Metadata    │ │  - Metadata │ │
│  └─────────────────┘    └─────────────────┘ └─────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## 📋 Functional Requirements

### 1. File Harvesting Service (AP-20649)

#### 1.1 Search Functionality
**Requirement**: Automated web searching for OM documents
- **Input**: Configurable search hints and target domains
- **Process**: Google Search API queries at regular intervals
- **Output**: List of candidate file URLs for download

**Technical Specifications**:
- Support for multiple search hint combinations
- Domain-specific query construction
- Rate limiting compliance with Google Search API
- Query result parsing and URL extraction
- Search result ranking and prioritization

#### 1.2 File Download & Storage
**Requirement**: Download candidate files and store in S3
- **Input**: Validated candidate file URLs
- **Process**: HTTP download with error handling and retry logic
- **Output**: Files stored in S3 with generated metadata

**Technical Specifications**:
- Concurrent download capability (configurable limit)
- File type validation (PDF, DOC, DOCX primarily)
- Size limit enforcement (configurable maximum)
- S3 bucket organization by date/source
- Upload verification and integrity checking

#### 1.3 Metadata Management
**Requirement**: Store comprehensive file metadata in Postgres
- **Input**: Downloaded file information and source data
- **Process**: Extract and persist metadata fields
- **Output**: Searchable metadata records in database

**Required Metadata Fields**:
```sql
CREATE TABLE harvest_files (
    id SERIAL PRIMARY KEY,
    filename VARCHAR(255) NOT NULL,
    original_url TEXT NOT NULL,
    source_domain VARCHAR(100) NOT NULL,
    file_hash VARCHAR(64) UNIQUE NOT NULL,
    file_size BIGINT NOT NULL,
    s3_location TEXT NOT NULL,
    download_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    search_query TEXT,
    content_type VARCHAR(50),
    processing_status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### 1.4 Duplicate Detection
**Requirement**: Prevent duplicate file ingestion
- **Input**: File hash and URL information
- **Process**: Check existing records before download
- **Output**: Skip duplicates or update metadata for existing files

**Technical Specifications**:
- SHA-256 hash calculation for file content
- URL normalization for duplicate detection
- Database constraints to prevent duplicate entries
- Graceful handling of hash collisions
- Metadata update for re-discovered files

### 2. Configuration Management Service (AP-20665)

#### 2.1 Dynamic Configuration
**Requirement**: Manage search parameters without code deployment
- **Input**: Configuration updates via API or config file
- **Process**: Validate and apply new configuration
- **Output**: Updated service behavior using new parameters

**Configuration Schema**:
```json
{
  "search_config": {
    "search_hints": [
      "offering memorandum",
      "OM",
      "property information"
    ],
    "target_domains": [
      "example-broker.com",
      "commercial-listings.com"
    ],
    "target_url_patterns": [
      "*/documents/*",
      "*/listings/*/files/*"
    ],
    "excluded_domains": [
      "social-media-site.com"
    ]
  },
  "schedule_config": {
    "search_frequency_minutes": 60,
    "max_concurrent_downloads": 10,
    "daily_search_limit": 1000
  },
  "file_config": {
    "max_file_size_mb": 50,
    "allowed_extensions": [".pdf", ".doc", ".docx"],
    "s3_bucket": "harvest-documents-prod"
  }
}
```

#### 2.2 Configuration Validation
**Requirement**: Ensure configuration integrity
- **Input**: New configuration parameters
- **Process**: Validate against schema and business rules
- **Output**: Accepted configuration or error messages

**Validation Rules**:
- Search hints must be non-empty strings
- Domains must be valid hostnames
- Frequency must be between 5-1440 minutes
- File size limits must be positive integers
- S3 bucket must exist and be accessible

#### 2.3 Configuration Monitoring
**Requirement**: Track configuration changes and impact
- **Input**: Configuration change events
- **Process**: Log changes and monitor service behavior
- **Output**: Audit trail and performance metrics

## ⚡ Non-Functional Requirements

### 3.1 Performance Requirements
- **Search Latency**: API calls complete within 5 seconds
- **Download Throughput**: Support 50 concurrent downloads
- **Database Performance**: Metadata queries under 100ms
- **Configuration Updates**: Applied within 30 seconds

### 3.2 Scalability Requirements
- **Daily Volume**: Process 10,000 candidate files
- **Storage Growth**: Support 100GB daily ingestion
- **Database Records**: Handle 1M+ metadata records
- **Concurrent Users**: Support 5+ configuration managers

### 3.3 Reliability Requirements
- **Uptime**: 99.5% availability during business hours
- **Error Recovery**: Automatic retry for transient failures
- **Data Integrity**: Zero data loss for successfully stored files
- **Backup Strategy**: Daily metadata backups, S3 versioning

### 3.4 Security Requirements
- **Authentication**: API key-based access to Google Search
- **Authorization**: Role-based access to configuration
- **Encryption**: TLS for all external communications
- **Data Protection**: Encryption at rest for S3 storage

## 🔗 Integration Requirements

### 4.1 External Service Dependencies

#### Google Search API
- **Purpose**: Source of candidate file URLs
- **Requirements**: 
  - Valid API credentials and quotas
  - Rate limiting compliance
  - Error handling for API failures
  - Query optimization for relevant results

#### Amazon S3
- **Purpose**: File storage repository
- **Requirements**:
  - Configured bucket with appropriate permissions
  - Lifecycle policies for storage optimization
  - Versioning enabled for data protection
  - Access logging for audit purposes

#### PostgreSQL Database
- **Purpose**: Metadata and configuration storage
- **Requirements**:
  - Dedicated database schema
  - Connection pooling for performance
  - Backup and recovery procedures
  - Monitoring for performance metrics

### 4.2 Internal Service Integration

#### Monitoring & Logging
- **Metrics Collection**: Service performance and business metrics
- **Log Aggregation**: Centralized logging for troubleshooting
- **Alerting**: Notifications for critical failures
- **Dashboards**: Real-time service health visibility

#### Configuration Management
- **Service Discovery**: Dynamic configuration source detection
- **Change Notifications**: Real-time config update propagation
- **Rollback Capability**: Safe configuration change reversal
- **Validation Pipeline**: Automated config testing

## 📊 Data Flow Requirements

### 5.1 Search Process Flow
1. **Configuration Loading**: Retrieve current search parameters
2. **Query Construction**: Build search queries using hints and domains
3. **API Execution**: Execute Google Search API calls
4. **Result Processing**: Parse and validate candidate URLs
5. **Duplicate Checking**: Verify URLs against existing records
6. **Queue Management**: Add new candidates to download queue

### 5.2 Download Process Flow
1. **URL Validation**: Verify candidate URL accessibility
2. **File Download**: Retrieve file content with error handling
3. **Content Validation**: Verify file type and size limits
4. **Hash Calculation**: Generate SHA-256 hash for deduplication
5. **S3 Upload**: Store file with metadata in S3
6. **Database Insert**: Persist metadata in Postgres
7. **Status Update**: Mark processing complete or failed

### 5.3 Configuration Update Flow
1. **Change Detection**: Monitor configuration sources
2. **Validation**: Verify new configuration against schema
3. **Application**: Apply validated configuration to services
4. **Verification**: Confirm configuration changes took effect
5. **Logging**: Record configuration change audit trail
6. **Monitoring**: Track impact on service behavior

## 🛠️ Development Requirements

### 6.1 Technology Stack
- **Language**: Python 3.9+ (recommended for libraries and AWS SDK)
- **Framework**: FastAPI or Flask for API endpoints
- **Database**: PostgreSQL 13+ with SQLAlchemy ORM
- **Cloud Services**: AWS S3, EC2/ECS for hosting
- **Monitoring**: CloudWatch, Prometheus, or similar
- **Configuration**: YAML/JSON with validation schemas

### 6.2 Code Quality Standards
- **Testing**: 90%+ code coverage with unit and integration tests
- **Documentation**: Comprehensive API documentation with examples
- **Linting**: PEP 8 compliance with automated checking
- **Security**: Static analysis with dependency vulnerability scanning
- **Version Control**: Git with feature branch workflow

### 6.3 Deployment Requirements
- **Containerization**: Docker containers for consistent deployment
- **Orchestration**: Kubernetes or ECS for service management
- **CI/CD**: Automated testing and deployment pipeline
- **Environment Management**: Separate dev/staging/production configs
- **Rollback Strategy**: Quick rollback capability for failed deployments

---

*These technical requirements provide the foundation for developing, testing, and deploying Project Harvest Phase I successfully.*
