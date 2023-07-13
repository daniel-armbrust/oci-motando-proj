#
# gru_nosql.tf
#

resource "oci_nosql_table" "nosql_table_chats" {    
    compartment_id = var.root_compartment
    name = "motando_chats"
    ddl_statement = <<EOS
        CREATE TABLE IF NOT EXISTS motando_chats (
           id INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1),
           classifiedad_id INTEGER,                             
           user_from_id INTEGER,
           user_from_fullname STRING,
           user_from_email STRING,
           user_from_telephone STRING,
           user_to_id INTEGER,
           user_to_fullname STRING,
           user_to_email STRING,
           user_to_telephone STRING,  
           messages JSON,         
        PRIMARY KEY(id)) USING TTL 15 days
    EOS

    table_limits {
        max_read_units = 1
        max_write_units = 1
        max_storage_in_gbs = 1
    }
}

resource "oci_nosql_index" "nosql_index_user-from-email" {
    keys {
        column_name = "user_from_email"
    }

    name = "user_from_email_idx"
    table_name_or_id = oci_nosql_table.nosql_table_chats.id
    compartment_id = var.root_compartment    
}

resource "oci_nosql_index" "nosql_index_user-to-email" {
    keys {
        column_name = "user_to_email"
    }

    name = "user_to_email_idx"
    table_name_or_id = oci_nosql_table.nosql_table_chats.id
    compartment_id = var.root_compartment    
}

resource "oci_nosql_index" "nosql_index_user-from-id" {
    keys {
        column_name = "user_from_id"
    }

    name = "user_from_id_idx"
    table_name_or_id = oci_nosql_table.nosql_table_chats.id
    compartment_id = var.root_compartment    
}

resource "oci_nosql_index" "nosql_index_user-to-id" {
    keys {
        column_name = "user_to_id"
    }

    name = "user_to_id_idx"
    table_name_or_id = oci_nosql_table.nosql_table_chats.id
    compartment_id = var.root_compartment    
}