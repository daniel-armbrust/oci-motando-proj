#
# gru_devops_all.tf - DevOps service / Pipelines for Motando Web application (ALL STEPS)
#

#----------------#
# Build Pipeline #
#----------------#

resource "oci_devops_build_pipeline" "gru_devops-build-pipeline_motando-all" {
    provider = oci.gru
    
    project_id = oci_devops_project.gru_devops_motando.id

    display_name = "Build - Motando Application (ALL)"
    description = "Build Pipeline para construção da aplicação Motando"
}

# STAGE #1: Build Docker Image (Web Application)
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline_motando-all_stage_create-dockerimg_motando-webapp" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-all.id

    # Managed Build
    build_pipeline_stage_type = "BUILD"    
    build_spec_file = "webapp/build_spec.yaml"
    stage_execution_timeout_in_seconds = 3600            
    
    display_name = "Build Docker Image (Web Application)"
    description = "Estágio de criação da imagem Docker da aplicação Web"
    
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
            id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-all.id
        }
    }    
}

# STAGE #2: Send the Docker image to OCIR (Web Application)
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline_motando-all_stage_delivery-artifact_motando-webapp" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-all.id
    
    build_pipeline_stage_type = "DELIVER_ARTIFACT"    

    display_name = "Send Docker Image to OCIR (Web Application)"
    description = "Estágio que irá enviar a imagem Docker gerada para o OCIR"

    deliver_artifact_collection {        
        items {            
            artifact_id = oci_devops_deploy_artifact.gru_devops-artifact_motando-webapp.id
            artifact_name = "motando-webapp"
        }
    }

    build_pipeline_stage_predecessor_collection {        
        items {        
            id = oci_devops_build_pipeline_stage.gru_devops-build-pipeline_motando-all_stage_create-dockerimg_motando-webapp.id
        }
    } 
}

# STAGE #3: Build Docker Image (Dramatiq Classifiedad)
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline_motando-all_stage_create-dockerimg_dramatiq-classifiedad" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-all.id

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
            id = oci_devops_build_pipeline_stage.gru_devops-build-pipeline_motando-all_stage_delivery-artifact_motando-webapp.id
        }
    }    
}

# STAGE #4: Send the Docker image to OCIR (Dramatiq Classifiedad)
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline_motando-all_stage_delivery-artifact_dramatiq-classifiedad" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-all.id
    
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
            id = oci_devops_build_pipeline_stage.gru_devops-build-pipeline_motando-all_stage_create-dockerimg_dramatiq-classifiedad.id
        }
    } 
}

# STAGE #5: Build Docker Image (Motando App Initialization)
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline_motando-all_stage_create-dockerimg_motando-webapp-init" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-all.id

    # Managed Build
    build_pipeline_stage_type = "BUILD"    
    build_spec_file = "services/motando-webapp-init/build_spec.yaml"
    stage_execution_timeout_in_seconds = 3600            
    
    display_name = "Build Docker Image (Motando App Initialization)"
    description = "Estágio de criação da imagem Docker para inicializar a aplicação Motando"
    
    image = "OL7_X86_64_STANDARD_10" # Oracle Linux 7 x86_64 standard:1.0

    build_runner_shape_config {        
        build_runner_type = "CUSTOM"
        memory_in_gbs = 4
        ocpus = 2
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
            id = oci_devops_build_pipeline_stage.gru_devops-build-pipeline_motando-all_stage_delivery-artifact_dramatiq-classifiedad.id
        }
    }    
}

# STAGE #6: Send the Docker image to OCIR (Motando App Initialization)
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline_motando-all_stage_delivery-artifact_motando-webapp-init" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-all.id
    
    build_pipeline_stage_type = "DELIVER_ARTIFACT"    

    display_name = "Send Docker Image to OCIR (Motando App Initialization)"
    description = "Estágio que irá enviar a imagem Docker gerada para o OCIR"

    deliver_artifact_collection {        
        items {            
            artifact_id = oci_devops_deploy_artifact.gru_devops-artifact_motando-webapp-init.id
            artifact_name = "motando-webapp-init"
        }
    }

    build_pipeline_stage_predecessor_collection {        
        items {        
            id = oci_devops_build_pipeline_stage.gru_devops-build-pipeline_motando-all_stage_create-dockerimg_motando-webapp-init.id
        }
    } 
}

