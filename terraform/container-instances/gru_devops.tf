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


#--------------------#
# Artifacts          #
#--------------------#

resource "oci_devops_deploy_artifact" "gru_devops-artifact_motando-webapp-init" {
    provider = oci.gru
    
    deploy_artifact_type = "DOCKER_IMAGE"
    project_id = oci_devops_project.gru_devops_motando.id
       
    display_name = "artifact_motando-webapp-init"    
    description = "Imagem Docker: motando-webapp-init"

    deploy_artifact_source {        
        deploy_artifact_source_type = "OCIR"        
        image_uri = "gru.ocir.io/${local.gru_objectstorage_ns}/motando-webapp-init:1.0.0"
        repository_id = oci_artifacts_container_repository.gru_ocir_motando-webapp-init.id
    }

    argument_substitution_mode = "SUBSTITUTE_PLACEHOLDERS"
}

resource "oci_devops_deploy_artifact" "gru_devops-deploy_artifact_shell-cmd_motando-webapp-init" {
    provider = oci.gru

    project_id = oci_devops_project.gru_devops_motando.id
        
    display_name = "shell-cmd_motando-webapp-init"
    description = "Comando para criação do Container Instance para inicializar o banco de dados MySQL"
    
    argument_substitution_mode = "SUBSTITUTE_PLACEHOLDERS"

    deploy_artifact_source {        
        deploy_artifact_source_type = "INLINE"        
        base64encoded_content = filebase64("yaml/motando-webapp-init.yaml")
    }

    # DEPLOYMENT_SPEC, JOB_SPEC, KUBERNETES_MANIFEST, GENERIC_FILE, DOCKER_IMAGE,HELM_CHART,COMMAND_SPEC
    deploy_artifact_type = "COMMAND_SPEC"
}


#--------------------#
# Build Pipeline     #
#--------------------#

# Build Pipeline - Docker image for Motando application data initialization
resource "oci_devops_build_pipeline" "gru_devops-build-pipeline_motando-webapp-init" {
    provider = oci.gru
    
    project_id = oci_devops_project.gru_devops_motando.id

    display_name = "motando-webapp-init"
    description = "Build Pipeline para inicializar a aplicação Motando"
}

# STAGE to create the Docker Image
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline-stage_create-dockerimg_motando-webapp-init" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-webapp-init.id

    # Managed Build
    build_pipeline_stage_type = "BUILD"    
    build_spec_file = "services/motando-webapp-init/build_spec.yaml"
    stage_execution_timeout_in_seconds = 3600        
    
    display_name = "create-dockerimg_motando-webapp-init"
    description = "Estágio de criação da imagem Docker para inicializar a aplicação Motando"
    
    image = "OL7_X86_64_STANDARD_10" # Oracle Linux 7 x86_64 standard:1.0

    build_runner_shape_config {        
        build_runner_type = "CUSTOM"
        memory_in_gbs = 2
        ocpus = 1
    }

    build_source_collection {
        items {            
            name = oci_devops_repository.gru_devops_github-repository.name
            connection_type = "DEVOPS_CODE_REPOSITORY"
            branch = "main"            
            repository_id = oci_devops_repository.gru_devops_github-repository.id
            repository_url = "https://devops.scmservice.sa-saopaulo-1.oci.oraclecloud.com/namespaces/${local.gru_objectstorage_ns}/projects/${oci_devops_project.gru_devops_motando.name}/repositories/${oci_devops_repository.gru_devops_github-repository.name}"
        }
    }

    build_pipeline_stage_predecessor_collection {        
        items {        
            id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-webapp-init.id
        }
    }    
}

