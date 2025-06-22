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
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_arn"></a> [api\_gateway\_arn](#output\_api\_gateway\_arn) | n/a |
| <a name="output_lambda_integration_uri_arn"></a> [lambda\_integration\_uri\_arn](#output\_lambda\_integration\_uri\_arn) | output "instance\_public\_ips" { value = module.ec2.public\_instance\_ips } output "alb\_dns\_name" { value = module.ec2.alb\_dns\_name } |
