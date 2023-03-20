aws_region = "us-east-1"
is_enabled = true

secret_permissions = [
  {
    name        = "test1"
    secret_name = "test/terraform"
    permissions = ["GetSecretValue", "DescribeSecret", "PutSecretValue"]
  }
]
