# Folders Project - Phase 1

## 📋 Project Overview

**Epic**: [AP-20446](https://compstak.atlassian.net/browse/AP-20446) - Folders - Phase 1  
**Status**: In Progress  
**Reporter**: Cameron Wissak  
**Created**: August 6, 2025  
**Last Updated**: August 19, 2025

## 🎯 Project Scope

### **Phase 1: Lease Comps Only**
This project implements folder management functionality for lease comps in the CompStak platform.

## 📚 Documentation & Resources

### **Requirements & Design**
- **Requirements Document**: [Google Docs](https://docs.google.com/document/d/1rtKQ9IMbidst8gMamR0R91dodmFj28OSsEgC7vHXwDQ/edit?tab=t.0)
- **Design**: [Figma Design](https://www.figma.com/design/Xxa4wFXvnSLmk8nTsV3dha/Folders?node-id=1-2&p=f&t=K7KFlGefgxMncGFC-0)
- **Prototypes**: [Figma Prototype](https://www.figma.com/proto/Xxa4wFXvnSLmk8nTsV3dha/Folders?node-id=1-46888&t=WA7KSvu2jnL4pLea-0&scaling=scale-down&content-scaling=fixed&page-id=1%3A2&starting-point-node-id=1%3A46888&show-proto-sidebar=1)
- **Architecture**: [Lucid Chart](https://lucid.app/lucidchart/09cabf00-4850-478b-9134-2aecb07f5762/edit?viewport_loc=-1309%2C-1205%2C1798%2C941%2CBzhCV9SW5pfq&invitationId=inv_00e1f0ad-8307-4790-b6f9-204ae589a2fc)

## 🚀 Features

### **Core Functionality**
1. **Add comps to a folder from list view**
2. **Add comps to a folder from the lease detail view**
3. **View a folder and remove comps from a folder**
4. **Create a new folder**
5. **Rename a Folder**
6. **Delete a Folder**

## 📋 Related JIRA Tickets

### **Epic**
- **AP-20446** - Folders - Phase 1 (In Progress)

### **Stories**
- **AP-20465** - Phase 1: Create New Folder from Dropdown (To Do)
- **AP-20453** - Phase 1: Rename a Folder (In Progress)
- **AP-20452** - Phase 1: Delete a Folder (In Progress)
- **AP-20450** - Phase 1: Add lease comp to a folder from lease detail view (Peer review)
- **AP-20449** - Phase 1: View a folder/remove comps from a folder (To Do)
- **AP-20447** - Phase 1: Add lease comps to new or existing folders from List View (To Do)

## 🧪 Testing Strategy

### **Test Scenarios**
1. **Folder Creation**
   - Create new folder from dropdown
   - Validate folder name requirements
   - Test duplicate folder names

2. **Folder Management**
   - Rename existing folders
   - Delete folders (with confirmation)
   - Handle folders with existing comps

3. **Comp Management**
   - Add comps from list view
   - Add comps from lease detail view
   - Remove comps from folders
   - View folder contents

4. **User Experience**
   - Navigation between folders
   - Folder selection and highlighting
   - Error handling and validation

### **Test Environments**
- **Dev**: Development testing
- **Staging**: Pre-production validation
- **Production**: Live environment testing

## 📊 Quality Metrics

### **Test Coverage Goals**
- **Functional Testing**: 100% of core features
- **UI/UX Testing**: All user interactions
- **Integration Testing**: API and data flow
- **Performance Testing**: Load and response times

### **Acceptance Criteria**
- All folder operations work correctly
- User interface matches design specifications
- Performance meets requirements
- No critical bugs in production

## 🔧 Technical Requirements

### **Frontend**
- React components for folder management
- State management for folder operations
- API integration for CRUD operations

### **Backend**
- Folder CRUD API endpoints
- Comp-folder relationship management
- User permission validation

### **Database**
- Folder table structure
- Comp-folder relationship table
- User-folder permissions

## 📈 Project Timeline

### **Phase 1 Status**
- **Requirements**: ✅ Complete
- **Design**: ✅ Complete
- **Development**: 🔄 In Progress
- **Testing**: ⏳ Pending
- **Deployment**: ⏳ Pending

## 🚨 Known Issues & Risks

### **Technical Risks**
- Folder permission management complexity
- Performance with large numbers of comps
- Data consistency during concurrent operations

### **Mitigation Strategies**
- Comprehensive testing of edge cases
- Performance monitoring and optimization
- Proper error handling and user feedback

## 📞 Contact Information

- **Project Lead**: Cameron Wissak
- **JIRA Epic**: [AP-20446](https://compstak.atlassian.net/browse/AP-20446)
- **Team**: Helios (based on labels)

---

*Last Updated: 2025-01-27*
