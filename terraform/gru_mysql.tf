#
# gru_mysql.tf
#

resource "random_password" "password" {
    length = 12
    special = true
    override_special = "_%@"
}

/*
resource "oci_mysql_mysql_db_system" "gru_mysql_motando" {
    provider = oci.gru
    
    compartment_id = var.root_compartment

    display_name = "gru_mysql_motando"
    description = "MySQL Database for Motando application."

    shape_name = local.mysql_shapes.vm_standard_E31
    configuration_id = local.gru_mysql_configs.standalone_vm_standard_E31
    is_highly_available = false
    data_storage_size_in_gb = 50

    availability_domain = local.ads.gru_ad1_name    
    subnet_id = oci_core_subnet.gru_subnpub.id   
    hostname_label = "grymysqldb1"    

    admin_username = "admin"
    admin_password = random_password.password.result

    backup_policy {
        is_enabled = false        
    }

    maintenance {
        window_start_time = "sun 01:00"
    }
}

resource "oci_mysql_mysql_db_system" "gru_mysql_celery" {
    provider = oci.gru

    compartment_id = var.root_compartment

    display_name = "gru_mysql_celery"
    description = "MySQL Database for Celery application."

    shape_name = local.mysql_shapes.vm_standard_E31
    configuration_id = local.gru_mysql_configs.standalone_vm_standard_E31
    is_highly_available = false
    data_storage_size_in_gb = 50

    availability_domain = local.ads.gru_ad1_name    
    subnet_id = oci_core_subnet.gru_subnpub.id   
    hostname_label = "grymysqldb2"    

    admin_username = "admin"
    admin_password = random_password.password.result

    backup_policy {
        is_enabled = false        
    }

    maintenance {
        window_start_time = "sun 01:00"
    }
}
*/