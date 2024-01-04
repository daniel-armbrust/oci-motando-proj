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
                resource.type = 'devopstrigger'
            }
        }
    EOT
}

resource "oci_identity_policy" "iam_policy" {
    compartment_id = var.tenancy_id

    name = "motando-policies"
    description = "IAM Policies da aplicação Montado."

    statements = [
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to read secret-family in compartment id ${var.root_compartment}",
       "Allow dynamic-group ${oci_identity_dynamic_group.dyngrp_motando.name} to read devops-family in compartment id ${var.root_compartment}"
    ]
}