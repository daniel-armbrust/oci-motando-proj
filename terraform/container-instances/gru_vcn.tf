#
# gru_vcn.tf - VCN
#

resource "oci_core_vcn" "gru_vcn_motando" {
    provider = oci.gru

    compartment_id = var.root_compartment
    cidr_blocks = ["192.168.0.0/16"]
    display_name = "vcn-motando"
    dns_label = "gruvcnmotando"
}

data "oci_core_vcn_dns_resolver_association" "gru_vcn_motando_dns_resolver_association" {        
    vcn_id = oci_core_vcn.gru_vcn_motando.id
}

resource "oci_dns_resolver" "gru_vcn_motando_dns-resolver" {    
    provider = oci.gru

    resolver_id = data.oci_core_vcn_dns_resolver_association.gru_vcn_motando_dns_resolver_association.dns_resolver_id
    
    attached_views {     
        view_id = oci_dns_view.gru_dns_motando-private-view.id
    }
}
