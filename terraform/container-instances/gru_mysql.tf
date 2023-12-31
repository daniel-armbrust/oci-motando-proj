#
# gru_mysql.tf - MySQL Database
#

resource "random_password" "password" {
    length = 12
    special = true    
    min_upper = 1
    min_lower = 1
    min_numeric = 1   
    min_special = 1 
    override_special = "$()-_<>"
}

resource "oci_mysql_mysql_db_system" "gru_mysql_motando-1" {
    provider = oci.gru
    
    compartment_id = var.root_compartment

    display_name = "mysql_motando-1"
    description = "MySQL Database for Motando application."

    shape_name = local.mysql_shapes.vm_standard_E31
    configuration_id = local.gru_mysql_configs.standalone_vm_standard_E31
    is_highly_available = false
    data_storage_size_in_gb = 50

    availability_domain = local.ads.gru_ad1_name    
    subnet_id = oci_core_subnet.gru_subnet_db.id   
    hostname_label = "mysql1"    

    admin_username = "admin"
    admin_password = random_password.password.result    

    backup_policy {
        is_enabled = false        
    }

    maintenance {
        window_start_time = "sun 01:00"
    }
}

output "gru_mysql_motando-1_passwd" {
  value = element(random_password.password[*].result, 1)
  sensitive = true
}