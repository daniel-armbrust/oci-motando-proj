#
# datasource.tf
# 

#
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/objectstorage_namespace
#
data "oci_objectstorage_namespace" "gru_objectstorage_ns" {
    provider = oci.gru
    compartment_id = var.tenancy_id
}