workspace "MMAR Architecture" "C4 model for MMAR Platform" {
    // !include container.dsl
    model {
        // People (external users)
        Creator = person "Creator" "Metamodel designer who defines new modeling languages (metamodels)."
        End_User = person "End User" "Model designer who creates models based on defined metamodels."
        

        // Software Systems (high-level)
        MMAR = softwareSystem "MMAR" "Toolset for designing & managing metamodels & models." {
            ModelingClient = container "MMAR Modeling Client" "Client for model creation based on metamodels" "Aurelia/TypeScript/Three.js/Node.js" "ModelingClient" {
                
                
            }

            MetamodelingClient = container "MMAR Metamodeling Client" "Desktop/Web Client for metamodel design" "Aurelia/TypeScript/Node.js" "MetamodelingClient" {
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

            VizRepClient = container "MMAR VizRep Client" "Client for visual representation design of metamodel elements" "Aurelia/TypeScript/Three.js/Node.js" "VizRepClient" {
                // Components for visualization design would go here
            }

            APIServer = container "MMAR API Server" "Backend server providing REST APIs for MMAR clients" "Express.js/Node.js" "API_Server" {
                // Controller layer
                metaObjectsController = component "Metamodel Objects Controller" "Handles REST API requests for base metamodel objects" "TypeScript, Express.js"
                metaClassesController = component "Metamodel Classes Controller" "Handles REST API requests for metamodel classes" "TypeScript, Express.js"
                metaRelationClassesController = component "Metamodel Relation Classes Controller" "Handles REST API requests for relation classes" "TypeScript, Express.js"
                metaAttributesController = component "Metamodel Attributes Controller" "Handles REST API requests for metamodel attributes" "TypeScript, Express.js"
                metaPortsController = component "Metamodel Ports Controller" "Handles REST API requests for metamodel ports" "TypeScript, Express.js" 
                metaSceneTypesController = component "Metamodel Scene Types Controller" "Handles REST API requests for scene types" "TypeScript, Express.js"
                metaFilesController = component "Metamodel Files Controller" "Handles REST API requests for file operations" "TypeScript, Express.js"
                usersController = component "Users Controller" "Handles REST API requests for user management" "TypeScript, Express.js"
                userGroupsController = component "User Groups Controller" "Handles REST API requests for user group management" "TypeScript, Express.js"
                
                // Data access layer
                metaObjectsConnection = component "Metamodel Objects Connection" "Implements CRUD operations for metamodel objects" "TypeScript, PostgreSQL client"
                metaClassesConnection = component "Metamodel Classes Connection" "Implements CRUD operations for metamodel classes" "TypeScript, PostgreSQL client"
                metaRelationClassesConnection = component "Metamodel Relation Classes Connection" "Implements CRUD operations for relation classes" "TypeScript, PostgreSQL client"
                metaAttributesConnection = component "Metamodel Attributes Connection" "Implements CRUD operations for attributes" "TypeScript, PostgreSQL client"
                metaPortsConnection = component "Metamodel Ports Connection" "Implements CRUD operations for ports" "TypeScript, PostgreSQL client"
                metaSceneTypesConnection = component "Metamodel Scene Types Connection" "Implements CRUD operations for scene types" "TypeScript, PostgreSQL client"
                metaFilesConnection = component "Metamodel Files Connection" "Implements CRUD operations for files" "TypeScript, PostgreSQL client"
                usersConnection = component "Users Connection" "Implements CRUD operations for users" "TypeScript, PostgreSQL client"
                
                // Service layer
                imageService = component "Image Service" "Handles image processing like compression" "TypeScript, Sharp"
                objectFilterService = component "Object Filter Service" "Filters response objects based on query parameters" "TypeScript"
                authService = component "Authentication Service" "Handles user authentication and authorization" "TypeScript, JWT"
                databaseService = component "Database Connection Service" "Manages database connection pools" "TypeScript, pg"
                
                // Middleware
                errorHandlerMiddleware = component "Error Handler Middleware" "Processes and formats API errors" "TypeScript, Express.js"
                authMiddleware = component "Authentication Middleware" "Verifies user authentication tokens" "TypeScript, Express.js"
                
                // Controller to Connection relationships
                metaObjectsController -> metaObjectsConnection "Performs CRUD operations via"
                metaClassesController -> metaClassesConnection "Delegates data management to"
                metaRelationClassesController -> metaRelationClassesConnection "Persists relation class data through"
                metaAttributesController -> metaAttributesConnection "Manages attribute data via"
                metaPortsController -> metaPortsConnection "Handles port persistence through"
                metaSceneTypesController -> metaSceneTypesConnection "Stores scene type data using"
                metaFilesController -> metaFilesConnection "Persists file metadata and content with"
                usersController -> usersConnection "Manages user accounts through"
                userGroupsController -> usersConnection "Administers group memberships via"

                // Controllers to Service relationships
                metaFilesController -> imageService "Processes and optimizes images with"
                metaObjectsController -> objectFilterService "Applies response filtering using"
                metaClassesController -> objectFilterService "Tailors response content via"
                metaRelationClassesController -> objectFilterService "Customizes response fields with"
                metaAttributesController -> objectFilterService "Formats attribute responses through"
                metaPortsController -> objectFilterService "Selectively exposes port data using"
                metaSceneTypesController -> objectFilterService "Filters scene type responses via"

                // Connection to Service relationships
                metaObjectsConnection -> databaseService "Executes SQL queries through"
                metaClassesConnection -> databaseService "Manages database connections via"
                metaRelationClassesConnection -> databaseService "Runs transactions using"
                metaAttributesConnection -> databaseService "Acquires connection pools from"
                metaPortsConnection -> databaseService "Executes parameterized queries via"
                metaSceneTypesConnection -> databaseService "Performs database operations through"
                metaFilesConnection -> databaseService "Stores binary data using"
                usersConnection -> databaseService "Retrieves user records from"

                // Middleware relationships
                authMiddleware -> authService "Validates authentication tokens with"
                usersController -> authMiddleware "Secures endpoints using"
                metaObjectsController -> errorHandlerMiddleware "Delegates error processing to"
                metaClassesController -> errorHandlerMiddleware "Centralizes error handling with"
                metaRelationClassesController -> errorHandlerMiddleware "Formats error responses via"
                metaAttributesController -> errorHandlerMiddleware "Standardizes error outputs through"
                metaPortsController -> errorHandlerMiddleware "Reports operational failures to"
                metaSceneTypesController -> errorHandlerMiddleware "Processes exceptions with"
                metaFilesController -> errorHandlerMiddleware "Handles upload/download errors through"
            }

            Database = container "MMAR Database" "Database for persisting metamodels, models, and logs" "PostgreSQL" "Database"

            GlobalDS = container "Global Data Structure Library" "Shared data model library (domain classes for models/metamodels)" "TypeScript" "GlobalDS" {
                // Global data structure components would go here if we had more information
            }

            // Container Relationships
            VizRepClient -> APIServer "Uses API for visualization config ops"
            ModelingClient -> APIServer "Uses API for model operations"
            APIServer -> Database "Reads/Writes metamodels, models, logs"
            MetamodelingClient -> GlobalDS "Embedded data definitions"
            VizRepClient -> GlobalDS "Embedded data definitions"
            ModelingClient -> GlobalDS "Embedded data definitions"
            backendService -> APIServer "Uses API for metamodel operations"
            APIServer -> GlobalDS "Uses for data structures"
        }


        // Software System Relationships
        Creator -> VizRepClient "uses to design visualization of metamodel elements"
        Creator -> MetamodelingClient "uses to create and manage metamodels"
        End_User -> ModelingClient "uses to create models based on metamodels"
        
    }
    views {
        systemContext MMAR "SystemContextDiagram" {
            include * 
            autoLayout lr
            title "System Context: MMAR Metamodeling vs. Modeling Systems"
            description "Creators and End Users interact with two facets of the MMAR platform. Creators design metamodels (and their visual representations) using the Metamodeling System, while End Users create models using the Modeling System. Both systems rely on a common MMAR Server and Database backend."
        }
        container MMAR "ContainerDiagram" {
            include *
            // autoLayout lr
            title "Container Diagram: MMAR Clients, Backend and Database"
            description "The MMAR platform consists of three main clients (Modeling, Metamodeling, and VizRep) that connect to a common backend server. The server provides REST APIs for metamodel and model operations, while the database stores all relevant data."
        }

        component MetamodelingClient "MetamodelingClientComponents" {
            include *
            autoLayout lr
            title "Component Diagram: MMAR Metamodeling Client"
            description "The MMAR Metamodeling Client consists of various components for managing selected objects, communicating with the backend, and providing a rich user interface for metamodel design."
        }
        
        component APIServer "APIServerComponents" {
            include *
            autoLayout tb
            title "Component Diagram: MMAR API Server"
            description "The MMAR API Server consists of controllers that handle HTTP requests, connection classes for database operations, and shared services. The architecture follows a layered design with controllers, data access, and service layers."
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

            element "Database" {
                shape Cylinder
                background #85bbf0
                color #000000
            }

            element "API_Server" {
                shape Pipe
                background #85bbf0
                color #000000
            }

            element "GlobalDS" {
                shape Component
                background #85bbf0
                color #000000
            }

            element "MetamodelingClient" {
                shape WebBrowser
                background #f0ad4e
                color #ffffff
            }

            element "ModelingClient" {
                shape WebBrowser
                background #5bc0de
                color #ffffff
            }

            element "VizRepClient" {
                shape WebBrowser
                background #d9534f
                color #ffffff
            }
        }

    }
}