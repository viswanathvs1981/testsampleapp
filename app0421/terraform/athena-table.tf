/*
resource "aws_s3_bucket" "customer_data_bucket" {
  bucket = "customer-data-bucket"
  acl    = "private"
}
*/
resource "aws_glue_catalog_database" "customer_glue_db" {
  //name = "customer_glue_db"
  name = var.athena_database
}

resource "aws_glue_catalog_table" "customer_table" {
  // name          = "customer"
  name          = var.athena_table_name
  database_name = aws_glue_catalog_database.customer_glue_db.name

  table_type = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = aws_s3_bucket.customer_bucket.bucket_domain_name
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name = "customer"
      parameters = {
        "serialization.format" = "1"
      }
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
    }

    columns {
      name = "customer_id"
      type = "string"
    }

    columns {
      name = "first_name"
      type = "string"
    }

    columns {
      name = "last_name"
      type = "string"
    }

    columns {
      name = "email"
      type = "string"
    }

    columns {
      name = "phone_number"
      type = "string"
    }

    columns {
      name = "address"
      type = "string"
    }

    columns {
      name = "city"
      type = "string"
    }

    columns {
      name = "state"
      type = "string"
    }

    columns {
      name = "zipcode"
      type = "string"
    }

    columns {
      name = "country"
      type = "string"
    }

    columns {
      name = "created_at"
      type = "timestamp"
    }
  }

  partition_keys {
    name = "created_at"
    type = "timestamp"
  }

}