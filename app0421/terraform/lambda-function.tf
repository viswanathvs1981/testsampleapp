resource "aws_lambda_function" "customer_lambda" {
  //filename = "lambda-api-endpoint/customer.js"
  filename = "./lambda.zip"
  // function_name = "customerLambdaFunction"
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "customer.handler"
  runtime       = "nodejs14.x"
  timeout       = 30

  source_code_hash = filebase64sha256("./../lambda-api-endpoint/customer.js")
}
/*
resource "aws_api_gateway_rest_api" "customer_api" {
  name        = "customerAPI"
  description = "API for customer endpoints"
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

resource "aws_api_gateway_integration" "customer_integration" {
  rest_api_id             = aws_api_gateway_rest_api.customer_api.id
  resource_id             = aws_api_gateway_resource.customer_resource.id
  http_method             = aws_api_gateway_method.customer_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.customer_lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "200_response" {
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  resource_id = aws_api_gateway_resource.customer_resource.id
  http_method = aws_api_gateway_method.customer_method.http_method
  status_code = "200"
}
*/
/*
resource "aws_api_gateway_integration_response" "200_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  resource_id = aws_api_gateway_resource.customer_resource.id
  http_method = aws_api_gateway_method.customer_method.http_method
  status_code = 200 // aws_api_gateway_method_response.200_response.status_code 


  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_deployment" "customer_api_deployment" {
  depends_on  = [aws_api_gateway_integration.customer_integration]
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  stage_name  = "prod"
}
*/

//resource "aws_lambda_permission" "apigw_lambda_permission" {
// statement_id  = "AllowExecutionFromAPIGateway"
//action        = "lambda:InvokeFunction"
//function_name = aws_lambda_function.customer_lambda.function_name
//principal     = "apigateway.amazonaws.com"

//source_arn = "${aws_api_gateway_rest_api.customer_api.execution_arn}/*/${aws_api_gateway_method.customer_method.http_method}${aws_api_gateway_resource.customer_resource.path}"
//}
/*
resource "aws_s3_bucket" "customer_bucket" {
  bucket = "customer-bucket"
}
*/

resource "aws_s3_bucket_policy" "customer_bucket_policy" {
  bucket = aws_s3_bucket.customer_bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": ["${aws_s3_bucket.customer_bucket.arn}/*"], 
      "Principal": { "AWS": ["arn:aws:iam:::role/service-role/${aws_iam_role.lambda_role.name}"] }
    }
  ]
}
EOF
}

/* 
resource "aws_glue_catalog_database" "customer_db" {
  name = "customer_database"
}

resource "aws_glue_catalog_table" "customer_table" {
  name       = "customer"
  //database   = aws_glue_catalog_database.customer_db.name
  database_name = aws_glue_catalog_database.customer_db.name

  table_type = "EXTERNAL_TABLE"

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

  partition_keys {
    name = "created_at"
    type = "string"
  }

  storage_descriptor {
    location      = aws_s3_bucket.customer_bucket.arn
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name = "customer"
      parameters = { "serialization.format" = "1" }
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
  }
}
*/