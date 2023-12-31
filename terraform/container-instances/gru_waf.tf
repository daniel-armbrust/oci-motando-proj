#
# gru_waf.tf - Web Application Firewall (WAF)
#

resource "oci_waf_web_app_firewall" "gru_waf_motando" {
    provider = oci.gru

    compartment_id = var.root_compartment

    display_name = "waf_motando"

    backend_type = "LOAD_BALANCER"
    
    load_balancer_id = oci_load_balancer_load_balancer.gru_lb_motando.id
    web_app_firewall_policy_id = oci_waf_web_app_firewall_policy.gru_waf-policy_motando.id
}

resource "oci_waf_web_app_firewall_policy" "gru_waf-policy_motando" {
    provider = oci.gru

    compartment_id = var.root_compartment

    display_name = "waf-policy_motando"
}