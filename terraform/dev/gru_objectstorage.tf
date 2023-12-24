#
# gru_objectstorage.tf
#

resource "oci_objectstorage_bucket" "gru_dev_motando-tmpimg" {
    provider = oci.gru
    
    compartment_id = var.root_compartment
    name = "dev_motando-tmpimg"
    namespace = local.gru_objectstorage_ns
    access_type = "ObjectReadWithoutList"
    versioning = "Disabled"
}

resource "oci_objectstorage_object_lifecycle_policy" "gru_dev_lifecycle-policy_motando-tmpimg" {
    provider = oci.gru

    bucket = oci_objectstorage_bucket.gru_dev_motando-tmpimg.name
    namespace = local.gru_objectstorage_ns

    rules {
        name = "delete-rule"
        action = "DELETE"
        is_enabled = true
        time_unit = "DAYS"
        time_amount = 1
    }
}

resource "oci_objectstorage_bucket" "gru_dev_motando-img" {
    provider = oci.gru
    
    compartment_id = var.root_compartment
    name = "dev_motando-img"
    namespace = local.gru_objectstorage_ns
    access_type = "ObjectReadWithoutList"
    versioning = "Disabled"
}

resource "oci_objectstorage_bucket" "gru_dev_motando-staticfiles" {
    provider = oci.gru
    
    compartment_id = var.root_compartment
    name = "dev_motando-staticfiles"
    namespace = local.gru_objectstorage_ns
    access_type = "ObjectReadWithoutList"
    versioning = "Disabled"
}

output "objectstorage_namespace" {
    value = local.gru_objectstorage_ns
}