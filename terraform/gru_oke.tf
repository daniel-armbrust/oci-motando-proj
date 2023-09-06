#
# gru_oke.tf
#

//
// OKE API Specification
//     https://docs.oracle.com/en-us/iaas/api/#/en/containerengine/20180222/datatypes/CreateClusterDetails
//

resource "oci_containerengine_cluster" "gru_oke_motando" {
    provider = oci.gru

    compartment_id = var.root_compartment
    kubernetes_version = "v1.27.2"
    name = "oke_motando"
    vcn_id = oci_core_vcn.gru_vcn.id
   
    cluster_pod_network_options {    
        cni_type = "FLANNEL_OVERLAY"
    }
    
    # kube-apiserver
    endpoint_config {        
        is_public_ip_enabled = true
        subnet_id = oci_core_subnet.gru_subnpub_oke_kubeapi.id
    }    
   
    options {        
        add_ons {            
            is_kubernetes_dashboard_enabled = false
            is_tiller_enabled = false
        }

        admission_controller_options {            
            is_pod_security_policy_enabled = false
        }

        kubernetes_network_config {            
            pods_cidr = "10.244.0.0/16"
            services_cidr = "10.96.0.0/16"
        }
        
        service_lb_subnet_ids = [oci_core_subnet.gru_subnpub_oke_lb.id]
    }

    type = "BASIC_CLUSTER"
}

resource "oci_containerengine_node_pool" "gru_oke_motando_np-1" {    
    cluster_id = oci_containerengine_cluster.gru_oke_motando.id

    compartment_id = var.root_compartment
    name = "gru_oke_motando_np-1"
    node_shape = "VM.Standard.E4.Flex"        
    kubernetes_version = "v1.27.2"

    node_config_details {        
        placement_configs {            
            availability_domain = local.ads.gru_ad1_name
            subnet_id = oci_core_subnet.gru_subnprv_oke_node_pool.id            
        }

        size = 3
       
        node_pool_pod_network_option_details {            
            cni_type = "FLANNEL_OVERLAY"
        }        
    }

    node_shape_config {
        memory_in_gbs = "6"
        ocpus = "2"
    }

    node_source_details {        
        image_id = local.compute_image_id.gru.ol88-oke
        source_type = "IMAGE"
        boot_volume_size_in_gbs = 150
    }

    ssh_public_key = file("./keys/default.ssh_pubkey")     
}