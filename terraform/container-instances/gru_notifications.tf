#
# gru_notifications.tf - Notifications
#

resource "oci_ons_notification_topic" "gru_devops_notification-topic" {
    provider = oci.gru

    compartment_id = var.root_compartment
    name = "devops_notification-topic"    
}