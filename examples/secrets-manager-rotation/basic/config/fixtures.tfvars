aws_region = "us-east-1"
is_enabled = true

rotation_config = [
  {
    name        = "test-secret-1"
    secret_name = "test/terraform"
  }
]
