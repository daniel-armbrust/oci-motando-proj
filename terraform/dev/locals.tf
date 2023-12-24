#
# locals.tf
#

locals {         
   # Region Names
   # See: https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm
   region_names = {
      "gru" = "sa-saopaulo-1"   
   }

   # GRU Object Storage Namespace
   gru_objectstorage_ns = data.oci_objectstorage_namespace.gru_objectstorage_ns.namespace  
}