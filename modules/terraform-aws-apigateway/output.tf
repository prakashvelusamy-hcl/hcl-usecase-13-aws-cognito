# output "api_url" {
#   value = aws_apigatewayv2_api.http_api.api_endpoint
# }
output "api_gateway_arn" {
    value = aws_apigatewayv2_api.http_api.arn
}