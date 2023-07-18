#
# gru_logging.tf
#

resource "oci_logging_log_group" "gru_loggroup_motando" {    
    compartment_id = var.root_compartment
    display_name = "gru_loggroup_motando"
    description = "Log Group usado pela aplicação MOTANDO"
}

resource "oci_logging_log" "gru_motando-log_webapp" {    
    display_name = "gru_motando-log_webapp"
    log_group_id = oci_logging_log_group.gru_loggroup_motando.id
    log_type = "CUSTOM"
    is_enabled = true
    retention_duration = 30 # 30 dias  
}

resource "oci_logging_log" "gru_motando-log_workflow" {    
    display_name = "gru_motando-log_workflow"
    log_group_id = oci_logging_log_group.gru_loggroup_motando.id
    log_type = "CUSTOM"
    is_enabled = true
    retention_duration = 30 # 30 dias  
}

resource "oci_logging_log" "gru_motando-log_chat" {    
    display_name = "gru_motando-log_chat"
    log_group_id = oci_logging_log_group.gru_loggroup_motando.id
    log_type = "CUSTOM"
    is_enabled = true
    retention_duration = 30 # 30 dias  
}