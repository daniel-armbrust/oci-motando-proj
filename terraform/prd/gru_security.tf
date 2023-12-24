#
# gru_security.tf
#

# SECURITY LIST - SUBNPRV OKE NODE POOL
resource "oci_core_security_list" "gru_secl-1_subnprv_oke_node_pool" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn.id
    display_name = "secl-1_subnprv_oke_node_pool"

    egress_security_rules {
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
        protocol = "all"
        stateless = false
    }

    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "all"
        source_type = "CIDR_BLOCK"
        stateless = false
    }
}

# SECURITY LIST - SUBNPUB OKE LB SERVICE
resource "oci_core_security_list" "gru_secl-1_subnpub_oke_lb" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn.id
    display_name = "secl-1_subnpub_oke_lb"

    egress_security_rules {
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
        protocol = "all"
        stateless = false
    }

    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "6" # tcp
        source_type = "CIDR_BLOCK"
        stateless = false

        tcp_options {   
            min = 80
            max = 80           

            source_port_range {                
                min = 1024
                max = 65535               
            }
        }
    }

    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "6" # tcp
        source_type = "CIDR_BLOCK"
        stateless = false

        tcp_options {   
            min = 443
            max = 443            

            source_port_range {                
                min = 1024
                max = 65535
                
            }
        }
    }

    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "1" # icmp
        source_type = "CIDR_BLOCK"
        stateless = false

        icmp_options {            
            type = "3"
            code = "4"
        }
    }
}

# SECURITY LIST - SUBNPUB OKE KUBE-APISERVER
resource "oci_core_security_list" "gru_secl-1_subnpub_oke_kubeapi" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn.id
    display_name = "secl-1_subnpub_oke_kubeapi"

    egress_security_rules {
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
        protocol = "all"
        stateless = false
    }    

    ingress_security_rules {
        source = "${local.my_public_ip}"
        protocol = "6" # tcp
        source_type = "CIDR_BLOCK"
        stateless = false

        tcp_options { 
            min = 6443  
            max = 6443           

            source_port_range {                
                min = 1024
                max = 65535
            }
        }
    }

    # Kubernetes worker to Kubernetes API endpoint communication.
    ingress_security_rules {
        source = "172.16.10.0/24"
        protocol = "6"
        source_type = "CIDR_BLOCK"
        stateless = false

        tcp_options { 
            min = 6443  
            max = 6443           

            source_port_range {                
                min = 1024
                max = 65535
            }
        }
    }    

    # Kubernetes worker to Kubernetes API endpoint communication.
    ingress_security_rules {
        source = "172.16.10.0/24"
        protocol = "6"
        source_type = "CIDR_BLOCK"
        stateless = false

        tcp_options { 
            min = 12250  
            max = 12250           

            source_port_range {                
                min = 1024
                max = 65535
            }
        }
    }    

    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "1" # icmp
        source_type = "CIDR_BLOCK"
        stateless = false

        icmp_options {            
            type = "3"
            code = "4"
        }
    }
}

# SECURITY LIST - SUBNPRV MYSQL
resource "oci_core_security_list" "gru_secl-1_subnprv_mysql" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn.id
    display_name = "secl-1_subnprv_mysql"

    egress_security_rules {
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
        protocol = "all"
        stateless = false
    }

    ingress_security_rules {
        source = "172.16.10.0/24"
        protocol = "6"
        source_type = "CIDR_BLOCK"
        stateless = false

        tcp_options { 
            min = 3306  
            max = 3306           

            source_port_range {                
                min = 1024
                max = 65535
            }
        }
    }

    ingress_security_rules {
        source = "172.16.60.0/24"
        protocol = "6"
        source_type = "CIDR_BLOCK"
        stateless = false

        tcp_options { 
            min = 3306  
            max = 3306           

            source_port_range {                
                min = 1024
                max = 65535
            }
        }
    }

    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "1" # icmp
        source_type = "CIDR_BLOCK"
        stateless = false

        icmp_options {            
            type = "3"
            code = "4"
        }
    }
}