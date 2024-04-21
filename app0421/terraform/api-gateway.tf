resource "aws_api_gateway_rest_api" "customer_api" {
  // name        = "customer-api"
  name        = var.api_name
  description = "REST API for customer endpoint"
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
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  resource_id = aws_api_gateway_resource.customer_resource.id
  http_method = aws_api_gateway_method.customer_method.http_method
  type        = "AWS_PROXY"
  uri         = aws_lambda_function.customer_lambda.arn
}

resource "aws_api_gateway_method_response" "api_gw_200_response" {
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  resource_id = aws_api_gateway_resource.customer_resource.id
  http_method = aws_api_gateway_method.customer_method.http_method
  status_code = "200"
  depends_on  = [aws_api_gateway_integration.lambda_integration]
}

resource "aws_api_gateway_integration_response" "api_gw_200_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  resource_id = aws_api_gateway_resource.customer_resource.id
  http_method = aws_api_gateway_method.customer_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.customer_api.id
  stage_name  = "prod"
}

resource "aws_lambda_permission" "apigw_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.customer_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = aws_api_gateway_deployment.api_deployment.execution_arn
}