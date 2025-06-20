output "lambda_integration_uri_arn" {
value = aws_lambda_function.docker_lambda.invoke_arn
}