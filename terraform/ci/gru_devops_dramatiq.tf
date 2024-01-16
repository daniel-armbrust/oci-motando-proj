#
# gru_devops_dramatiq.tf - DevOps service / Pipelines for Dramatiq Classifiedad application
#

#-----------#
# Artifacts #
#-----------#

resource "oci_devops_deploy_artifact" "gru_devops-artifact_dramatiq-classifiedad" {
    provider = oci.gru
    
    deploy_artifact_type = "DOCKER_IMAGE"
    project_id = oci_devops_project.gru_devops_motando.id
       
    display_name = "artifact_dramatiq-classifiedad"    
    description = "Docker Image: dramatiq-classifiedad"

    deploy_artifact_source {        
        deploy_artifact_source_type = "OCIR"        
        image_uri = "gru.ocir.io/${local.gru_objectstorage_ns}/dramatiq-classifiedad:1.0.0"
        repository_id = oci_artifacts_container_repository.gru_ocir_dramatiq-classifiedad.id
    }

    argument_substitution_mode = "SUBSTITUTE_PLACEHOLDERS"
}

resource "oci_devops_deploy_artifact" "gru_devops-deploy_artifact_shell-cmd-1_dramatiq-classifiedad" {
    provider = oci.gru

    project_id = oci_devops_project.gru_devops_motando.id
        
    display_name = "shell-cmd-1_dramatiq-classifiedad"
    description = "Comando para provisionar os CI da aplicação Dramatiq Classifiedad"
    
    argument_substitution_mode = "SUBSTITUTE_PLACEHOLDERS"

    deploy_artifact_source {        
        deploy_artifact_source_type = "INLINE"        
        base64encoded_content = filebase64("yaml/shell-cmd-1_dramatiq-classifiedad.yaml")
    }

    # DEPLOYMENT_SPEC, JOB_SPEC, KUBERNETES_MANIFEST, GENERIC_FILE, DOCKER_IMAGE,HELM_CHART,COMMAND_SPEC
    deploy_artifact_type = "COMMAND_SPEC"
}

resource "oci_devops_deploy_artifact" "gru_devops-deploy_artifact_shell-cmd-2_dramatiq-classifiedad" {
    provider = oci.gru

    project_id = oci_devops_project.gru_devops_motando.id
        
    display_name = "shell-cmd-2_dramatiq-classifiedad"
    description = "Comando atualizar o Network Load Balancer com o endereço IP dos CI's"
    
    argument_substitution_mode = "SUBSTITUTE_PLACEHOLDERS"

    deploy_artifact_source {        
        deploy_artifact_source_type = "INLINE"        
        base64encoded_content = filebase64("yaml/shell-cmd-2_dramatiq-classifiedad.yaml")
    }

    # DEPLOYMENT_SPEC, JOB_SPEC, KUBERNETES_MANIFEST, GENERIC_FILE, DOCKER_IMAGE,HELM_CHART,COMMAND_SPEC
    deploy_artifact_type = "COMMAND_SPEC"
}

#----------------#
# Build Pipeline #
#----------------#

# Build Pipeline - Dramatiq Classified Application
resource "oci_devops_build_pipeline" "gru_devops-build-pipeline_dramatiq-classifiedad" {
    provider = oci.gru
    
    project_id = oci_devops_project.gru_devops_motando.id

    display_name = "Build - Dramatiq Classified Application"
    description = "Build Pipeline para construção da aplicação Dramatiq Classified"
}

# STAGE #1: Build Docker Image - Dramatiq Classifiedad
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline-stage_create-dockerimg_dramatiq-classifiedad" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_dramatiq-classifiedad.id

    # Managed Build
    build_pipeline_stage_type = "BUILD"    
    build_spec_file = "services/dramatiq-classifiedad/build_spec.yaml"
    stage_execution_timeout_in_seconds = 3600            
    
    display_name = "Build Docker Image (Dramatiq Classifiedad)"
    description = "Estágio de criação da imagem Docker do serviço Dramatiq"
    
    image = "OL7_X86_64_STANDARD_10" # Oracle Linux 7 x86_64 standard:1.0

    build_runner_shape_config {        
        build_runner_type = "CUSTOM"
        memory_in_gbs = 3
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
            id = oci_devops_build_pipeline.gru_devops-build-pipeline_dramatiq-classifiedad.id
        }
    }    
}

# STAGE #2: Send the Docker image to OCIR
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline-stage_delivery-artifact_dramatiq-classifiedad" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_dramatiq-classifiedad.id
    
    build_pipeline_stage_type = "DELIVER_ARTIFACT"    

    display_name = "Send Docker Image to OCIR (Dramatiq Classifiedad)"
    description = "Estágio que irá enviar a imagem Docker gerada para o OCIR"

    deliver_artifact_collection {        
        items {            
            artifact_id = oci_devops_deploy_artifact.gru_devops-artifact_dramatiq-classifiedad.id
            artifact_name = "dramatiq-classifiedad"
        }
    }

    build_pipeline_stage_predecessor_collection {        
        items {        
            id = oci_devops_build_pipeline_stage.gru_devops-build-pipeline-stage_create-dockerimg_dramatiq-classifiedad.id
        }
    } 
}

