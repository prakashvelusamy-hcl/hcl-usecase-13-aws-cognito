
# module "vpc" {
#   source         = "./modules/terraform-aws-vpc"
#   vpc_cidr       = var.vpc_cidr
#   pub_sub_count  = var.pub_sub_count
#   priv_sub_count = var.priv_sub_count
#   nat_count      = var.nat_count
#   env            = var.env
# }

module "lambda" {
  source = "./modules/terraform-aws-lambda"
  # private_subnet_id = module.vpc.private_subnet_ids
  # vpc_id = module.vpc.vpc_id
  aws_apigatewayv2_arn = module.api_gateway.aws_apigatewayv2_arn
  }

module "api_gateway" {
  source = "./modules/terraform-aws-apigateway"
  integration_uri_arn = module.lambda.integration_uri_arn
  aws_cognito_arn = module.aws_cognito.aws_cognito_arn
}

module "aws_cognito" {
  source = "./modules/terraform-aws-cognito"
}


# resource "aws_cognito_user_pool" "this" {
#   name = "my-user-pool"
# }

# resource "aws_cognito_user" "default_user" {
#   user_pool_id         = aws_cognito_user_pool.this.id
#   username             = "testuser"
#   temporary_password   = "TempPass123!"
#   message_action       = "SUPPRESS"
#   force_alias_creation = false
#   attributes = {
#     email = "testuser@example.com"
#   }
# }

# resource "aws_apigatewayv2_api" "this" {
#   name          = "my-http-api"
#   protocol_type = "HTTP"
# }

# resource "aws_apigatewayv2_authorizer" "cognito" {
#   name            = "cognito-authorizer"
#   api_id          = aws_apigatewayv2_api.this.id
#   authorizer_type = "JWT"

#   identity_sources = ["$request.header.Authorization"]

#   jwt_configuration {
#     audience = [aws_cognito_user_pool_client.this.id]
#     issuer   = "https://cognito-idp.${var.aws_region}.amazonaws.com/${aws_cognito_user_pool.this.id}"
#   }
# }

# resource "aws_cognito_user_pool_client" "this" {
#   name         = "user-pool-client"
#   user_pool_id = aws_cognito_user_pool.this.id

#   generate_secret = false
#   explicit_auth_flows = [
#     "ALLOW_USER_PASSWORD_AUTH",
#     "ALLOW_REFRESH_TOKEN_AUTH",
#     "ALLOW_ADMIN_USER_PASSWORD_AUTH",
#     "ALLOW_USER_SRP_AUTH"
#   ]

#   allowed_oauth_flows_user_pool_client = true
#   allowed_oauth_flows = ["code", "implicit"]
#   allowed_oauth_scopes = ["email", "openid", "profile"]
#   callback_urls = ["https://example.com/callback"]
#   logout_urls   = ["https://example.com/logout"]
#   supported_identity_providers = ["COGNITO"]
# }

# resource "aws_apigatewayv2_integration" "example" {
#   api_id             = aws_apigatewayv2_api.this.id
#   integration_type   = "MOCK"
#   integration_method = "GET"
#   payload_format_version = "1.0"
# }

# resource "aws_apigatewayv2_route" "protected" {
#   api_id    = aws_apigatewayv2_api.this.id
#   route_key = "GET /secure"

#   authorization_type = "JWT"
#   authorizer_id      = aws_apigatewayv2_authorizer.cognito.id
#   target             = "integrations/${aws_apigatewayv2_integration.example.id}"
# }

# resource "aws_apigatewayv2_stage" "default" {
#   api_id      = aws_apigatewayv2_api.this.id
#   name        = "$default"
#   auto_deploy = true
# }

# output "api_url" {
#   value = aws_apigatewayv2_api.this.api_endpoint
# }
