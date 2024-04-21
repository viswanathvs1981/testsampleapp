resource "aws_s3_bucket" "customer_bucket" {
  // bucket = "customer-data-bucket"
  bucket = var.s3_bucket_name
  acl    = "private"
}
/*
resource "aws_glue_catalog_database" "customer_db" {
  name = "customer_db"
}

resource "aws_glue_catalog_table" "customer_table" {
  name          = "customer"
  database_name = aws_glue_catalog_database.customer_db.name

  storage_descriptor {
    location      = aws_s3_bucket.customer_bucket.bucket_domain_name
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    serde_info {
      name                  = "customer_data"
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"

      parameters = {
        "serialization.format" = "1"
      }
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
      name = "created_at"
      type = "timestamp"
    }
  }

  partition_keys {
    name = "created_at"
    type = "timestamp"
  }
}
*/