#
# gru_security.tf - VCN Subnet Security List
#

# Load Balancer Subnet - Public
resource "oci_core_security_list" "gru_secl-1_subnet_lb" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "secl-1_subnet_lb"

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

# Application Subnet - Private
resource "oci_core_security_list" "gru_secl-1_subnet_appl" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "secl-1_subnet_appl"

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

# Services Subnet - Private
resource "oci_core_security_list" "gru_secl-1_subnet_svcs" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "secl-1_subnet_svcs"

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

# Database Subnet - Private
resource "oci_core_security_list" "gru_secl-1_subnet_db" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "secl-1_subnet_db"

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