aws_region = "us-east-1"
is_enabled = true

bucket_config = [
  {
    name = "deployment-bucket-test-lambda-1"
  },
  {
    name = "deployment-bucket-test-lambda-2"
  }
]

bucket_permissions = [
  {
    name                          = "deployment-bucket-test-lambda-2"
    enable_encrypted_uploads_only = true
    enable_ssl_requests_only      = true
  }
]
