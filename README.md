## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | ./modules/terraform-aws-apigateway | n/a |
| <a name="module_aws_cognito"></a> [aws\_cognito](#module\_aws\_cognito) | ./modules/terraform-aws-cognito | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./modules/terraform-aws-lambda | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_lambda_function_name"></a> [aws\_lambda\_function\_name](#input\_aws\_lambda\_function\_name) | The lambda function name | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where the infrastructure will be deployed (e.g., ap-south-1). | `string` | n/a | yes |
| <a name="input_cognito_user_pool_client_name"></a> [cognito\_user\_pool\_client\_name](#input\_cognito\_user\_pool\_client\_name) | The name of the client application for the Cognito User Pool. | `string` | n/a | yes |
| <a name="input_cognito_user_pool_name"></a> [cognito\_user\_pool\_name](#input\_cognito\_user\_pool\_name) | The name of the AWS Cognito User Pool to be created or referenced. | `string` | n/a | yes |
| <a name="input_project_tags"></a> [project\_tags](#input\_project\_tags) | A map of tags to assign to the Lambda function. | `map(string)` | n/a | yes |
| <a name="input_route_key"></a> [route\_key](#input\_route\_key) | The route key for the API Gateway HTTP API, typically in the format 'METHOD /path' (e.g., 'GET /users'). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_arn"></a> [api\_gateway\_arn](#output\_api\_gateway\_arn) | n/a |
| <a name="output_cognito_login_url"></a> [cognito\_login\_url](#output\_cognito\_login\_url) | n/a |
| <a name="output_full_api_url"></a> [full\_api\_url](#output\_full\_api\_url) | n/a |
| <a name="output_lambda_integration_uri_arn"></a> [lambda\_integration\_uri\_arn](#output\_lambda\_integration\_uri\_arn) | output "instance\_public\_ips" { value = module.ec2.public\_instance\_ips } output "alb\_dns\_name" { value = module.ec2.alb\_dns\_name } |
