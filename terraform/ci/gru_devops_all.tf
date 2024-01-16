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
            id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-all_stage_delivery-artifact_motando-webapp.id
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

# STAGE #5: Create the Docker Image (Motando App Initialization)
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
            id = oci_devops_build_pipeline.gru_devops-build-pipeline_motando-all_stage_delivery-artifact_dramatiq-classifiedad.id
        }
    }    
}