# STAGE #3: Trigger the deployment pipeline (Dramatiq Classifiedad)
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline-stage_trigger_deploy-pipeline_dramatiq-classifiedad" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_dramatiq-classifiedad.id
    
    build_pipeline_stage_type = "TRIGGER_DEPLOYMENT_PIPELINE"    
    is_pass_all_parameters_enabled = false

    display_name = "Trigger Deploy Pipeline (Dramatiq Classifiedad)"
    description = "Estágio que irá ativar o Deployment Pipeline para instalar a aplicação do serviço Dramatiq"

    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_dramatiq-classifiedad.id

    build_pipeline_stage_predecessor_collection {        
        items {        
            id = oci_devops_build_pipeline_stage.gru_devops-build-pipeline-stage_delivery-artifact_dramatiq-classifiedad.id
        }
    } 
}

#----------------------#
# Deployment Pipeline  #
#----------------------#

resource "oci_devops_deploy_pipeline" "gru_devops-deploy-pipeline_dramatiq-classifiedad" {
    provider = oci.gru

    project_id = oci_devops_project.gru_devops_motando.id

    display_name = "Deploy - Dramatiq Classifiedad"
    description = "Deployment Pipeline para instalar a aplicação Dramatiq Classifiedad"
    
    deploy_pipeline_parameters {    
        items {            
            name = "APP_ENV"            
            default_value = "PRD"
            description = "Application environment (PRD = Prodution)"
        }

        items {            
            name = "DEPLOYMENT_ENV"            
            default_value = "CI"
            description = "CI = Container Instances, OKE = Kubernetes"
        }

        items {            
            name = "WORKFLOW_OCI_LOG_ID"            
            default_value = oci_logging_log.gru_motando-log_workflow.id
            description = "Motando - Workflow Logging OCID"
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
            name = "REDIS_HOST"            
            default_value = tolist(oci_dns_rrset.gru_dns_motando-rrset_redis.items)[0].domain
            description = "Redis Host"
        }

        items {
            name = "REGION_ID"
            default_value = "sa-saopaulo-1"
            description = "Motando - OCI primary region"
        }        

        items {
            name = "BUCKET_MOTANDO_IMG"
            default_value = oci_objectstorage_bucket.gru_motando-img.name
            description = "Motando - Object Storage Bucket for images files"
        }

        items {
            name = "BUCKET_MOTANDO_IMGTMP"
            default_value = oci_objectstorage_bucket.gru_motando-tmpimg.name
            description = "Motando - Object Storage Bucket for temporary image files"
        }

        items {            
            name = "IMAGE_URL"            
            default_value = "gru.ocir.io/${local.gru_objectstorage_ns}/${oci_artifacts_container_repository.gru_ocir_dramatiq-classifiedad.display_name}:1.0.0"
            description = "Container Image URL"
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
            description = "Services Subnet"
        }

        items {            
            name = "NLB_OCID"            
            default_value = oci_network_load_balancer_network_load_balancer.gru_nlb_motando-tasks.id
            description = "Network Load Balancer OCID"
        }

        items {            
            name = "NLB_BACKENDSET_NAME"            
            default_value = oci_network_load_balancer_backend_set.gru_nlb_motando-tasks_backend-set.name
            description = "Network Load Balancer Backend Set name"
        }
    }
}

# STAGE #1: Shell command to initialize the CI
resource "oci_devops_deploy_stage" "gru_devops-deploy-pipeline-stage_1-shell_dramatiq-classifiedad" {
    provider = oci.gru     
    
    deploy_stage_type = "SHELL"
    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_dramatiq-classifiedad.id

    display_name = "Create CI to deploy dramatiq-classifiedad"
    description = "Estágio que cria dois Container Instances para executar a aplicação Dramatiq Classifiedad"

    command_spec_deploy_artifact_id = oci_devops_deploy_artifact.gru_devops-deploy_artifact_shell-cmd-1_dramatiq-classifiedad.id
    timeout_in_seconds = 1200
    
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
            id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_dramatiq-classifiedad.id
        }
    }   
}

# STAGE #2: Wait
resource "oci_devops_deploy_stage" "gru_devops-deploy-pipeline-stage_2-wait_dramatiq-classifiedad" {
    provider = oci.gru     
    
    deploy_stage_type = "WAIT"
    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_dramatiq-classifiedad.id

    display_name = "Wait - 120 seconds"
    description = "Estágio para aguardar a criação dos Container Instances"    

    wait_criteria {     
        wait_type = "ABSOLUTE_WAIT"
        wait_duration = "PT120S"
    }

    deploy_stage_predecessor_collection {       
        items {            
            id = oci_devops_deploy_stage.gru_devops-deploy-pipeline-stage_1-shell_dramatiq-classifiedad.id
        }
    } 
}

# STAGE #3: Shell command to update the Network Load Balancer
resource "oci_devops_deploy_stage" "gru_devops-deploy-pipeline-stage_3-shell_dramatiq-classifiedad" {
    provider = oci.gru     
    
    deploy_stage_type = "SHELL"
    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_dramatiq-classifiedad.id

    display_name = "Update the Network Load Balancer"
    description = "Estágio que atualiza o Network Load Balancer com o endereço IP dos CI's"

    command_spec_deploy_artifact_id = oci_devops_deploy_artifact.gru_devops-deploy_artifact_shell-cmd-2_dramatiq-classifiedad.id
    timeout_in_seconds = 900
    
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
            id = oci_devops_deploy_stage.gru_devops-deploy-pipeline-stage_2-wait_dramatiq-classifiedad.id
        }
    }   
}