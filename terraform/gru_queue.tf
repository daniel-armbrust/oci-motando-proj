#
# gru_queue.tf
#

resource "oci_queue_queue" "gru_queue_motando-classifiedad" {
    provider = oci.gru

    compartment_id = var.root_compartment
    display_name = "motando_classifiedad"

    retention_in_seconds = 432000 # 5 dias
    timeout_in_seconds = 30
    visibility_in_seconds = 30

    # A value of 0 indicates that the DLQ is not used.
    dead_letter_queue_delivery_count = 5
}