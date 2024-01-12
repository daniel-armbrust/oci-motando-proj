#
# gru_subnets.tf - VCN Subnet
#

# Load Balancer Subnet - Public
resource "oci_core_subnet" "gru_subnet_lb" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    dhcp_options_id = oci_core_dhcp_options.gru_dhcp-options.id
    route_table_id = oci_core_route_table.gru_rtb_subnet_lb.id
    security_list_ids = [oci_core_security_list.gru_secl-1_subnet_lb.id]

    display_name = "subnet_lb"
    dns_label = "subnlb"
    cidr_block = "192.168.5.0/24"
    prohibit_public_ip_on_vnic = false
}

# Application Subnet - Private
resource "oci_core_subnet" "gru_subnet_appl" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    dhcp_options_id = oci_core_dhcp_options.gru_dhcp-options.id
    route_table_id = oci_core_route_table.gru_rtb_subnet_appl.id
    security_list_ids = [oci_core_security_list.gru_secl-1_subnet_appl.id]

    display_name = "subnet_appl"
    dns_label = "subnappl"
    cidr_block = "192.168.10.0/24"
    prohibit_public_ip_on_vnic = true
}

# Services Subnet - Private
resource "oci_core_subnet" "gru_subnet_svcs" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    dhcp_options_id = oci_core_dhcp_options.gru_dhcp-options.id
    route_table_id = oci_core_route_table.gru_rtb_subnet_svcs.id
    security_list_ids = [oci_core_security_list.gru_secl-1_subnet_svcs.id]

    display_name = "subnet_svcs"
    dns_label = "subnsvcs"
    cidr_block = "192.168.20.0/24"
    prohibit_public_ip_on_vnic = true
}

# Database Subnet - Private
resource "oci_core_subnet" "gru_subnet_db" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    dhcp_options_id = oci_core_dhcp_options.gru_dhcp-options.id
    route_table_id = oci_core_route_table.gru_rtb_subnet_db.id
    security_list_ids = [oci_core_security_list.gru_secl-1_subnet_db.id]

    display_name = "subnet_db"
    dns_label = "subndb"
    cidr_block = "192.168.40.0/24"
    prohibit_public_ip_on_vnic = true
}