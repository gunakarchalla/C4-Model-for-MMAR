workspace "MMAR Architecture" "C4 model for MMAR Platform" {
    model {
        // People (external users)
        Creator = person "Creator" "Metamodel designer who defines new modeling languages (metamodels)."
        End_User = person "End User" "Model designer who creates models based on defined metamodels."
        

        // Software Systems (high-level)
        MMAR = softwareSystem "MMAR" "Toolset for designing & managing metamodels & models." {
            ModelingClient = container "MMAR Modeling Client" "Client for model creation based on metamodels" "Aurelia/TypeScript/Three.js/Node.js" "ModelingClient" {
                // Core Services
                fetchHelperService = component "FetchHelper Service" "Handles communication with the backend server" "TypeScript"
                loggerService = component "Logger Service" "Centralized logging system for tracking operations and errors" "TypeScript"
                instanceUtilityService = component "Instance Utility Service" "Manages model instances and their operations" "TypeScript"
                metaUtilityService = component "Meta Utility Service" "Provides utilities for working with metamodel elements" "TypeScript"
                hybridAlgorithmsService = component "Hybrid Algorithms Service" "Handles execution of special algorithms across instances" "TypeScript"
                mSelectedObjectService = component "Global Selected Object Service" "Manages the currently selected object and its state" "TypeScript"
                stateObjectService = component "Global State Object Service" "Manages application state and state transitions" "TypeScript"
                dialogHelperService = component "Dialog Helper Service" "Manages dialog creation and interaction" "TypeScript"
                
                // UI Components
                mLeftNav = component "Left Navigation" "Navigation panel for browsing model objects" "TypeScript, Aurelia"
                mMiddleBody = component "Middle Body" "Main content area for displaying and editing 3D models" "TypeScript, Aurelia"
                mRightNav = component "Right Navigation" "Panel for context-specific options and properties" "TypeScript, Aurelia"
                topNavBar = component "Top Navigation Bar" "Main application navigation and actions" "TypeScript, Aurelia"
                attributeWindow = component "Attribute Window" "Window for editing object attributes" "TypeScript, Aurelia"
                threeCanvas = component "Three Canvas" "3D canvas for model visualization and interaction" "TypeScript, Three.js"
                logWindow = component "Log Window" "Window displaying application logs and messages" "TypeScript, Aurelia"
                stateWindow = component "State Window" "Window for managing state transitions" "TypeScript, Aurelia"
                classButtonGroup = component "Class Button Group" "UI component for selecting classes" "TypeScript, Aurelia"
                relationClassButtonGroup = component "Relation Class Button Group" "UI component for selecting relation classes" "TypeScript, Aurelia"
                
                // Dialog Components
                mDialogUploadFile = component "Dialog Upload File" "Dialog for uploading files to the model" "TypeScript, Aurelia"
                dialogUploadImage = component "Dialog Upload Image" "Dialog for uploading images" "TypeScript, Aurelia"
                dialogUploadGltf = component "Dialog Upload GLTF" "Dialog for uploading 3D models" "TypeScript, Aurelia"
                dialogAttributeWindow = component "Dialog Attribute Window" "Dialog for editing attributes" "TypeScript, Aurelia"
                dialogReferenceAttribute = component "Dialog Reference Attribute" "Dialog for editing reference attributes" "TypeScript, Aurelia"
                dialogTableAttribute = component "Dialog Table Attribute" "Dialog for editing table attributes" "TypeScript, Aurelia"
                dialogCreateNewScene = component "Dialog Create New Scene" "Dialog for creating new scenes" "TypeScript, Aurelia"
                dialogCopyScene = component "Dialog Copy Scene" "Dialog for copying scenes" "TypeScript, Aurelia"
                dialogSaveAs = component "Dialog Save As" "Dialog for saving models" "TypeScript, Aurelia"
                dialogImportModel = component "Dialog Import Model" "Dialog for importing models" "TypeScript, Aurelia"
                dialogImportMetamodel = component "Dialog Import Metamodel" "Dialog for importing metamodels" "TypeScript, Aurelia"
                dialogAlgorithm = component "Dialog Algorithm" "Dialog for configuring and running algorithms" "TypeScript, Aurelia"
                
                // Service relationships
                hybridAlgorithmsService -> instanceUtilityService "Uses to apply algorithms to instances"
                
                // UI to Service relationships
                attributeWindow -> hybridAlgorithmsService "Triggers algorithm checks when attributes change"
                attributeWindow -> instanceUtilityService "Retrieves and updates instance attributes"
                attributeWindow -> metaUtilityService "Validates attribute constraints"
                attributeWindow -> fetchHelperService "Saves attribute changes to server"
                threeCanvas -> hybridAlgorithmsService "Updates algorithm-computed attributes"
                mLeftNav -> mSelectedObjectService "Updates currently selected object"
                mMiddleBody -> threeCanvas "Contains for 3D visualization"
                mRightNav -> stateObjectService "Displays and manages state options"
                
                // Dialog relationships
                mDialogUploadFile -> fetchHelperService "Uploads files to server"
                dialogAttributeWindow -> hybridAlgorithmsService "Checks algorithms after attribute changes"
                dialogReferenceAttribute -> hybridAlgorithmsService "Checks algorithms after reference changes"
                dialogCreateNewScene -> instanceUtilityService "Creates new scene instances"
                dialogCreateNewScene -> metaUtilityService "Retrieves scene type definitions"
                dialogCopyScene -> hybridAlgorithmsService "Runs algorithms on copied scene"
                dialogImportModel -> fetchHelperService "Imports model from server"
                attributeWindow -> mDialogUploadFile "Opens for file attribute editing"
                attributeWindow -> dialogReferenceAttribute "Opens for reference attribute editing"
                attributeWindow -> dialogTableAttribute "Opens for table attribute editing"
            }

            MetamodelingClient = container "MMAR Metamodeling Client" "Desktop/Web Client for metamodel design" "Aurelia/TypeScript/Node.js" "MetamodelingClient" {
                // Core services
                mmSelectedObjectService = component "Selected Object Service" "Manages the currently selected object and publishes events when selection changes" "TypeScript, Aurelia"
                backendService = component "Backend Service" "Handles communication with the backend server" "TypeScript, HttpClient"
                helperService = component "Helper Service" "Provides utility functions for file conversion and other tasks" "TypeScript"
                userService = component "User Service" "Manages user authentication and information" "TypeScript"
                    
                // UI Components
                mmLeftNav = component "Left Navigation" "Navigation tree for browsing model objects" "TypeScript, Aurelia"
                mmMiddleBody = component "Middle Body" "Main content area for displaying and editing objects" "TypeScript, Aurelia"
                mmRightNav = component "Right Navigation" "Context-specific navigation and options" "TypeScript, Aurelia"
                    
                // Middle Body Components
                generalTab = component "General Tab" "Tab displaying general properties of objects" "TypeScript, Aurelia"
                    
                // Object-specific Components
                generalTabClass = component "General Tab Class" "Component for displaying and editing class objects" "TypeScript, Aurelia"
                generalTabFile = component "General Tab File" "Component for displaying and editing file objects" "TypeScript, Aurelia"
                generalTabRelationclass = component "General Tab RelationClass" "Component for displaying and editing relation class objects" "TypeScript, Aurelia"
                    
                // File-specific Components
                mmDialogUploadFile = component "Dialog Upload File" "Dialog for uploading and replacing files" "TypeScript, Aurelia"
                    
                // Relationships between components
                mmLeftNav -> mmSelectedObjectService "Updates selected object"
                mmMiddleBody -> mmSelectedObjectService "Observes selected object"
                generalTab -> mmSelectedObjectService "Reads selected object properties"
                generalTabFile -> helperService "Uses for file conversion"
                generalTabFile -> mmSelectedObjectService "Reads file data"
                mmDialogUploadFile -> helperService "Uses for file conversion"
                mmDialogUploadFile -> mmSelectedObjectService "Updates file data"
                backendService -> mmSelectedObjectService "Updates object collections"
                    
                // Service interactions
                mmSelectedObjectService -> backendService "Requests object data"
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
            fetchHelperService -> APIServer "Makes API requests for model operations"
            instanceUtilityService -> GlobalDS "Uses for model instance data structures"
            metaUtilityService -> GlobalDS "Uses for metamodel data structures"
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