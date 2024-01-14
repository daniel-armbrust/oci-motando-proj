#
# gru_nlb.tf - Network Load Balancer
#

resource "oci_network_load_balancer_network_load_balancer" "gru_nlb_motando-tasks" {
    provider = oci.gru
    
    compartment_id = var.root_compartment
    
    display_name = "nlb_motando-tasks"

    subnet_id = oci_core_subnet.gru_subnet_svcs.id    
    is_preserve_source_destination = false
    is_private = true        
}

resource "oci_network_load_balancer_listener" "nlb_motando-tasks_listener" {
    provider = oci.gru

    name = "xmlrpc"
    port = 8100
    protocol = "TCP"

    network_load_balancer_id = oci_network_load_balancer_network_load_balancer.gru_nlb_motando-tasks.id
    default_backend_set_name = oci_network_load_balancer_backend_set.gru_nlb_motando-tasks_bset-1.name        
}

resource "oci_network_load_balancer_backend_set" "gru_nlb_motando-tasks_backend-set" {   
    provider = oci.gru

    name = "motando-tasks_backend-set"

    network_load_balancer_id = oci_network_load_balancer_network_load_balancer.gru_nlb_motando-tasks.id
    policy = "FIVE_TUPLE"
    is_preserve_source = true

    health_checker {   
        protocol = "TCP"
        port = 8100
        retries = 3        
        interval_in_millis = 5000
        timeout_in_millis = 3000
    }           
}