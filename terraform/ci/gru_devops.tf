#
# gru_devops.tf - DevOps service
#

resource "oci_devops_project" "gru_devops_motando" {
    provider = oci.gru

    compartment_id = var.root_compartment
    name = "devops_motando"
    description = "CI/CD para a aplicação Motando"

    notification_config {        
        topic_id = oci_ons_notification_topic.gru_devops_notification-topic.id
    }
}

# GitHub Connection
resource "oci_devops_connection" "gru_devops_github-connection_motando" {
    provider = oci.gru
    
    display_name = "github-connection_oci-motando-proj"
    description = "Conexão com GitHub a partir do serviço DevOps"

    connection_type = "GITHUB_ACCESS_TOKEN"
    project_id = oci_devops_project.gru_devops_motando.id

    access_token = oci_vault_secret.gru_vault-secret_github-token.id
}

# GitHub Mirror Repository
resource "oci_devops_repository" "gru_devops_github-repository" {
    provider = oci.gru
    
    name = "oci-motando-proj"
    description = "OCI Motando Project"

    project_id = oci_devops_project.gru_devops_motando.id
    repository_type = "MIRRORED"    

    mirror_repository_config {                
        repository_url = "https://github.com/daniel-armbrust/oci-motando-proj"

        connector_id = oci_devops_connection.gru_devops_github-connection_motando.id

        trigger_schedule {            
            schedule_type = "NONE"            
        }
    }

    lifecycle {
       ignore_changes = [
           http_url
       ]
    }
}