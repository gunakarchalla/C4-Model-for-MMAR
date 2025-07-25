
//     // Containers within MMAR Systems
//     MMAR_Metamodeling_System = softwareSystem "MMAR Metamodeling System" {
//         MetamodelingClient = container "MMAR Metamodeling Client"  "Desktop/Web Client for metamodel design" "Electron/Web App"
//         VizRepClient = container "MMAR VizRep Client"  "Client for visual representation design of metamodel elements" "Electron/Web App"
//     }
//     MMAR_Modeling_System = softwareSystem "MMAR Modeling System" {
//         ModelingClient = container "MMAR Modeling Client"  "Client for model creation based on metamodels" "Desktop/Web App"
//     }
//     // The server and database are shared, define under one of the systems (or as separate top-level for simplicity)
    
//     MMARBackend = softwareSystem "MMAR Platform Backend"  "Common backend server for MMAR" {
//         Server = container "MMAR Server API"  "Backend server providing REST APIs for MMAR clients" "Server (API, business logic)" 
//         DB = container "MMAR Database"  "Database for persisting metamodels, models, and logs" "SQL Database"
//         GlobalDS = container "Global Data Structure Library"  "Shared data model library (domain classes for models/metamodels)" "Library/Package"
//     }
    
//     // Links: Clients <-> Server, Server <-> DB, library usage
//     MetamodelingClient -> Server "Uses API for metamodel operations"
//     VizRepClient -> Server "Uses API for visualization config ops"
//     ModelingClient -> Server "Uses API for model operations"
//     Server -> DB "Reads/Writes metamodels, models, logs"
//     // Indicate shared library usage (as dependency, not a runtime connection)
//     MetamodelingClient -> GlobalDS "Embedded data definitions"
//     VizRepClient -> GlobalDS "Embedded data definitions"
//     ModelingClient -> GlobalDS "Embedded data definitions"
//     Server -> GlobalDS "Uses common data definitions"

// views {
//     container MetamodelingClient {
//         include MetamodelingClient, VizRepClient, ModelingClient, Server, DB, GlobalDS, Creator, User
//         autoLayout lr
//         title "Container Diagram: MMAR Clients, Server, and Database"
//         description "All MMAR clients (Metamodeling, VizRep, and Modeling) connect to the MMAR Server via REST API calls. The server business logic accesses the MMAR Database to store and retrieve Metamodel definitions, Model instances, and logging data. A Global Data Structure library is shared across all components to ensure a consistent domain model."
//     }

    {
        ModelingClient = container "MMAR Modeling Client"  "Client for model creation based on metamodels" "Desktop/Web App"
        MetamodelingClient = container "MMAR Metamodeling Client"  "Desktop/Web Client for metamodel design" "Electron/Web App"
        VizRepClient = container "MMAR VizRep Client"  "Client for visual representation design of metamodel elements" "Electron/Web App"
    }
    