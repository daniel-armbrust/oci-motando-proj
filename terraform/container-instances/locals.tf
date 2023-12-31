#
# locals.tf
#

locals {    
   # My Public IP Address
   my_public_ip = data.external.get_my_public_ip.result.my_public_ip

   anywhere = "0.0.0.0/0" 
   all_protocols = "all"

   # IANA protocol numbers
   icmp_protocol = 1
   tcp_protocol = 6
   udp_protocol = 17
   
   # Service Gateway
   gru_all_oci_services = lookup(data.oci_core_services.gru_all_oci_services.services[0], "id")
   gru_oci_services_cidr_block = lookup(data.oci_core_services.gru_all_oci_services.services[0], "cidr_block")   
   
   # Region Names
   # See: https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm
   region_names = {
      "gru" = "sa-saopaulo-1"   
   }

   # GRU Object Storage Namespace
   gru_objectstorage_ns = data.oci_objectstorage_namespace.gru_objectstorage_ns.namespace

   # Availability Domains
   ads = {
      gru_ad1_id = data.oci_identity_availability_domains.gru_ads.availability_domains[0].id
      gru_ad1_name = data.oci_identity_availability_domains.gru_ads.availability_domains[0].name
   }
 
   # Fault Domains
   fds = {
      gru_fd1_id = data.oci_identity_fault_domains.gru_fds.fault_domains[0].id,
      gru_fd1_name = data.oci_identity_fault_domains.gru_fds.fault_domains[0].name,

      gru_fd2_id = data.oci_identity_fault_domains.gru_fds.fault_domains[1].id,
      gru_fd2_name = data.oci_identity_fault_domains.gru_fds.fault_domains[1].name,

      gru_fd3_id = data.oci_identity_fault_domains.gru_fds.fault_domains[2].id,
      gru_fd3_name = data.oci_identity_fault_domains.gru_fds.fault_domains[2].name           
   }

   #
   # See: https://docs.oracle.com/en-us/iaas/images/
   #
   compute_image_id = {
      "gru" = {
         "centos7" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaarihpw2lfked2jfoigpma3e7dkt36gw6yg26ceh6zup4jvthj7jkq",
         "centos8" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaji7374dd3t5rjllcvskopfydco24lf2c62jitixxdxwncdlanfvq",
         "ol7" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa4vkhemdkmfe3icxzzdkgfnfijybzzhrz63icerlq7oyzdoe3mv6a",
         "ol8" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaacsn7itsqbert6n7g4ywxrhmyrocfigqi5jmrhfwfxl4rlvjz2fyq",
         "ol8-arm" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaozkkrr2ef4z4xdtgbwqnhbk5p5fkozuyxqt7cy37h3ifzywdmoiq",
         "ol85-oke" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaads2eehsw7wr6z3cde6q4vxpkvkmmutwr7n7akhwyavalpqwg7cpa",
         "ol88-oke" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaahjfhb52zwbhtqutdjklpruaax5uwocvijfiukpnozviy2jcgsn2a",
         "ol88arm-oke" = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa63wo5saymjkxhrjw6kqprpfs3q3ggbpfe2ftbwtikee5qnq3fqlq"
      }
   }

   # MySQL Configurations
   gru_mysql_configs = {   
      standalone_vm_standard_E31 = data.oci_mysql_mysql_configurations.gru_mysqlconfig_standalone_vm_standard-E31.configurations[0].id      
   }

   # MySQL Shapes
   mysql_shapes = {     
      vm_standard_E31 = data.oci_mysql_shapes.mysql_shape_vm_standard-E31.shapes[0].name
   }
}