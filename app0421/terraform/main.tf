/* provider "aws" {
  region = "us-east-1"
}
*/

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  path               = "/"
  assume_role_policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../lambda-api-endpoint"
  output_path = "./lambda.zip"
}
/* 
resource "aws_lambda_function" "customer_lambda" {
  function_name    = "CustomerFunction"
  handler          = "customer.handler"
  runtime          = "nodejs14.x"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  role             = aws_iam_role.lambda_role.arn
  timeout          = 60
}

resource "aws_api_gateway_rest_api" "customer_api" {
  name        = "CustomerAPI"
  description = "API for managing customers"
}

resource "aws_api_gateway_resource" "customer_resource" {
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  parent_id   = aws_api_gateway_rest_api.customer_api.root_resource_id
  path_part   = "customer"
}

resource "aws_api_gateway_method" "customer_method" {
  rest_api_id   = aws_api_gateway_rest_api.customer_api.id
  resource_id   = aws_api_gateway_resource.customer_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.customer_api.id
  resource_id             = aws_api_gateway_resource.customer_resource.id
  http_method             = aws_api_gateway_method.customer_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.customer_lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "method_response_200" {
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  resource_id = aws_api_gateway_resource.customer_resource.id
  http_method = aws_api_gateway_method.customer_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "integration_response" {
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  resource_id = aws_api_gateway_resource.customer_resource.id
  http_method = aws_api_gateway_method.customer_method.http_method
  status_code = aws_api_gateway_method_response.method_response_200.status_code
}

resource "aws_s3_bucket" "customer_bucket" {
  bucket = "customer-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}
/* 
resource "aws_glue_catalog_database" "customer_database" {
  name = "customer_database"
}

resource "aws_glue_catalog_table" "customer_table" {
  database_name = aws_glue_catalog_database.customer_database.name
  name          = "customer"

  table_input {
    name            = "customer"
    description     = "Customer data from S3 Bucket"
    classification  = "json"
    output_location = "s3://${aws_s3_bucket.customer_bucket.bucket}/"

    columns {
      name = "CustomerID"
      type = "int"
    }

    columns {
      name = "FirstName"
      type = "string"
    }

    columns {
      name = "LastName"
      type = "string"
    }

    // Add all necessary columns here
    columns {
      name = "Email"
      type = "string"
    }

    columns {
      name = "Phone"
      type = "string"
    }

    columns {
      name = "Address"
      type = "string"
    }

    // Continue adding all the required customer attributes
  }
}
*/