# STAGE #7: Trigger the deployment pipeline
resource "oci_devops_build_pipeline_stage" "gru_devops-build-pipeline_motando-all_stage_trigger_deploy-pipeline" {
    provider = oci.gru
    
    build_pipeline_id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-all.id
    
    build_pipeline_stage_type = "TRIGGER_DEPLOYMENT_PIPELINE"    
    is_pass_all_parameters_enabled = false

    display_name = "Trigger Deploy Pipeline"
    description = "Estágio que irá ativar o Deployment Pipeline para instalar a aplicação Motando"

    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_motando-all.id

    build_pipeline_stage_predecessor_collection {               

        items {        
            id = oci_devops_build_pipeline_stage.gru_devops-build-pipeline_motando-all_stage_delivery-artifact_motando-webapp-init.id
        }
    } 
}

#----------------------#
# Deployment Pipeline  #
#----------------------#

resource "oci_devops_deploy_pipeline" "gru_devops-deploy-pipeline_motando-all" {
    provider = oci.gru

    project_id = oci_devops_project.gru_devops_motando.id

    display_name = "Deploy - Motando Web Application (ALL)"
    description = "Deployment Pipeline para instalar a aplicação Motando"
    
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
            name = "REGION_ID"
            default_value = "sa-saopaulo-1"
            description = "Motando - OCI primary region"
        }

        items {
            name = "WEBAPP_OCI_LOG_ID"
            default_value = oci_logging_log.gru_motando-log_webapp.id
            description = "Motando - Web Application Logging OCID"
        }

        items {            
            name = "WORKFLOW_OCI_LOG_ID"            
            default_value = oci_logging_log.gru_motando-log_workflow.id
            description = "Motando - Workflow Logging OCID"
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
            name = "BUCKET_STATICFILES"
            default_value = oci_objectstorage_bucket.gru_motando-staticfiles.name
            description = "Motando - Object Storage Bucket for static files"
        }        

        items {
            name = "CLASSIFIEDAD_XMLRPC_HOST"
            default_value = tolist(oci_dns_rrset.gru_dns_motando-rrset_nlb_motando-tasks.items)[0].domain
            description = "Network Load Balancer IP"
        }

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
            name = "REDIS_HOST"            
            default_value = tolist(oci_dns_rrset.gru_dns_motando-rrset_redis.items)[0].domain
            description = "Redis Host"
        }

        items {
            name = "MOTANDO_ACCESS_KEY_SECRET_OCID"
            default_value = oci_vault_secret.gru_vault-secret_motando-access-key.id
            description = "Motando - OCI Object Storage ACCESS KEY"
        }

        items {
            name = "MOTANDO_SECRET_KEY_SECRET_OCID"
            default_value = oci_vault_secret.gru_vault-secret_motando-secret-key.id
            description = "Motando - OCI Object Storage SECRET KEY"
        }

        items {
            name = "DJANGO_SECRET_KEY_SECRET_OCID"
            default_value = oci_vault_secret.gru_vault-secret_django-secret-key.id
            description = "Motando - DJANGO Framework Secret Key OCID"
        }     

        items {
            name = "GITHUB_REPO_URL"
            default_value = "https://github.com/daniel-armbrust/oci-motando-proj"
            description = "Motando - GitHub Repository URL"
        }  

        items {            
            name = "WEBAPP_IMAGE_URL"            
            default_value = "gru.ocir.io/${local.gru_objectstorage_ns}/${oci_artifacts_container_repository.gru_ocir_motando-webapp.display_name}:1.0.0"
            description = "Container Image URL"
        }

        items {            
            name = "DRAMATIQ_IMAGE_URL"            
            default_value = "gru.ocir.io/${local.gru_objectstorage_ns}/${oci_artifacts_container_repository.gru_ocir_dramatiq-classifiedad.display_name}:1.0.0"
            description = "Container Image URL"
        }

        items {            
            name = "MOTANDOINIT_IMAGE_URL"            
            default_value = "gru.ocir.io/${local.gru_objectstorage_ns}/${oci_artifacts_container_repository.gru_ocir_motando-webapp-init.display_name}:1.0.0"
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
            name = "APPL_SUBNET_OCID"            
            default_value = oci_core_subnet.gru_subnet_appl.id
            description = "Services Subnet"
        }

        items {            
            name = "SVCS_SUBNET_OCID"            
            default_value = oci_core_subnet.gru_subnet_svcs.id
            description = "Services Subnet"
        }

        items {            
            name = "LB_OCID"            
            default_value = oci_load_balancer_load_balancer.gru_lb_motando.id
            description = "Load Balancer OCID"
        }

        items {            
            name = "LB_BACKENDSET_NAME"            
            default_value = oci_load_balancer_backend_set.gru_lb_motando-webapp_backend-set.name
            description = "Load Balancer Backend Set name"
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

# STAGE #1: Shell command to initialize the CI (Dramatiq Classifiedad)
resource "oci_devops_deploy_stage" "gru_devops-deploy-pipeline_motando-all_stage_shell_dramatiq-classifiedad" {
    provider = oci.gru     
    
    deploy_stage_type = "SHELL"
    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_motando-all.id

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
            id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_motando-all.id
        }
    }   
}

