#
# datasource.tf
# 

#
# https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source
#
data "external" "get_my_public_ip" {
    program = ["bash", "./scripts/get_my_publicip.sh"]
}

#
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/core_services
#
data "oci_core_services" "gru_all_oci_services" {
    provider = oci.gru

    filter {
       name   = "name"
       values = ["All .* Services In Oracle Services Network"]
       regex  = true
    }
}

#
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_availability_domains
#
data "oci_identity_availability_domains" "gru_ads" {
    provider = oci.gru
    compartment_id = var.tenancy_id
}

#
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_fault_domains
#
data "oci_identity_fault_domains" "gru_fds" {
    provider = oci.gru
    compartment_id = var.tenancy_id
    availability_domain = local.ads["gru_ad1_name"]
}

#
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/objectstorage_namespace
#
data "oci_objectstorage_namespace" "gru_objectstorage_ns" {
    provider = oci.gru
    compartment_id = var.tenancy_id
}

data "oci_mysql_shapes" "mysql_shape_vm_standard-E31" {
   provider = oci.gru
   compartment_id = var.tenancy_id

   filter {
     name = "name"
     values = ["MySQL.VM.Standard.E3.1.8GB"]
   }
}

data "oci_mysql_mysql_configurations" "gru_mysqlconfig_standalone_vm_standard-E31" {
   provider = oci.gru
   compartment_id = var.tenancy_id

   filter {
     name = "shape_name"
     values = ["MySQL.VM.Standard.E3.1.8GB"]
     regex = false
   }
}