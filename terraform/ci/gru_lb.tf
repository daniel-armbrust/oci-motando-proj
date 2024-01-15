#
# gru_lb.tf - Load Balancer
#

resource "oci_load_balancer_load_balancer" "gru_lb_motando" {
    provider = oci.gru

    compartment_id = var.root_compartment

    display_name = "lb_motando"
    
    subnet_ids = [oci_core_subnet.gru_subnet_lb.id]
    is_private = false   
    
    shape = "flexible"

    shape_details {        
        maximum_bandwidth_in_mbps = 10
        minimum_bandwidth_in_mbps = 10
    }
}

resource "oci_load_balancer_backend_set" "gru_lb_motando-webapp_backend-set" {
    provider = oci.gru
    
    name = "motando-webapp_backend-set"
    policy = "IP_HASH"

    load_balancer_id = oci_load_balancer_load_balancer.gru_lb_motando.id

    health_checker {
        protocol = "TCP"        
        port = 8000
        interval_ms = 10000         
        timeout_in_millis = 3000
        retries = 3        
    }
}

resource "oci_load_balancer_listener" "gru_lb_motando-webapp_listener-http" {
    provider = oci.gru

    name = "listener-http"
    port = 80
    protocol = "HTTP"
    
    load_balancer_id = oci_load_balancer_load_balancer.gru_lb_motando.id
    default_backend_set_name = oci_load_balancer_backend_set.gru_lb_motando-webapp_backend-set.name

    connection_configuration {    
        idle_timeout_in_seconds = 30
    }   
}