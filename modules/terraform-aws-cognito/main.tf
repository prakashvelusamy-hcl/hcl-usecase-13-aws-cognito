resource "aws_cognito_user_pool_client" "main" {
  name         = "cognito-client"
  user_pool_id = aws_cognito_user_pool.main.id

  # Authentication flows
  explicit_auth_flows = [
    "ADMIN_NO_SRP_AUTH",
    "USER_PASSWORD_AUTH"
  ]

  # Token validity
  access_token_validity  = 60
  id_token_validity      = 60
  refresh_token_validity = 30

  # Token validity units
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  # Prevent user existence errors
  prevent_user_existence_errors = "ENABLED"

  # Generate secret
  generate_secret = true

  # Add callback URLs (replace with your actual URLs)
  callback_urls = [   
    "https://your-http-api-id.execute-api.region.amazonaws.com/$default/"
  ]

  # Add logout URLs
  logout_urls = [
    "https://your-frontend-app.com/logout"
  ]

  # Enable OAuth flows for hosted UI login page
  allowed_oauth_flows = ["code", "implicit"]

  # OAuth scopes you want to allow
  allowed_oauth_scopes = [
    "phone",
    "email",
    "openid",
    "profile",
    "aws.cognito.signin.user.admin"
  ]

  # Enable OAuth flows for this client
  allowed_oauth_flows_user_pool_client = true

  # Supported identity providers (usually Cognito for user pool)
  supported_identity_providers = ["COGNITO"]
}

# Create a test user (optional - for development)
resource "aws_cognito_user" "test_user" {
  user_pool_id = aws_cognito_user_pool.main.id
  username     = "testuser"

  attributes = {
    email          = "prakash8807776601@gmail.com"
    email_verified = "true"
  }

  temporary_password = "Prakash@1234"
  message_action     = "SUPPRESS"

  lifecycle {
    ignore_changes = [password]
  }
}