#
# gru_dhcpoptions.tf - VCN DHCP Options
#

resource "oci_core_dhcp_options" "gru_dhcp-options" {
    provider = oci.gru

    compartment_id = var.root_compartment
    vcn_id = oci_core_vcn.gru_vcn_motando.id
    display_name = "dhcp-options"

    options {
        type = "DomainNameServer"
        server_type = "VcnLocalPlusInternet"
    }
}