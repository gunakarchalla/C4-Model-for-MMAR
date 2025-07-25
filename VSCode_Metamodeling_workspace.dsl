workspace "Metamodeling Client by VS code"{
    model {
        user = person "User" "A user who works with metamodels"
        
        group "MMAR System" {
            mmSystem = softwareSystem "MMAR Metamodeling System" "System for creating and managing metamodels" {
                mmClient = container "MMAR Metamodeling Client" "Web-based client for interacting with metamodels" "Aurelia 2, TypeScript" {
                    // Core services
                    selectedObjectService = component "Selected Object Service" "Manages the currently selected object and publishes events when selection changes" "TypeScript, Aurelia"
                    backendService = component "Backend Service" "Handles communication with the backend server" "TypeScript, HttpClient"
                    helperService = component "Helper Service" "Provides utility functions for file conversion and other tasks" "TypeScript"
                    userService = component "User Service" "Manages user authentication and information" "TypeScript"
                    
                    // UI Components
                    leftNav = component "Left Navigation" "Navigation tree for browsing model objects" "TypeScript, Aurelia"
                    middleBody = component "Middle Body" "Main content area for displaying and editing objects" "TypeScript, Aurelia"
                    rightNav = component "Right Navigation" "Context-specific navigation and options" "TypeScript, Aurelia"
                    
                    // Middle Body Components
                    generalTab = component "General Tab" "Tab displaying general properties of objects" "TypeScript, Aurelia"
                    
                    // Object-specific Components
                    generalTabClass = component "General Tab Class" "Component for displaying and editing class objects" "TypeScript, Aurelia"
                    generalTabFile = component "General Tab File" "Component for displaying and editing file objects" "TypeScript, Aurelia"
                    generalTabRelationclass = component "General Tab RelationClass" "Component for displaying and editing relation class objects" "TypeScript, Aurelia"
                    
                    // File-specific Components
                    dialogUploadFile = component "Dialog Upload File" "Dialog for uploading and replacing files" "TypeScript, Aurelia"
                    
                    // Relationships between components
                    leftNav -> selectedObjectService "Updates selected object"
                    middleBody -> selectedObjectService "Observes selected object"
                    generalTab -> selectedObjectService "Reads selected object properties"
                    generalTabFile -> helperService "Uses for file conversion"
                    generalTabFile -> selectedObjectService "Reads file data"
                    dialogUploadFile -> helperService "Uses for file conversion"
                    dialogUploadFile -> selectedObjectService "Updates file data"
                    backendService -> selectedObjectService "Updates object collections"
                    
                    // Service interactions
                    selectedObjectService -> backendService "Requests object data"
                }
                
                backendSystem = container "MMAR Backend Server" "Server that stores and processes metamodel data" "Unknown Technology" {
                    // Backend components would go here if we had more information
                }
                
                // Container relationships
                mmClient -> backendSystem "Makes API calls to" "HTTP/REST"
            }
        }
        
        user -> mmSystem "Creates and manages metamodels using"
    }
    
    views {
        systemContext mmSystem "SystemContext" {
            include *
            autoLayout
        }
        
        container mmSystem "Containers" {
            include *
            autoLayout
        }
        
        component mmClient "Components" {
            include *
            autoLayout
        }
        
        theme default
        
        styles {
            element "Person" {
                shape Person
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
        }
    }
}