# STAGE to send the Docker image to OCIR
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline-stage_delivery-artifact_motando-webapp-init" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-webapp-init.id
    
    build_pipeline_stage_type = "DELIVER_ARTIFACT"    

    display_name = "delivery-artifact_motando-webapp-init"
    description = "Estágio que irá enviar a imagem Docker gerada para o OCIR"

    deliver_artifact_collection {        
        items {            
            artifact_id = oci_devops_deploy_artifact.gru_devops-artifact_motando-webapp-init.id
            artifact_name = "motando-webapp-init"
        }
    }

    build_pipeline_stage_predecessor_collection {        
        items {        
            id = oci_devops_build_pipeline_stage.gru_devops-build-pipeline-stage_create-dockerimg_motando-webapp-init.id
        }
    } 
}


#----------------------#
# Deployment Pipeline  #
#----------------------#

resource "oci_devops_deploy_pipeline" "gru_devops-deploy-pipeline_motando-webapp-init" {
    provider = oci.gru

    project_id = oci_devops_project.gru_devops_motando.id

    display_name = "motando-webapp-init"
    description = "Deployment Pipeline para inicializar a aplicação Motando"
    
    deploy_pipeline_parameters {        
        items {            
            name = "MYSQL_ADMIN_SECRET_OCID"            
            default_value = oci_vault_secret.gru_vault-secret_mysql-admin.id
            description = "MySQL Admin - Vault SECRET OCID"
        }

        items {            
            name = "MYSQL_WEBAPPL_USER"            
            default_value = "motandousr"
            description = "MySQL Web Application - User"
        }

        items {            
            name = "MYSQL_WEBAPPL_SECRET_OCID"            
            default_value = oci_vault_secret.gru_vault-secret_mysql-webappl.id
            description = "MySQL Web Application - Vault SECRET OCID"
        }

        items {            
            name = "MYSQL_WEBAPPL_DBNAME"            
            default_value = "motandodb"
            description = "MySQL Web Application - Database name"
        }

        items {            
            name = "MYSQL_HOST"            
            default_value = tolist(oci_dns_rrset.gru_dns_motando-rrset_mysql.items)[0].domain
            description = "MySQL Web Application - Hostname"
        }

        items {            
            name = "COMPARTMENT_OCID"            
            default_value = var.root_compartment
            description = "Container Instance Compartment ID"
        }

        items {            
            name = "AVAILABILITY_DOMAIN"            
            default_value = local.ads.gru_ad1_name
            description = "Container Instance Compartment ID"
        }

        items {            
            name = "SUBNET_OCID"            
            default_value = oci_core_subnet.gru_subnet_svcs.id
            description = "Container Instance Subnet ID"
        }

        items {            
            name = "IMAGE_URL"            
            default_value = "gru.ocir.io/${local.gru_objectstorage_ns}/${oci_artifacts_container_repository.gru_ocir_motando-webapp-init.display_name}:1.0.0"
            description = "Container Image URL"
        }
    }
}

# STAGE - Shell for
resource "oci_devops_deploy_stage" "gru_devops-deploy-pipeline-shell-stage_motando-webapp-init" {
    provider = oci.gru     
    
    deploy_stage_type = "SHELL"
    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_motando-webapp-init.id

    display_name = "shell-stage_motando-webapp-init"
    description = "Estágio que cria um Container Instance que irá inicializar o Banco de Dados MySQL"

    command_spec_deploy_artifact_id = oci_devops_deploy_artifact.gru_devops-deploy_artifact_shell-cmd_motando-webapp-init.id
    timeout_in_seconds = 3600
    
    container_config {        
        compartment_id = var.root_compartment

        container_config_type = "CONTAINER_INSTANCE_CONFIG"

        network_channel {        
            subnet_id = oci_core_subnet.gru_subnet_svcs.id
            network_channel_type = "SERVICE_VNIC_CHANNEL"
        }

        shape_name = "CI.Standard.E4.Flex"

        shape_config {            
            ocpus = 1
            memory_in_gbs = 1
        }
    }

    deploy_stage_predecessor_collection {       
        items {            
            id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_motando-webapp-init.id
        }
    }   
}

