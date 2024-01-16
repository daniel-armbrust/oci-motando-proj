#
# gru_vault.tf - Vault
#

resource "oci_kms_vault" "gru_vault_motando" {
    provider = oci.gru

    compartment_id = var.root_compartment
    display_name = "vault_motando"
    vault_type = "DEFAULT"    
}

resource "oci_kms_key" "gru_vault-enckey_motando" {
    provider = oci.gru

    compartment_id = var.root_compartment
    display_name = "aes_encryption-key"
    
    protection_mode = "SOFTWARE"
    management_endpoint = oci_kms_vault.gru_vault_motando.management_endpoint

    key_shape {        
        algorithm = "AES"
        length = 32 # Length of the key in bytes (32 bytes/8 = 256 bits)
    }
}

# GitHub - Personal access tokens (classic)
resource "oci_vault_secret" "gru_vault-secret_github-token" {
    provider = oci.gru

    compartment_id = var.root_compartment    
    vault_id = oci_kms_vault.gru_vault_motando.id
    key_id = oci_kms_key.gru_vault-enckey_motando.id

    secret_name = "secret_github-token-NEW-2"
    description = "GitHub - Personal access tokens (classic)"

    secret_content {        
        content_type = "BASE64"
        content = filebase64("./keys/github.token")
    }

    lifecycle {
       ignore_changes = [secret_name]
    }
}

# MySQL Admin Password
resource "oci_vault_secret" "gru_vault-secret_mysql-admin" {
    provider = oci.gru

    compartment_id = var.root_compartment    
    vault_id = oci_kms_vault.gru_vault_motando.id
    key_id = oci_kms_key.gru_vault-enckey_motando.id

    secret_name = "secret_mysql-admin_${formatdate("YYYY-MM-DD", timestamp())}"
    #secret_name = "secret_mysql-admin"
    description = "MySQL - Admin User Password"

    secret_content {        
        content_type = "BASE64"
        content = base64encode("${random_password.admin_password.result}")        
    }

    lifecycle {
       ignore_changes = [secret_name]
    }
}

# MySQL Web Application Password
resource "oci_vault_secret" "gru_vault-secret_mysql-webappl" {
    provider = oci.gru

    compartment_id = var.root_compartment    
    vault_id = oci_kms_vault.gru_vault_motando.id
    key_id = oci_kms_key.gru_vault-enckey_motando.id

    secret_name = "secret_mysql-webappl_${formatdate("YYYY-MM-DD", timestamp())}"
    #secret_name = "secret_mysql-webappl"
    description = "MySQL - Web Application User Password"

    secret_content {        
        content_type = "BASE64"
        content = base64encode("${random_password.webappl_password.result}")
    }

    lifecycle {
       ignore_changes = [secret_name]
    }
}

# Access KEY - OCI ObjectStorage Amazon S3 Compatibility API
resource "oci_vault_secret" "gru_vault-secret_motando-access-key" {
    provider = oci.gru

    compartment_id = var.root_compartment    
    vault_id = oci_kms_vault.gru_vault_motando.id
    key_id = oci_kms_key.gru_vault-enckey_motando.id

    secret_name = "secret_motando-access-key"
    description = "Motando - ACCESS KEY (ObjectStorage Amazon S3 Compatibility API)"

    secret_content {        
        content_type = "BASE64"
        content = base64encode("${var.motando_access_key}")
    }

    lifecycle {
       ignore_changes = [secret_name]
    }
}

# Secret KEY - OCI ObjectStorage Amazon S3 Compatibility API
resource "oci_vault_secret" "gru_vault-secret_motando-secret-key" {
    provider = oci.gru

    compartment_id = var.root_compartment    
    vault_id = oci_kms_vault.gru_vault_motando.id
    key_id = oci_kms_key.gru_vault-enckey_motando.id

    secret_name = "secret_motando-secret-key"
    description = "Motando - SECRET KEY (ObjectStorage Amazon S3 Compatibility API)"

    secret_content {        
        content_type = "BASE64"
        content = base64encode("${var.motando_secret_key}")
    }

    lifecycle {
       ignore_changes = [secret_name]
    }
}

#-------------------#
# Django Secret Key #
#-------------------#

resource "random_string" "django_random-secret-key" {
   length = 64
   special = true
   override_special = "/@#$%!&-_="
}

resource "oci_vault_secret" "gru_vault-secret_django-secret-key" {
    provider = oci.gru

    compartment_id = var.root_compartment    
    vault_id = oci_kms_vault.gru_vault_motando.id
    key_id = oci_kms_key.gru_vault-enckey_motando.id

    secret_name = "secret_django-secret-key"
    description = "Motando - DJANGO Framework Secret Key"

    secret_content {        
        content_type = "BASE64"
        content = base64encode("${random_string.django_random-secret-key.result}")
    }

    lifecycle {
       ignore_changes = [secret_name]
    }
}