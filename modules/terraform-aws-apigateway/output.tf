output "aws_apigatewayv2_arn" {
    value = "${aws_api_gateway_rest_api.main.execution_arn}/*/*"
}
# output "api_url" {
#   value = aws_apigatewayv2_api.http_api.api_endpoint
# }