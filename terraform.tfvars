# vpc_cidr        = "10.10.0.0/16"
# env = "dev"
# pub_sub_count   = 0
# priv_sub_count  = 0
# nat_count       = 0
# public_instance = 0
aws_region = "ap-south-1"
route_key = "hello"
aws_lambda_function_name = "hello_lambda_cognito"
cognito_user_pool_name = "prakash-cognito"
cognito_user_pool_client_name = "prakash-cognito-client"
project_tags = {
  Environment = "dev"
  Project     = "HelloLambdaCognito"
  Owner       = "dev-team"
}