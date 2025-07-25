model {
    // MMAR Server components (within the Server container)
    component "Metamodel Management Service" as MetaService "Handles creating & managing metamodel definitions" "Spring Boot REST Controller" {
        tag "Domain:Metamodeling"
    }
    component "Visualization Config Service" as VizService "Manages visualization rules for metamodel elements" "Spring Boot REST Controller" {
        tag "Domain:Metamodeling"
    }
    component "Model Management Service" as ModelService "Handles creating & managing instance models" "Spring Boot REST Controller" {
        tag "Domain:Modeling"
    }
    component "Logging Service" as LogService "Logs user actions and system events" "Utility/Service"
    
    Server -> MetaService "Invokes"
    Server -> VizService "Invokes"
    Server -> ModelService "Invokes"
    Server -> LogService "Uses"
    MetaService -> DB "CRUD metamodel data"
    VizService -> DB "CRUD visualization settings"
    ModelService -> DB "CRUD model data"
    LogService -> DB "Write logs"
    
    // Example internal components for one client (Modeling Client)
    component "Model Editor UI" as ModelUI "GUI for creating/editing models" "Angular Component"
    component "Model Validation Module" as ModelValidation "Ensures model conforms to metamodel rules" "TypeScript Module"
    component "Model Sync Service" as ModelSync "Syncs model changes with server via API" "TypeScript Service"
    
    ModelingClient -> ModelUI "Displays"
    ModelUI -> ModelValidation "Uses"
    ModelUI -> ModelSync "Uses"
    ModelSync -> Server "REST API calls"
}
views {
    component ServerComponentView {
        description "Internal structure of the MMAR Server, showing components grouped by domain (Metamodel management, Model management, Visualization, Logging). Also shows an example of how a client (Modeling Client) might be internally structured."
        include MetaService, VizService, ModelService, LogService, Server, DB
        include ModelUI, ModelValidation, ModelSync, ModelingClient, Server
        autoLayout lr
        title "Component Diagram: MMAR Server and Client Components"
        legend "MMAR Server components (left) are grouped by domain; an example Modeling Client internal breakdown is shown on the right."
    }
}
