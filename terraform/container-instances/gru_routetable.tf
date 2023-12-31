#
# gru_routetable.tf - VCN Subnet Route Table
#

# Load Balancer Subnet - Public
resource "oci_core_route_table" "gru_rtb_subnet_lb" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "rtb_subnet_lb"

    # INTERNET GATEWAY
    route_rules {
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
        network_entity_id = oci_core_internet_gateway.gru_igw.id
        description = "INTERNET GATEWAY"
    }    
}

# Application Subnet - Private
resource "oci_core_route_table" "gru_rtb_subnet_appl" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "rtb_subnet_appl"

    # SERVICE GATEWAY
    route_rules {
        destination = "all-gru-services-in-oracle-services-network"
        destination_type = "SERVICE_CIDR_BLOCK"
        network_entity_id = oci_core_service_gateway.gru_sgw.id
        description = "SERVICE GATEWAY"
    }

    # NAT GATEWAY
    route_rules {
        destination = "0.0.0.0/0"
        destination_type = "CIDR_BLOCK"
        network_entity_id = oci_core_nat_gateway.gru_ngw.id
        description = "NAT GATEWAY"
    }    
}

# Services Subnet - Private
resource "oci_core_route_table" "gru_rtb_subnet_svcs" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "rtb_subnet_svcs"

    # SERVICE GATEWAY
    route_rules {
        destination = "all-gru-services-in-oracle-services-network"
        destination_type = "SERVICE_CIDR_BLOCK"
        network_entity_id = oci_core_service_gateway.gru_sgw.id
        description = "SERVICE GATEWAY"
    }   
}

# Database Subnet - Private
resource "oci_core_route_table" "gru_rtb_subnet_db" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "rtb_subnet_db"

    # SERVICE GATEWAY
    route_rules {
        destination = "all-gru-services-in-oracle-services-network"
        destination_type = "SERVICE_CIDR_BLOCK"
        network_entity_id = oci_core_service_gateway.gru_sgw.id
        description = "SERVICE GATEWAY"
    }   
}