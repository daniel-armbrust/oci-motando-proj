#
# gru_container.tf - Container Instances
# 

/*
resource "oci_container_instances_container_instance" "gru_ci-webapp-1" {
    provider = oci.gru
    
    compartment_id = var.root_compartment
    display_name = "ci-app-1"
    
    availability_domain = local.ads.gru_ad1_name
    fault_domain = local.fds.gru_fd1_id    

    shape = "CI.Standard.E4.Flex"

    shape_config {        
        ocpus = 2
        memory_in_gbs = 4
    }

    vnics {        
        display_name = "vnic-1_ci-app-1"
        
        subnet_id = oci_core_subnet.test_subnet.id        
        hostname_label = "ciapp1"       
                
        is_public_ip_assigned = false
    }
    
    container_restart_policy = "ON_FAILURE"
    
    containers {        
        image_url = var.container_instance_containers_image_url
        display_name = var.container_instance_containers_display_name
        
        environment_variables = {
            "APP_ENV" = "PRD",
            "OCI_REGION_ID" = "sa-saopaulo-1",
            "OCI_OBJSTR_NAMESPACE" = "",
            "WEBAPP_OCI_LOG_ID" = "",
            "OCI_BUCKET_MOTANDO_IMG" = "",
            "OCI_BUCKET_MOTANDO_IMGTMP" = "",
            "OCI_STATICFILES_BUCKET_NAME" = "",
            "CLASSIFIEDAD_XMLRPC_HOST" = "",
            "CLASSIFIEDAD_XMLRPC_PORT" = "8100",
            "OCI_ACCESS_KEY" = "",
            "OCI_SECRET_KEY" = "",
            "DJANGO_SECRET_KEY" = "",
            "MYSQL_DBNAME" = "motandodb",
            "MYSQL_USER" = "motandousr",
            "MYSQL_PASSWD" = "",
            "MYSQL_HOST" = ""
        }
        
        health_checks {            
            health_check_type = "TCP"
            port = 8000
            initial_delay_in_seconds = 10
            interval_in_seconds = 5
            failure_action = "KILL"
            failure_threshold = 1
        }

        is_resource_principal_disabled = true               
    }
}
*/