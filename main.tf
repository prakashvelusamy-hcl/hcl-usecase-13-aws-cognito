
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
  api_gateway_arn = module.api_gateway.api_gateway_arn
  aws_lambda_function_name = var.aws_lambda_function_name
  project_tags = var.project_tags
}

module "api_gateway" {
  source = "./modules/terraform-aws-apigateway"
  lambda_integration_uri_arn = module.lambda.lambda_integration_uri_arn
  aws_cognito_arn = module.aws_cognito.aws_cognito_arn
  cognito_user_pool_id = module.aws_cognito.cognito_user_pool_id
  cognito_user_pool_client_id = module.aws_cognito.cognito_user_pool_client_id
  aws_region = var.aws_region
  route_key= var.route_key
  project_tags = var.project_tags
}

module "aws_cognito" {
  source = "./modules/terraform-aws-cognito"
  aws_region = var.aws_region
  cognito_user_pool_name = var.cognito_user_pool_name
  cognito_user_pool_client_name = var.cognito_user_pool_client_name
  full_api_url = module.api_gateway.full_api_url
  project_tags = var.project_tags
}

