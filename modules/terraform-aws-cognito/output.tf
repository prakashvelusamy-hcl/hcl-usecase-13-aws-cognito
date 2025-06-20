output "aws_cognito_arn" {
    value = aws_cognito_user_pool.main.arn
}
output "cognito_user_pool_id" {
value = aws_cognito_user_pool.main.id
}

output "cognito_user_pool_client_id" {
value = aws_cognito_user_pool_client.main.id
}