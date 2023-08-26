#
# gru_subnets.tf
#

# SUBNET - OKE NODE POOL
resource "oci_core_subnet" "gru_subnprv_oke_node_pool" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn.id
    dhcp_options_id = oci_core_dhcp_options.gru_dhcp-options.id
    route_table_id = oci_core_route_table.gru_rtb_subnprv.id
    security_list_ids = [oci_core_security_list.gru_secl-1_subnprv_oke_node_pool.id]

    display_name = "subnprvokendpl"
    dns_label = "subnprvokendpl"
    cidr_block = "172.16.10.0/24"
    prohibit_public_ip_on_vnic = true
}

# SUBNET - OKE LB SERVICE
resource "oci_core_subnet" "gru_subnpub_oke_lb" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn.id
    dhcp_options_id = oci_core_dhcp_options.gru_dhcp-options.id
    route_table_id = oci_core_route_table.gru_rtb_subnpub.id
    security_list_ids = [oci_core_security_list.gru_secl-1_subnpub_oke_lb.id]

    display_name = "subnpubokelb"
    dns_label = "subnpubokelb"
    cidr_block = "172.16.30.0/24"
    prohibit_public_ip_on_vnic = false
}

# SUBNET - OKE KUBE-APISERVER
resource "oci_core_subnet" "gru_subnpub_oke_kubeapi" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn.id
    dhcp_options_id = oci_core_dhcp_options.gru_dhcp-options.id
    route_table_id = oci_core_route_table.gru_rtb_subnpub.id
    security_list_ids = [oci_core_security_list.gru_secl-1_subnpub_oke_kubeapi.id]

    display_name = "subnpubokekapi"
    dns_label = "subnpubokekapi"
    cidr_block = "172.16.40.0/28"
    prohibit_public_ip_on_vnic = false
}