# Configuração inicial do Cognito

resource "aws_cognito_user_pool" "user_pool" {
  name                         = "ca_user_pool_prod"

  mfa_configuration            = "OFF"

  admin_create_user_config {
    allow_admin_create_user_only = true
  }
  
  password_policy {
    minimum_length    = 8
    require_lowercase = false
    require_numbers   = false
    require_symbols   = false
    require_uppercase = false
  }

  schema {
    name                     = "tenant_id"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false

    number_attribute_constraints {
      min_value = 1
      max_value = 256
    }
  }

  schema {
    name                     = "external_id"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false

    number_attribute_constraints {
      min_value = 1
      max_value = 256
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cognito_user_pool_client" "client" {
    name                           = "authentication"
    user_pool_id                   = aws_cognito_user_pool.user_pool.id
    generate_secret                = true
    allowed_oauth_flows            = ["client_credentials"]
    supported_identity_providers   = ["COGNITO"]
}
