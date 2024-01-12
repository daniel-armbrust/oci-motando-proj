#
# policy.tf - IAM Policies
#

resource "oci_identity_dynamic_group" "dyngrp_motando" {
    compartment_id = var.tenancy_id

    name = "motando-dyngrp"
    description = "Grupo dinâmico que concede acesso aos Recursos da aplicação Motando."

    matching_rule = <<-EOT
        All {
            resource.compartment.id = '${var.root_compartment}', 
            
            Any {
                resource.type = 'devopsdeploypipeline', 
                resource.type = 'devopsbuildpipeline', 
                resource.type = 'devopsrepository', 
                resource.type = 'devopsconnection', 
                resource.type = 'devopstrigger',
                resource.type = 'computecontainerinstance'
            }
        }
    EOT
}

resource "oci_identity_policy" "iam_policy" {
    compartment_id = var.tenancy_id

    name = "motando-policies"
    description = "IAM Policies da aplicação Montado."

    statements = [
       "Allow service objectstorage-sa-saopaulo-1 to manage object-family in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to manage objects in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to use log-content in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to read secret-family in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to manage devops-family in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to use ons-topics in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to use adm-knowledge-bases in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to manage repos in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to manage compute-container-instances in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to manage compute-containers in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to use vnics in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to use subnets in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to use dhcp-options in compartment id ${var.root_compartment}"
    ]
}