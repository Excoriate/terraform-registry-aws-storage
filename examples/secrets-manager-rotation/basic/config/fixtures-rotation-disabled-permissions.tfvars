aws_region = "us-east-1"
is_enabled = true

rotation_config = [
  {
    name                                = "test-secret-1"
    secret_name                         = "test/terraform"
    disable_built_in_lambda_permissions = true
  }
]

rotation_lambda_config = [
  {
    name       = "test-secret-1"
    lambda_arn = "arn:aws:lambda:us-east-1:123456789012:function:my-function"
  }
]

rotation_rules_config = [
  {
    name                              = "test-secret-1"
    rotation_automatically_after_days = 1
  }
]
