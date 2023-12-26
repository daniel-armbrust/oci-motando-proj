#
# gru_logging.tf
#

resource "oci_logging_log_group" "gru_dev_loggroup_motando" {   
    provider = oci.gru

    compartment_id = var.root_compartment
    display_name = "dev_loggroup_motando"
    description = "Log Group usado pela aplicação MOTANDO para ambiente de desenvolvimento."
}

resource "oci_logging_log" "gru_dev_motando-log_webapp" {    
    provider = oci.gru

    display_name = "dev_motando-log_webapp"
    log_group_id = oci_logging_log_group.gru_dev_loggroup_motando.id
    log_type = "CUSTOM"
    is_enabled = true
    retention_duration = 30 # 30 dias  
}

output "gru_dev_motando-log_webapp_id" {   
    value = oci_logging_log.gru_dev_motando-log_webapp.id
}

resource "oci_logging_log" "gru_dev_motando-log_workflow" {  
    provider = oci.gru
      
    display_name = "dev_motando-log_workflow"
    log_group_id = oci_logging_log_group.gru_dev_loggroup_motando.id
    log_type = "CUSTOM"
    is_enabled = true
    retention_duration = 30 # 30 dias  
}

output "gru_dev_motando-log_workflow_id" {    
    value = oci_logging_log.gru_dev_motando-log_workflow.id
}