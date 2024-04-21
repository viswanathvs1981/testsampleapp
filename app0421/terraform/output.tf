/* resource "aws_s3_bucket" "customer_bucket" {
  bucket = "customer-data-bucket"
  tags = {
    Name        = "customer-data-bucket"
    Environment = "prod"
  }
}

resource "aws_athena_database" "customer_db" {
  name = "customer"
  depends_on = [
    aws_s3_bucket.customer_bucket
  ]
}

resource "aws_athena_table" "customer_table" {
  database = aws_athena_database.customer_db.name
  name     = "customer"
  depends_on = [
    aws_athena_database.customer_db
  ]

  column {
    name = "customer_id"
    type = "string"
  }

  column {
    name = "customer_name"
    type = "string"
  }

  column {
    name = "email"
    type = "string"
  }

  column {
    name = "phone_number"
    type = "string"
  }

  column {
    name = "address"
    type = "string"
  }
}
*/

output "customer_s3_bucket_name" {
  description = "The name of the S3 bucket where customer data is stored"
  value       = aws_s3_bucket.customer_bucket.bucket
}

output "athena_customer_database_name" {
  description = "The name of the Athena database where customer data is stored"
  value       = aws_glue_catalog_database.customer_glue_db.name
}

output "athena_customer_table_name" {
  description = "The name of the Athena table where customer data is stored"
  value       = aws_glue_catalog_table.customer_table.name
}