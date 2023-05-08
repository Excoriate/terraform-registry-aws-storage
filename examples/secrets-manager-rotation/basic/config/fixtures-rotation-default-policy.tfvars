aws_region = "us-east-1"
is_enabled = true

rotation_config = [
  {
    name                      = "test-secret-1"
    secret_name               = "test/terraform"
    enable_default_iam_policy = true
  }
]

rotation_rules_config = [
  {
    name                              = "test-secret-1"
    rotation_automatically_after_days = 1
  }
]
