#
# gru_gateways.tf - VCN Subnet Gateways
#

# SERVICE GATEWAY
resource "oci_core_service_gateway" "gru_sgw" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "sgw"

    services {
        service_id = local.gru_all_oci_services
    }
}

# NAT GATEWAY
resource "oci_core_nat_gateway" "gru_ngw" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "ngw"
    block_traffic = false
}

# INTERNET GATEWAY
resource "oci_core_internet_gateway" "gru_igw" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "igw"
    enabled = true
}