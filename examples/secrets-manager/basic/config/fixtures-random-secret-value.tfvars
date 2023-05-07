aws_region = "us-east-1"
is_enabled = true

secrets_config = [
  {
    name                       = "test"
    path                       = "secret/test/random-value-1"
    enable_random_secret_value = true
  }
]
