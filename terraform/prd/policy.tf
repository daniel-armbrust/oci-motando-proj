#
# policy.tf
#

resource "oci_identity_dynamic_group" "dyngrp_motando" {
    compartment_id = var.tenancy_id

    name = "motando-dyngrp"
    description = "Grupo dinâmico que concede acesso aos Recursos da aplicação Motando."

    matching_rule = "All {instance.compartment.id = '${var.root_compartment}'}"
}

resource "oci_identity_policy" "policy" {    
    compartment_id = var.tenancy_id

    name = "motando-policies"
    description = "IAM Policies da aplicação Montado."

    statements = [
       "Allow service objectstorage-sa-saopaulo-1 to manage object-family in compartment id ${var.root_compartment}", 
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to manage objects in compartment id ${var.root_compartment}",       
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to use log-content in compartment id ${var.root_compartment}"
    ]
}