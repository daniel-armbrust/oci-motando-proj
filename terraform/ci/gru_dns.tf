#
# gru_dns.tf - INTERNAL DNS (or Private DNS)
#

resource "oci_dns_view" "gru_dns_motando-private-view" {    
    provider = oci.gru

    compartment_id = var.root_compartment
    
    scope = "PRIVATE"
    display_name = "motando-private-view"
}

resource "oci_dns_zone" "gru_dns_motando-zone" {
    provider = oci.gru

    compartment_id = var.root_compartment
    view_id = oci_dns_view.gru_dns_motando-private-view.id
   
    name = "motando.cloud"
    zone_type = "PRIMARY"
    scope = "PRIVATE"
}

resource "oci_dns_rrset" "gru_dns_motando-rrset_redis" {
    provider = oci.gru

    compartment_id = var.root_compartment
    view_id = oci_dns_view.gru_dns_motando-private-view.id
    zone_name_or_id = oci_dns_zone.gru_dns_motando-zone.id

    scope = "PRIVATE"
    
    domain = "redis.motando.cloud"
    rtype = "CNAME" 
       
    items {        
        domain = "redis.motando.cloud"        
        rtype = "CNAME"        
        ttl = 300
        rdata = oci_redis_redis_cluster.gru_redis_motando-1.primary_fqdn
    }
}

resource "oci_dns_rrset" "gru_dns_motando-rrset_mysql" {
    provider = oci.gru

    compartment_id = var.root_compartment
    view_id = oci_dns_view.gru_dns_motando-private-view.id
    zone_name_or_id = oci_dns_zone.gru_dns_motando-zone.id

    scope = "PRIVATE"
    
    domain = "mysql.motando.cloud"
    rtype = "CNAME" 
       
    items {        
        domain = "mysql.motando.cloud"        
        rtype = "CNAME"        
        ttl = 300
        rdata = oci_mysql_mysql_db_system.gru_mysql_motando-1.endpoints[0].hostname
    }
}

resource "oci_dns_rrset" "gru_dns_motando-rrset_nlb_motando-tasks" {
    provider = oci.gru

    compartment_id = var.root_compartment
    view_id = oci_dns_view.gru_dns_motando-private-view.id
    zone_name_or_id = oci_dns_zone.gru_dns_motando-zone.id

    scope = "PRIVATE"
    
    domain = "tasks.motando.cloud"
    rtype = "A" 
       
    items {        
        domain = "tasks.motando.cloud"        
        rtype = "A"        
        ttl = 300
        rdata = oci_network_load_balancer_network_load_balancer.gru_nlb_motando-tasks.ip_addresses[0].ip_address
    }
}