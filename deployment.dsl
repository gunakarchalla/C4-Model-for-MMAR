    deploymentEnvironment "Production" {
        // Node hosting the server and database (e.g., a cloud or on-prem server)
        deploymentNode "Server Host (Docker)" as ServerHost "Ubuntu + Docker Engine" {
            deploymentNode "Docker Container: MMAR Server" as DockerServer "Containerized Spring Boot/.NET Server" {
                containerInstance Server as ServerInstance "MMAR Server API Instance"
            }
            deploymentNode "Docker Container: MMAR Database" as DockerDB "Containerized SQL DB (e.g., PostgreSQL)" {
                containerInstance DB as DBInstance "MMAR Database Instance"
            }
        }
        // Creator's machine
        deploymentNode "Creator Workstation" as CreatorPC "Windows/macOS PC" {
            containerInstance MetamodelingClient as MetaClientInstance "MMAR Metamodeling Client App"
            containerInstance VizRepClient as VizClientInstance "MMAR VizRep Client App"
        }
        // End User's machine
        deploymentNode "End User Workstation" as UserPC "Windows/macOS PC" {
            containerInstance ModelingClient as ModelClientInstance "MMAR Modeling Client App"
        }
        
        // Relationships in deployment
        CreatorPC -> ServerHost "HTTP(S) API calls"
        UserPC -> ServerHost "HTTP(S) API calls"
        ServerInstance -> DBInstance "JDBC/SQL"
    }
    views {
        deployment DeploymentView {
            include * 
            autoLayout lr
            title "Deployment Diagram: MMAR Docker Containers and Client Nodes"
            description "The MMAR Server and Database run as Docker containers on a server host. The Creator and End User run their respective client applications on separate workstations. The clients communicate over HTTPS with the server container’s API, and the server container connects to the database container for persistence. (Deployment infrastructure uses Docker for server components:contentReference[oaicite:9]{index=9}.)"
        }
    }
}
