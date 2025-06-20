# Cognito User Pool
resource "aws_cognito_user_pool" "main" {
  name = "prakash-cognito-user-pool"
  # Password policy
  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  # User attributes
  alias_attributes = ["email"]
  
  # Account recovery
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  # Email configuration
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  # User pool add-ons
  user_pool_add_ons {
    advanced_security_mode = "ENFORCED"
  }

  tags = {
    Name        = "prakash-cognito_user_pool"

  }
}


resource "aws_cognito_user_pool_client" "main" {
  name         = "cognito-client"
  user_pool_id = aws_cognito_user_pool.main.id

  # Authentication flows
  explicit_auth_flows = [
    "ADMIN_NO_SRP_AUTH",
    "USER_PASSWORD_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",      # Sign in with username and password
    "ALLOW_USER_SRP_AUTH",           # Sign in with secure remote password (SRP)
    "ADMIN_NO_SRP_AUTH",             # Sign in with server-side administrative credentials (Note the name difference)
    "ALLOW_CUSTOM_AUTH",             # Sign in with custom authentication flows from Lambda triggers
    "REFRESH_TOKEN_AUTH" 
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
    "https://5mkrf9mwn7.execute-api.ap-south-1.amazonaws.com/my-docker-lambda"
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

resource "aws_cognito_user_pool_domain" "default_domain" {
  domain       = "prakash-user-pool"  # unique prefix for your domain
  user_pool_id = aws_cognito_user_pool.main.id
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