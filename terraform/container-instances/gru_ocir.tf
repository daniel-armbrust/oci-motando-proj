#
# gru_ocir.tf - Oracle Cloud Infrastructure Container Registry (OCIR)
#

resource "oci_artifacts_container_repository" "gru_ocir_motando-webapp" {
    provider = oci.gru
    
    compartment_id = var.root_compartment
    
    display_name = "motando-webapp"
   
    is_immutable = false
    is_public = false
}