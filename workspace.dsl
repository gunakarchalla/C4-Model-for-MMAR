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
                // Core Services
                vFetchHelperService = component "FetchHelper Service" "Handles communication with the backend server" "TypeScript"
                vLoggerService = component "Logger Service" "Centralized logging system for tracking operations and errors" "TypeScript"
                vInstanceUtilityService = component "Instance Utility Service" "Manages VizRep instances and their operations" "TypeScript"
                vMetaUtilityService = component "Meta Utility Service" "Provides utilities for working with metamodel elements" "TypeScript"
                expressionUtilityService = component "Expression Utility Service" "Evaluates and processes dynamic expressions" "TypeScript"
                vDialogHelperService = component "Dialog Helper Service" "Manages dialog creation and interaction" "TypeScript"
                lineUpdateService = component "Line Update Service" "Manages updates to connection lines between objects" "TypeScript"
    
                // State Management
                vGlobalSelectedObjectService = component "Global Selected Object Service" "Manages the currently selected object state" "TypeScript"
                globalStateObjectService = component "Global State Object Service" "Manages application state and state transitions" "TypeScript"
                globalClassObjectService = component "Global Class Object Service" "Manages metamodel class definitions" "TypeScript"
                globalRelationClassObjectService = component "Global Relation Class Object Service" "Manages relation class definitions" "TypeScript"
    
                // 3D Visualization Services
                graphicContextService = component "Graphic Context Service" "Manages 3D scene and rendering context" "TypeScript, Three.js"
                rayHelperService = component "Ray Helper Service" "Handles raycasting for 3D object selection" "TypeScript, Three.js"
                animatorService = component "Animator Service" "Manages animations and transitions" "TypeScript"
                transformControlService = component "Transform Control Service" "Handles 3D object transformation controls" "TypeScript, Three.js"
    
                // Interaction Handlers
                interactionHandlerService = component "Interaction Handler Service" "Coordinates user interactions with 3D objects" "TypeScript"
                mouseObjectService = component "Mouse Object Service" "Handles mouse interactions and events" "TypeScript"
                keyboardHandlerService = component "Keyboard Handler Service" "Manages keyboard shortcuts and events" "TypeScript"
                resizeService = component "Resize Service" "Handles application resizing events" "TypeScript"
                instanceCreationService = component "Instance Creation Handler" "Manages the creation of new object instances" "TypeScript"
    
                // UI Components
                vThreeCanvas = component "Three Canvas" "3D canvas for visualization design" "TypeScript, Three.js, Aurelia"
                vLeftNav = component "Left Navigation" "Navigation panel for browsing metamodel elements" "TypeScript, Aurelia"
                vRightNav = component "Right Navigation" "Panel for VizRep properties and options" "TypeScript, Aurelia"
                vTopNavBar = component "Top Navigation Bar" "Main application navigation and actions" "TypeScript, Aurelia"
                vMiddleBody = component "Middle Body" "Main content area for designing visual representations" "TypeScript, Aurelia"
                vAttributeWindow = component "Attribute Window" "Window for editing object attributes" "TypeScript, Aurelia"
                codeEditor = component "Code Editor" "Editor for VizRep scripts and expressions" "TypeScript, Aurelia"
                objectList = component "Object List" "List of metamodel objects for visualization" "TypeScript, Aurelia"
                vLogWindow = component "Log Window" "Window displaying application logs" "TypeScript, Aurelia"
                vStateWindow = component "State Window" "Window for managing state transitions" "TypeScript, Aurelia"
                toolbarContainer = component "Toolbar Container" "Container for tool buttons and actions" "TypeScript, Aurelia"
                mainBodyTabBar = component "Main Body Tab Bar" "Navigation tabs for main content area" "TypeScript, Aurelia"
                objectCard = component "Object Card" "Card representation of individual objects" "TypeScript, Aurelia"
                previewButtons = component "Preview Buttons" "Buttons for previewing visual representations" "TypeScript, Aurelia"
                menuEntry = component "Menu Entry" "Menu item component" "TypeScript, Aurelia"
    
                // Dialogs
                vDialogAttributeWindow = component "Dialog Attribute Window" "Dialog for editing attributes" "TypeScript, Aurelia"
                dialogLoadingWindow = component "Dialog Loading Window" "Dialog showing loading progress" "TypeScript, Aurelia"
                userManagementDialog = component "User Management Dialog" "Dialog for managing user permissions" "TypeScript, Aurelia"
    
                // Initializers
                initiator = component "Initiator" "Handles application initialization" "TypeScript"
                sceneInitiator = component "Scene Initiator" "Initializes 3D scene and objects" "TypeScript"
                arInitiator = component "AR Initiator" "Initializes augmented reality features" "TypeScript"
    
                // Core Service Relationships
                vFetchHelperService -> vLoggerService "Logs API requests and responses"
                vInstanceUtilityService -> vFetchHelperService "Makes API requests for instance operations"
                vMetaUtilityService -> vFetchHelperService "Retrieves metamodel definitions"
                expressionUtilityService -> vLoggerService "Logs expression evaluation results"
                lineUpdateService -> graphicContextService "Updates visual connection lines"
    
                // State Management Relationships
                vGlobalSelectedObjectService -> vLoggerService "Logs selection changes"
                globalStateObjectService -> vLoggerService "Logs state transitions"
                globalClassObjectService -> vFetchHelperService "Retrieves class definitions"
                globalRelationClassObjectService -> vFetchHelperService "Retrieves relation class definitions"
    
                // 3D Services Relationships
                graphicContextService -> vThreeCanvas "Renders 3D scene to"
                rayHelperService -> graphicContextService "Performs raycasting on scene objects"
                animatorService -> graphicContextService "Animates scene objects"
                transformControlService -> graphicContextService "Adds transform controls to scene"
    
                // Interaction Handlers Relationships
                interactionHandlerService -> vGlobalSelectedObjectService "Updates selected object state"
                interactionHandlerService -> rayHelperService "Uses for 3D object selection"
                mouseObjectService -> interactionHandlerService "Delegates mouse events to"
                keyboardHandlerService -> interactionHandlerService "Delegates keyboard events to"
                resizeService -> graphicContextService "Resizes 3D viewport"
                instanceCreationService -> vInstanceUtilityService "Creates instances using"
    
                // UI Component Relationships
                vThreeCanvas -> mouseObjectService "Captures mouse events for"
                vThreeCanvas -> keyboardHandlerService "Captures keyboard events for"
                vLeftNav -> vGlobalSelectedObjectService "Updates selected object"
                vRightNav -> vAttributeWindow "Opens attribute editing for selected object"
                vMiddleBody -> vThreeCanvas "Contains and manages"
                vAttributeWindow -> vInstanceUtilityService "Updates object attributes using"
                codeEditor -> expressionUtilityService "Uses to evaluate expressions"
                objectList -> vGlobalSelectedObjectService "Updates selected object"
                mainBodyTabBar -> vMiddleBody "Controls content shown in"
                objectCard -> vGlobalSelectedObjectService "Displays data from selected object"
    
                // Dialog Relationships
                vDialogAttributeWindow -> vInstanceUtilityService "Updates attributes using"
                vDialogHelperService -> vDialogAttributeWindow "Creates and manages"
                vDialogHelperService -> dialogLoadingWindow "Creates and manages"
                vDialogHelperService -> userManagementDialog "Creates and manages"
    
                // Initializer Relationships
                initiator -> vFetchHelperService "Initializes API connection"
                initiator -> globalStateObjectService "Sets up initial application state"
                initiator -> globalClassObjectService "Loads initial class definitions"
                initiator -> globalRelationClassObjectService "Loads initial relation class definitions"
                sceneInitiator -> graphicContextService "Sets up 3D scene"
                sceneInitiator -> vThreeCanvas "Configures canvas for rendering"
                arInitiator -> graphicContextService "Extends scene with AR capabilities"
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

            Database = container "MMAR Database" "Database for persisting metamodels, models, and logs" "PostgreSQL" "Database" {
                // Schemas
                publicSchema = component "Public Schema" "Main schema containing metamodel and model data structures" "PostgreSQL Schema"
                loggingSchema = component "Logging Schema" "Schema dedicated to audit logging and change tracking" "PostgreSQL Schema"
                
                // Core Metamodel Tables
                metaobjectTable = component "Metaobject Table" "Base table for all metamodel elements with common properties like uuid, name, description, timestamps, and spatial coordinates" "PostgreSQL Table"
                classTable = component "Class Table" "Stores metamodel class definitions with properties for reusability and abstraction" "PostgreSQL Table"
                relationclassTable = component "Relationclass Table" "Defines metamodel relationships between classes with role-based connections and optional bendpoint classes" "PostgreSQL Table"
                attributeTable = component "Attribute Table" "Stores metamodel attribute definitions including multi-valued flags, default values, constraints, and type references" "PostgreSQL Table"
                attributeTypeTable = component "Attribute Type Table" "Defines data types for attributes with predefined types and regex validation patterns" "PostgreSQL Table"
                roleTable = component "Role Table" "Stores role definitions for relationship endpoints in metamodel connections" "PostgreSQL Table"
                portTable = component "Port Table" "Defines connection points for classes and scenes in metamodel structures" "PostgreSQL Table"
                sceneTypeTable = component "Scene Type Table" "Stores metamodel scene type definitions for organizing and structuring models" "PostgreSQL Table"
                procedureTable = component "Procedure Table" "Stores algorithmic procedure definitions that can be associated with scene types" "PostgreSQL Table"
                fileTable = component "File Table" "Stores binary file data with MIME type information linked to metamodel objects" "PostgreSQL Table"
                
                // Instance/Model Tables
                instanceObjectTable = component "Instance Object Table" "Base table for all model instances with spatial coordinates, geometry, visibility, and custom variables" "PostgreSQL Table"
                classInstanceTable = component "Class Instance Table" "Stores model instances of metamodel classes with references to aggregator, decomposable, and relation class types" "PostgreSQL Table"
                relationclassInstanceTable = component "Relationclass Instance Table" "Stores model instances of metamodel relationships with role instance connections and line point data" "PostgreSQL Table"
                attributeInstanceTable = component "Attribute Instance Table" "Stores model attribute values with propagation flags and references to assigned instances" "PostgreSQL Table"
                roleInstanceTable = component "Role Instance Table" "Stores model role assignments with references to connected class, port, scene, attribute, and relationclass instances" "PostgreSQL Table"
                portInstanceTable = component "Port Instance Table" "Stores model port instances connected to specific class or scene instances" "PostgreSQL Table"
                sceneInstanceTable = component "Scene Instance Table" "Stores model scene instances conforming to metamodel scene type definitions" "PostgreSQL Table"
                
                // Association/Reference Tables
                classHasAttributesTable = component "Class Has Attributes Table" "Associates metamodel classes with their attributes, including UI sequence and component information" "PostgreSQL Table"
                portHasAttributesTable = component "Port Has Attributes Table" "Associates metamodel ports with their attributes, including UI sequence and component information" "PostgreSQL Table"
                sceneHasAttributesTable = component "Scene Has Attributes Table" "Associates metamodel scene types with their attributes, including UI sequence and component information" "PostgreSQL Table"
                containsClassesTable = component "Contains Classes Table" "Defines which metamodel classes can be contained within specific scene types" "PostgreSQL Table"
                isSubclassOfTable = component "Is Subclass Of Table" "Establishes inheritance relationships between metamodel classes" "PostgreSQL Table"
                isSubSceneTable = component "Is Sub Scene Table" "Establishes hierarchical relationships between metamodel scene types" "PostgreSQL Table"
                roleClassReferenceTable = component "Role Class Reference Table" "Associates metamodel roles with classes including cardinality constraints (min/max)" "PostgreSQL Table"
                rolePortReferenceTable = component "Role Port Reference Table" "Associates metamodel roles with ports including cardinality constraints" "PostgreSQL Table"
                roleSceneReferenceTable = component "Role Scene Reference Table" "Associates metamodel roles with scene types including cardinality constraints" "PostgreSQL Table"
                roleRelationclassReferenceTable = component "Role Relationclass Reference Table" "Associates metamodel roles with relation classes including cardinality constraints" "PostgreSQL Table"
                hasReferenceRoleTable = component "Has Reference Role Table" "Links metamodel attribute types to roles for reference-type attributes" "PostgreSQL Table"
                hasTableAttributeTable = component "Has Table Attribute Table" "Defines table-structured attributes with column sequences and attribute type references" "PostgreSQL Table"
                hasAlgorithmTable = component "Has Algorithm Table" "Associates metamodel scene types with algorithmic procedures for automated processing" "PostgreSQL Table"
                
                // Aggregation and Decomposition Tables
                aggregatorClassTable = component "Aggregator Class Table" "Marks metamodel classes as aggregators that can contain other classes or relation classes" "PostgreSQL Table"
                decomposableClassTable = component "Decomposable Class Table" "Marks metamodel classes as decomposable into scenes, classes, or aggregator classes" "PostgreSQL Table"
                containsAggregClassesTable = component "Contains Aggreg Classes Table" "Defines which classes can be contained within aggregator classes" "PostgreSQL Table"
                containsAggregRelationclassesTable = component "Contains Aggreg Relationclasses Table" "Defines which relation classes can be contained within aggregator classes" "PostgreSQL Table"
                decomposableIntoClassesTable = component "Decomposable Into Classes Table" "Defines target classes for decomposable class transformation" "PostgreSQL Table"
                decomposableIntoAggregatorClassesTable = component "Decomposable Into Aggregator Classes Table" "Defines target aggregator classes for decomposable class transformation" "PostgreSQL Table"
                decomposableIntoScenesTable = component "Decomposable Into Scenes Table" "Defines target scene types for decomposable class transformation" "PostgreSQL Table"
                classAggregationReferenceTable = component "Class Aggregation Reference Table" "Links model class instances in aggregation relationships" "PostgreSQL Table"
                classDecompositionReferenceTable = component "Class Decomposition Reference Table" "Links model class instances in decomposition relationships" "PostgreSQL Table"
                sceneDecompositionReferenceTable = component "Scene Decomposition Reference Table" "Links model class instances to their decomposed scene instances" "PostgreSQL Table"
                assignedToSceneTable = component "Assigned To Scene Table" "Associates model class instances with scene instances for organization" "PostgreSQL Table"
                
                // Attribute Propagation Tables
                attributePropagatingRelationclassTable = component "Attribute Propagating Relationclass Table" "Marks relation classes as capable of propagating attributes across connections" "PostgreSQL Table"
                selectedPropagationAttributesTable = component "Selected Propagation Attributes Table" "Configures which attributes are propagated by relation classes with durability and mutability settings" "PostgreSQL Table"
                propagationAttributeTable = component "Propagation Attribute Table" "Stores propagation-specific properties for attribute instances including durability and mutability values" "PostgreSQL Table"
                
                // User Management Tables
                usersTable = component "Users Table" "Stores user account information including usernames, hashed passwords, salts, and authentication tokens" "PostgreSQL Table"
                userGroupTable = component "User Group Table" "Defines user groups for organizing users and managing permissions" "PostgreSQL Table"
                hasUserUserGroupTable = component "Has User User Group Table" "Associates users with user groups for membership management" "PostgreSQL Table"
                
                // Permission/Rights Tables
                hasRightTable = component "Has Right Table" "Central permission table granting various access rights to user groups for metamodel objects and model instances" "PostgreSQL Table"
                hasReadRightTable = component "Has Read Right Table" "Legacy table for read permissions (superseded by has_right table)" "PostgreSQL Table"
                hasWriteRightTable = component "Has Write Right Table" "Legacy table for write permissions (superseded by has_right table)" "PostgreSQL Table"
                hasDeleteRightTable = component "Has Delete Right Table" "Legacy table for delete permissions (superseded by has_right table)" "PostgreSQL Table"
                
                // Constraint and Validation Tables
                genericConstraintTable = component "Generic Constraint Table" "Stores custom constraints and validation rules for metamodel objects" "PostgreSQL Table"
                sceneGroupTable = component "Scene Group Table" "Organizes scene types into hierarchical groups with optional parent-child relationships" "PostgreSQL Table"
                
                // Logging Tables
                tHistoryTable = component "T History Table" "Audit log table tracking all create, update, and delete operations with transaction information and affected UUIDs" "PostgreSQL Table"
                
                // Functions and Triggers
                changeTriggerFunction = component "Change Trigger Function" "PL/pgSQL function that logs all data changes to the history table for audit purposes" "PostgreSQL Function"
                deleteInstanceParentFunction = component "Delete Instance Parent Function" "PL/pgSQL function that cascades deletion of parent instance objects when child instances are removed" "PostgreSQL Function"
                deleteMetaobjectByUuidFunction = component "Delete Metaobject By UUID Function" "PL/pgSQL function that securely deletes metamodel objects with permission checking and transaction logging" "PostgreSQL Function"
                
                // Schema Relationships
                publicSchema -> metaobjectTable "Contains core metamodel object definitions"
                publicSchema -> classTable "Contains metamodel class definitions"
                publicSchema -> relationclassTable "Contains metamodel relationship definitions"
                publicSchema -> attributeTable "Contains metamodel attribute definitions"
                publicSchema -> attributeTypeTable "Contains attribute type definitions"
                publicSchema -> roleTable "Contains role definitions"
                publicSchema -> portTable "Contains port definitions"
                publicSchema -> sceneTypeTable "Contains scene type definitions"
                publicSchema -> procedureTable "Contains procedure definitions"
                publicSchema -> fileTable "Contains file storage"
                publicSchema -> instanceObjectTable "Contains model instance objects"
                publicSchema -> classInstanceTable "Contains model class instances"
                publicSchema -> relationclassInstanceTable "Contains model relationship instances"
                publicSchema -> attributeInstanceTable "Contains model attribute values"
                publicSchema -> roleInstanceTable "Contains model role assignments"
                publicSchema -> portInstanceTable "Contains model port instances"
                publicSchema -> sceneInstanceTable "Contains model scene instances"
                publicSchema -> usersTable "Contains user account data"
                publicSchema -> userGroupTable "Contains user group definitions"
                publicSchema -> hasRightTable "Contains permission assignments"
                loggingSchema -> tHistoryTable "Contains audit log entries"
                
                // Core Metamodel Relationships
                metaobjectTable -> classTable "Provides base properties for class definitions through inheritance"
                metaobjectTable -> relationclassTable "Provides base properties for relationship definitions through inheritance"
                metaobjectTable -> attributeTable "Provides base properties for attribute definitions through inheritance"
                metaobjectTable -> attributeTypeTable "Provides base properties for attribute type definitions through inheritance"
                metaobjectTable -> roleTable "Provides base properties for role definitions through inheritance"
                metaobjectTable -> portTable "Provides base properties for port definitions through inheritance"
                metaobjectTable -> sceneTypeTable "Provides base properties for scene type definitions through inheritance"
                metaobjectTable -> procedureTable "Provides base properties for procedure definitions through inheritance"
                metaobjectTable -> fileTable "Provides base properties for file objects through inheritance"
                metaobjectTable -> usersTable "Provides base properties for user objects through inheritance"
                metaobjectTable -> userGroupTable "Provides base properties for user group objects through inheritance"
                
                // Attribute System Relationships
                attributeTable -> attributeTypeTable "References attribute type definitions for validation and behavior"
                attributeTable -> classHasAttributesTable "Defines attributes belonging to specific classes"
                attributeTable -> portHasAttributesTable "Defines attributes belonging to specific ports"
                attributeTable -> sceneHasAttributesTable "Defines attributes belonging to specific scene types"
                attributeTable -> hasTableAttributeTable "Defines table-structured attributes with column specifications"
                attributeTypeTable -> hasReferenceRoleTable "Defines reference relationships for reference-type attributes"
                
                // Class System Relationships
                classTable -> relationclassTable "Serves as base for relationship class definitions"
                classTable -> aggregatorClassTable "Marks classes as aggregators for containment relationships"
                classTable -> decomposableClassTable "Marks classes as decomposable into other structures"
                classTable -> isSubclassOfTable "Establishes inheritance hierarchies between classes"
                classTable -> containsClassesTable "Defines class containment within scene types"
                classTable -> portTable "Defines connection points available on classes"
                classTable -> roleClassReferenceTable "Associates classes with roles for relationship endpoints"
                
                // Relationship System Relationships
                relationclassTable -> roleTable "References 'from' and 'to' roles for relationship endpoints"
                relationclassTable -> attributePropagatingRelationclassTable "Marks relationships as attribute propagators"
                relationclassTable -> containsAggregClassesTable "Defines containment within aggregator classes"
                relationclassTable -> roleRelationclassReferenceTable "Associates relationships with roles"
                roleTable -> roleClassReferenceTable "Associates roles with target classes and cardinality constraints"
                roleTable -> rolePortReferenceTable "Associates roles with target ports and cardinality constraints"
                roleTable -> roleSceneReferenceTable "Associates roles with target scene types and cardinality constraints"
                roleTable -> hasReferenceRoleTable "Defines roles for reference-type attributes"
                
                // Scene System Relationships
                sceneTypeTable -> containsClassesTable "Defines classes that can be contained within scenes"
                sceneTypeTable -> isSubSceneTable "Establishes hierarchical relationships between scene types"
                sceneTypeTable -> hasAlgorithmTable "Associates scenes with algorithmic procedures"
                sceneTypeTable -> decomposableIntoScenesTable "Defines scenes as decomposition targets"
                sceneTypeTable -> sceneGroupTable "Organizes scene types into hierarchical groups"
                procedureTable -> hasAlgorithmTable "Provides algorithmic definitions for scene type associations"
                
                // Instance/Model Relationships
                instanceObjectTable -> classInstanceTable "Provides base properties for class instances through inheritance"
                instanceObjectTable -> relationclassInstanceTable "Provides base properties for relationship instances through inheritance"
                instanceObjectTable -> attributeInstanceTable "Provides base properties for attribute instances through inheritance"
                instanceObjectTable -> roleInstanceTable "Provides base properties for role instances through inheritance"
                instanceObjectTable -> portInstanceTable "Provides base properties for port instances through inheritance"
                instanceObjectTable -> sceneInstanceTable "Provides base properties for scene instances through inheritance"
                
                // Instance to Metamodel Conformance
                classInstanceTable -> classTable "Conforms to class definitions and inherits properties"
                relationclassInstanceTable -> relationclassTable "Conforms to relationship definitions"
                attributeInstanceTable -> attributeTable "Conforms to attribute definitions and stores values"
                roleInstanceTable -> roleTable "Conforms to role definitions and establishes connections"
                portInstanceTable -> portTable "Conforms to port definitions"
                sceneInstanceTable -> sceneTypeTable "Conforms to scene type definitions"
                
                // Instance Interconnections
                relationclassInstanceTable -> roleInstanceTable "Connects relationship instances through 'from' and 'to' role instances"
                roleInstanceTable -> classInstanceTable "References connected class instances"
                roleInstanceTable -> portInstanceTable "References connected port instances"
                roleInstanceTable -> sceneInstanceTable "References connected scene instances"
                roleInstanceTable -> attributeInstanceTable "References connected attribute instances"
                roleInstanceTable -> relationclassInstanceTable "References connected relationship instances"
                portInstanceTable -> classInstanceTable "Connects to specific class instances"
                portInstanceTable -> sceneInstanceTable "Connects to specific scene instances"
                attributeInstanceTable -> classInstanceTable "Assigns attribute values to class instances"
                attributeInstanceTable -> portInstanceTable "Assigns attribute values to port instances"
                attributeInstanceTable -> sceneInstanceTable "Assigns attribute values to scene instances"
                attributeInstanceTable -> roleInstanceTable "Assigns attribute values through role propagation"
                
                // Aggregation and Decomposition Instance Relationships
                classInstanceTable -> aggregatorClassTable "References aggregator class types for containment"
                classInstanceTable -> decomposableClassTable "References decomposable class types for transformation"
                classInstanceTable -> classAggregationReferenceTable "Establishes aggregation relationships between instances"
                classInstanceTable -> classDecompositionReferenceTable "Establishes decomposition relationships between instances"
                classInstanceTable -> sceneDecompositionReferenceTable "Links decomposed class instances to scene instances"
                classInstanceTable -> assignedToSceneTable "Assigns class instances to organizational scene instances"
                sceneInstanceTable -> assignedToSceneTable "Contains assigned class instances for organization"
                sceneInstanceTable -> sceneDecompositionReferenceTable "Contains decomposed class instances"
                
                // Attribute Propagation Relationships
                attributePropagatingRelationclassTable -> selectedPropagationAttributesTable "Configures which attributes to propagate with durability/mutability settings"
                attributeInstanceTable -> propagationAttributeTable "Stores propagation-specific properties for propagated attributes"
                selectedPropagationAttributesTable -> attributeTable "References attributes selected for propagation"
                
                // User and Permission Relationships
                usersTable -> hasUserUserGroupTable "Associates users with group memberships"
                userGroupTable -> hasUserUserGroupTable "Associates groups with user memberships"
                userGroupTable -> hasRightTable "Grants various access rights to user groups"
                hasRightTable -> metaobjectTable "Controls access to metamodel objects"
                hasRightTable -> instanceObjectTable "Controls access to model instances"
                usersTable -> hasReadRightTable "Legacy read permission assignments"
                usersTable -> hasWriteRightTable "Legacy write permission assignments"
                usersTable -> hasDeleteRightTable "Legacy delete permission assignments"
                
                // Constraint and Validation Relationships
                genericConstraintTable -> metaobjectTable "Applies custom constraints to metamodel objects"
                sceneGroupTable -> sceneTypeTable "Organizes scene types into hierarchical structures"
                
                // Logging and Audit Relationships
                changeTriggerFunction -> tHistoryTable "Logs all data changes for audit trail"
                metaobjectTable -> changeTriggerFunction "Triggers change logging on data modifications"
                instanceObjectTable -> changeTriggerFunction "Triggers change logging on data modifications"
                deleteInstanceParentFunction -> instanceObjectTable "Cascades deletion of parent objects when children are removed"
                deleteMetaobjectByUuidFunction -> metaobjectTable "Securely deletes metamodel objects with permission verification"
                deleteMetaobjectByUuidFunction -> hasRightTable "Verifies user permissions before allowing deletion"
                deleteMetaobjectByUuidFunction -> tHistoryTable "Logs deletion operations for audit purposes"
                
                // Aggregation Container Relationships
                aggregatorClassTable -> containsAggregClassesTable "Defines which classes can be contained"
                aggregatorClassTable -> containsAggregRelationclassesTable "Defines which relation classes can be contained"
                aggregatorClassTable -> decomposableIntoAggregatorClassesTable "Serves as decomposition target"
                decomposableClassTable -> decomposableIntoClassesTable "Defines decomposition target classes"
                decomposableClassTable -> decomposableIntoAggregatorClassesTable "Defines decomposition target aggregators"
                decomposableClassTable -> decomposableIntoScenesTable "Defines decomposition target scenes"
            }

            GlobalDS = container "MMAR Global Data Structure Library" "Shared data model library (domain classes for models/metamodels)" "TypeScript" "GlobalDS" {
                // Main component
                dsIndex = component "Data Structure Index" "Main entry point exposing all data structures" "TypeScript"
                
                // Instance model components
                instanceModels = group "Instance Models" {
                    instanceObjects = component "Instance Objects" "Data structures for model objects" "TypeScript"
                    instanceClasses = component "Instance Classes" "Data structures for model class instances" "TypeScript"
                    instanceRelationClasses = component "Instance Relation Classes" "Data structures for model relation instances" "TypeScript"
                    instanceAttributes = component "Instance Attributes" "Data structures for model attribute instances" "TypeScript"
                    instancePorts = component "Instance Ports" "Data structures for model port instances" "TypeScript"
                    instanceRoles = component "Instance Roles" "Data structures for model role assignments" "TypeScript"
                    instanceScenes = component "Instance Scenes" "Data structures for model scene instances" "TypeScript"
                    instanceRows = component "Instance Rows" "Data structures for tabular data in models" "TypeScript"
                }
                
                // Meta model components
                metaModels = group "Meta Models" {
                    metamodelCore = component "Metamodel Core" "Core metamodel structures and base classes" "TypeScript"
                    metamodelClasses = component "Metamodel Classes" "Data structures for metamodel class definitions" "TypeScript"
                    metamodelRelationClasses = component "Metamodel Relation Classes" "Data structures for metamodel relation definitions" "TypeScript"
                    metamodelAttributes = component "Metamodel Attributes" "Data structures for metamodel attribute definitions" "TypeScript"
                    metamodelAttributeTypes = component "Metamodel Attribute Types" "Data structures for metamodel attribute type definitions" "TypeScript"
                    metamodelPorts = component "Metamodel Ports" "Data structures for metamodel port definitions" "TypeScript"
                    metamodelSceneTypes = component "Metamodel Scene Types" "Data structures for metamodel scene type definitions" "TypeScript"
                    metamodelRoles = component "Metamodel Roles" "Data structures for metamodel role definitions" "TypeScript"
                    metamodelUsers = component "Metamodel Users" "Data structures for user management in metamodels" "TypeScript"
                    metamodelUserGroups = component "Metamodel User Groups" "Data structures for user group management" "TypeScript"
                    metamodelReferences = component "Metamodel References" "Data structures for references between metamodel elements" "TypeScript"
                    metamodelRules = component "Metamodel Rules" "Data structures for metamodel validation rules" "TypeScript"
                    metamodelProcedures = component "Metamodel Procedures" "Data structures for procedural definitions in metamodels" "TypeScript"
                    metamodelColumns = component "Metamodel Columns" "Data structures for column definitions in metamodels" "TypeScript"
                    metamodelFiles = component "Metamodel Files" "Data structures for file definitions in metamodels" "TypeScript"
                    metamodelObjects = component "Metamodel Objects" "Base objects for all metamodel elements" "TypeScript"
                }
                
                // Component relationships - Meta to Meta
                metamodelCore -> metamodelObjects "Extends base objects"
                metamodelClasses -> metamodelCore "Inherits from core structures"
                metamodelRelationClasses -> metamodelCore "Inherits from core structures"
                metamodelAttributes -> metamodelCore "Inherits from core structures"
                metamodelPorts -> metamodelCore "Inherits from core structures"
                metamodelSceneTypes -> metamodelCore "Inherits from core structures"
                
                metamodelAttributes -> metamodelAttributeTypes "References for attribute type information"
                metamodelClasses -> metamodelAttributes "Contains attribute definitions"
                metamodelRelationClasses -> metamodelAttributes "Contains attribute definitions"
                metamodelClasses -> metamodelPorts "Defines available connection points"
                metamodelRelationClasses -> metamodelPorts "References compatible ports"
                
                // Component relationships - Instance to Meta
                instanceObjects -> metamodelObjects "Conforms to definitions in"
                instanceClasses -> metamodelClasses "Instantiates definitions from"
                instanceRelationClasses -> metamodelRelationClasses "Instantiates definitions from"
                instanceAttributes -> metamodelAttributes "Instantiates definitions from"
                instancePorts -> metamodelPorts "Instantiates definitions from"
                instanceScenes -> metamodelSceneTypes "Conforms to definitions in"
                
                // Component relationships - Instance to Instance
                instanceObjects -> instanceAttributes "Contains attributes as properties"
                instanceClasses -> instancePorts "Contains port instances"
                instanceRelationClasses -> instanceClasses "Connects instances of"
                instanceScenes -> instanceClasses "Contains instances of"
                instanceScenes -> instanceRelationClasses "Contains instances of"
                
                // Index relationships
                dsIndex -> instanceObjects "Exports instance object structures"
                dsIndex -> instanceClasses "Exports instance class structures"
                dsIndex -> instanceRelationClasses "Exports instance relation class structures"
                dsIndex -> instanceAttributes "Exports instance attribute structures"
                dsIndex -> instancePorts "Exports instance port structures"
                dsIndex -> instanceRoles "Exports instance role structures"
                dsIndex -> instanceScenes "Exports instance scene structures"
                dsIndex -> instanceRows "Exports instance row structures"

                dsIndex -> metamodelCore "Exports metamodel core structures"
                dsIndex -> metamodelClasses "Exports metamodel class structures"
                dsIndex -> metamodelRelationClasses "Exports metamodel relation class structures"
                dsIndex -> metamodelAttributes "Exports metamodel attribute structures"
                dsIndex -> metamodelAttributeTypes "Exports metamodel attribute type structures"
                dsIndex -> metamodelPorts "Exports metamodel port structures"
                dsIndex -> metamodelSceneTypes "Exports metamodel scene type structures"
                dsIndex -> metamodelRoles "Exports metamodel role structures"
                dsIndex -> metamodelUsers "Exports user data structures"
                dsIndex -> metamodelUserGroups "Exports user group structures"
                dsIndex -> metamodelReferences "Exports metamodel reference structures"
                dsIndex -> metamodelRules "Exports metamodel rule structures"
                dsIndex -> metamodelProcedures "Exports metamodel procedure structures"
                dsIndex -> metamodelColumns "Exports metamodel column structures"
                dsIndex -> metamodelFiles "Exports metamodel file structures"
                dsIndex -> metamodelObjects "Exports metamodel object structures"
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
            
            // More specific component relationships with GlobalDS
            instanceUtilityService -> instanceObjects "Creates and manages model objects"
            instanceUtilityService -> instanceClasses "Creates and manages class instances"
            metaUtilityService -> metamodelClasses "Accesses class definitions"
            metaUtilityService -> metamodelAttributes "Validates attribute constraints"
            
            // API Server component relationships with GlobalDS
            metaObjectsController -> metamodelObjects "Maps API requests to domain objects"
            metaClassesController -> metamodelClasses "Maps API requests to class definitions"
            metaRelationClassesController -> metamodelRelationClasses "Maps API requests to relation definitions"
            metaAttributesController -> metamodelAttributes "Maps API requests to attribute definitions"
            metaPortsController -> metamodelPorts "Maps API requests to port definitions"
            
            // API Server to Database Relationships
            databaseService -> publicSchema "Connects to main data schema"
            databaseService -> loggingSchema "Connects to audit logging schema"
            metaObjectsConnection -> metaobjectTable "Performs CRUD operations on metamodel objects"
            metaClassesConnection -> classTable "Performs CRUD operations on metamodel classes"
            metaRelationClassesConnection -> relationclassTable "Performs CRUD operations on metamodel relationships"
            metaAttributesConnection -> attributeTable "Performs CRUD operations on metamodel attributes"
            metaPortsConnection -> portTable "Performs CRUD operations on metamodel ports"
            metaSceneTypesConnection -> sceneTypeTable "Performs CRUD operations on metamodel scene types"
            metaFilesConnection -> fileTable "Performs CRUD operations on file storage"
            usersConnection -> usersTable "Performs CRUD operations on user accounts"
            usersConnection -> userGroupTable "Performs CRUD operations on user groups"
            usersConnection -> hasUserUserGroupTable "Manages user-group associations"
            usersConnection -> hasRightTable "Manages permission assignments"
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
            autoLayout lr
            title "Component Diagram: MMAR API Server"
            description "The MMAR API Server consists of controllers that handle HTTP requests, connection classes for database operations, and shared services. The architecture follows a layered design with controllers, data access, and service layers."
        }
        
        component ModelingClient "ModelingClientComponents" {
            include *
            autoLayout lr
            title "Component Diagram: MMAR Modeling Client"
            description "The MMAR Modeling Client consists of services for model manipulation, UI components for visualization and interaction, and dialog components for specific operations."
        }
        
        component GlobalDS "GlobalDSComponents" {
            include *
            autoLayout lr
            title "Component Diagram: MMAR Global Data Structure"
            description "The MMAR Global Data Structure library defines domain models for both metamodels and model instances. It provides type definitions that are used consistently across all MMAR components."
        }

        component VizRepClient "VizRepClientComponents" {
            include *
            autoLayout lr
            title "Component Diagram: MMAR VizRep Client"
            description "The MMAR VizRep Client provides components for designing visual representations of metamodel elements, including 3D visualization, interaction handling, and state management."
        }
        
        component Database "DatabaseComponents" {
            include *
            autoLayout lr
            title "Component Diagram: MMAR Database"
            description "The MMAR Database consists of PostgreSQL schemas, tables, and functions that store metamodel definitions, model instances, user data, and audit logs. The design supports complex metamodeling concepts including inheritance, aggregation, decomposition, and attribute propagation."
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

            element "Element" {
                color #0773af
                stroke #0773af
                strokeWidth 7
                shape roundedbox
            }

            element "Boundary" {
                strokeWidth 5
            }

            relationship "Relationship" {
                thickness 4
            }
        }

    }
}