#
# gru_redis.tf - Redis
#

resource "oci_redis_redis_cluster" "gru_redis_motando-1" {
    provider = oci.gru
    
    compartment_id = var.root_compartment    
    display_name = "redis_motando-1"

    node_count = "2"
    node_memory_in_gbs = "4"
    software_version = "V7_0_5"
    subnet_id = oci_core_subnet.gru_subnet_svcs.id    
}