# STAGE #2: Wait
resource "oci_devops_deploy_stage" "gru_devops-deploy-pipeline_motando-all_stage_wait_dramatiq-classifiedad" {
    provider = oci.gru     
    
    deploy_stage_type = "WAIT"
    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_motando-all.id

    display_name = "Wait - 2 minutes"
    description = "Estágio para aguardar a criação dos Container Instances"    

    wait_criteria {     
        wait_type = "ABSOLUTE_WAIT"
        wait_duration = "PT120S"
    }

    deploy_stage_predecessor_collection {       
        items {            
            id = oci_devops_deploy_stage.gru_devops-deploy-pipeline_motando-all_stage_shell_dramatiq-classifiedad.id
        }
    } 
}

# STAGE #3: Shell command to initialize the CI (Motando App Initialization)
resource "oci_devops_deploy_stage" "gru_devops-deploy-pipeline_motando-all_stage_shell_motando-webapp-init" {
    provider = oci.gru     
    
    deploy_stage_type = "SHELL"
    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_motando-all.id

    display_name = "Create CI to init Motando Application"
    description = "Estágio que cria um Container Instance que irá inicializar o Banco de Dados MySQL"

    command_spec_deploy_artifact_id = oci_devops_deploy_artifact.gru_devops-deploy_artifact_shell-cmd-1_motando-webapp-init.id
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
            id = oci_devops_deploy_stage.gru_devops-deploy-pipeline_motando-all_stage_wait_dramatiq-classifiedad.id
        }
    }   
}

# STAGE #4: Wait
resource "oci_devops_deploy_stage" "gru_devops-deploy-pipeline_motando-all_stage_wait_motando-webapp-init" {
    provider = oci.gru     
    
    deploy_stage_type = "WAIT"
    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_motando-all.id

    display_name = "Wait - 10 minutes"
    description = "Estágio para aguardar a inicialização da aplicação e Banco de Dados MySQL"    

    wait_criteria {     
        wait_type = "ABSOLUTE_WAIT"
        wait_duration = "PT600S"
    }

    deploy_stage_predecessor_collection {       
        items {            
            id = oci_devops_deploy_stage.gru_devops-deploy-pipeline_motando-all_stage_shell_motando-webapp-init.id
        }
    } 
}

# STAGE #1: Shell command to initialize the CI (Web Application)
resource "oci_devops_deploy_stage" "gru_devops-deploy-pipeline_motando-all_stage_shell_motando-webapp" {
    provider = oci.gru     
    
    deploy_stage_type = "SHELL"
    deploy_pipeline_id = oci_devops_deploy_pipeline.gru_devops-deploy-pipeline_motando-all.id

    display_name = "Create CI to deploy motando-webapp"
    description = "Estágio que cria dois Container Instances para executar a aplicação Web"

    command_spec_deploy_artifact_id = oci_devops_deploy_artifact.gru_devops-deploy_artifact_shell-cmd-1_motando-webapp.id
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
            id = oci_devops_deploy_stage.gru_devops-deploy-pipeline_motando-all_stage_wait_motando-webapp-init.id
        }
    }   
}