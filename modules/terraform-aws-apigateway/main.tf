resource "aws_apigatewayv2_api" "http_api" {
  name          = "lambda-http-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id             = aws_apigatewayv2_api.http_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = var.integration_uri_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}


# API Gateway Authorizer (Cognito)
resource "aws_api_gateway_authorizer" "cognito" {
  name          = "cognito-authorizer"
  rest_api_id   = aws_api_gateway_rest_api.main.id
  type          = "COGNITO_USER_POOLS"
  provider_arns = [var.aws_cognito_arn]
}

# # API Gateway Resource
# resource "aws_api_gateway_resource" "hello" {
#   rest_api_id = aws_api_gateway_rest_api.main.id
#   parent_id   = aws_api_gateway_rest_api.main.root_resource_id
#   path_part   = "hello"
# }

# # API Gateway Method
# resource "aws_api_gateway_method" "get_hello" {
#   rest_api_id   = aws_api_gateway_rest_api.main.id
#   resource_id   = aws_api_gateway_resource.hello.id
#   http_method   = "GET"
#   authorization = "COGNITO_USER_POOLS"
#   authorizer_id = aws_api_gateway_authorizer.cognito.id
# }

# # API Gateway Integration
# resource "aws_api_gateway_integration" "lambda" {
#   rest_api_id = aws_api_gateway_rest_api.main.id
#   resource_id = aws_api_gateway_resource.hello.id
#   http_method = aws_api_gateway_method.get_hello.http_method

#   integration_http_method = "POST"
#   type                   = "AWS_PROXY"
#   uri                    = var.integration_uri_arn
# }

# # API Gateway CORS - OPTIONS method
# resource "aws_api_gateway_method" "options_hello" {
#   rest_api_id   = aws_api_gateway_rest_api.main.id
#   resource_id   = aws_api_gateway_resource.hello.id
#   http_method   = "OPTIONS"
#   authorization = "NONE"
# }

# # API Gateway CORS - OPTIONS integration
# resource "aws_api_gateway_integration" "options_hello" {
#   rest_api_id = aws_api_gateway_rest_api.main.id
#   resource_id = aws_api_gateway_resource.hello.id
#   http_method = aws_api_gateway_method.options_hello.http_method

#   type = "MOCK"
#   request_templates = {
#     "application/json" = "{\"statusCode\": 200}"
#   }
# }

# API Gateway CORS - OPTIONS method response
resource "aws_api_gateway_method_response" "options_hello" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = aws_api_gateway_method.options_hello.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

# API Gateway CORS - OPTIONS integration response
resource "aws_api_gateway_integration_response" "options_hello" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = aws_api_gateway_method.options_hello.http_method
  status_code = aws_api_gateway_method_response.options_hello.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}

# API Gateway Method Response
resource "aws_api_gateway_method_response" "get_hello" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.hello.id
  http_method = aws_api_gateway_method.get_hello.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

# API Gateway Deployment
resource "aws_api_gateway_deployment" "main" {
  depends_on = [
    aws_api_gateway_method.get_hello,
    aws_api_gateway_integration.lambda,
    aws_api_gateway_method.options_hello,
    aws_api_gateway_integration.options_hello
  ]

  rest_api_id = aws_api_gateway_rest_api.main.id

  lifecycle {
    create_before_destroy = true
  }
}

# API Gateway Stage
resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = "default"

  tags = {
    Name        = "API-Stage"
  }
}