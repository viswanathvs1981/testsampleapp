variable "customer_schema" {
  type        = string
  description = "The schema for the customer details in JSON format"
}

variable "aws_region" {
  type        = string
  description = "The AWS region where the resources will be created"
}

variable "api_name" {
  type        = string
  description = "The name of the API Gateway"
}

variable "lambda_function_name" {
  type        = string
  description = "The name of the Lambda function"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store customer data"
}

variable "athena_database" {
  type        = string
  description = "The name of the Athena database"
}

variable "athena_table_name" {
  type        = string
  description = "The name of the Athena table to store customer data"
}

variable "athena_data_path" {
  type        = string
  description = "The S3 path where Athena will store data"
}