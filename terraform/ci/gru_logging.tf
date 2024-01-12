#
# gru_logging.tf - OCI Logging
#

resource "oci_logging_log_group" "gru_loggroup_motando" {   
    provider = oci.gru

    compartment_id = var.root_compartment
    display_name = "loggroup_motando"
    description = "Log Group usado pela aplicação MOTANDO"
}

resource "oci_logging_log" "gru_motando-log_webapp" {    
    provider = oci.gru

    display_name = "motando-log_webapp"
    log_group_id = oci_logging_log_group.gru_loggroup_motando.id
    log_type = "CUSTOM"
    is_enabled = true
    retention_duration = 30 # 30 dias  
}

resource "oci_logging_log" "gru_motando-log_workflow" {  
    provider = oci.gru
      
    display_name = "motando-log_workflow"
    log_group_id = oci_logging_log_group.gru_loggroup_motando.id
    log_type = "CUSTOM"
    is_enabled = true
    retention_duration = 30 # 30 dias  
}

# DevOps Service LOG
resource "oci_logging_log" "gru_service-log_devops" {  
    provider = oci.gru
      
    display_name = "service-log_devops"
    log_group_id = oci_logging_log_group.gru_loggroup_motando.id
    log_type = "SERVICE"
    is_enabled = true
    retention_duration = 30 # 30 dias  

    configuration {        
        source {            
            category = "ALL"
            resource = oci_devops_project.gru_devops_motando.id
            service = "DEVOPS"
            source_type = "OCISERVICE"            
        }

        compartment_id = var.root_compartment
    }
}