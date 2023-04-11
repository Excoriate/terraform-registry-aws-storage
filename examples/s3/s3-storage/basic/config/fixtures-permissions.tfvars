aws_region = "us-east-1"
is_enabled = true

bucket_config = [
  {
    name = "my-bucket"
  },
  {
    name = "with-permissions"
  }
]

bucket_permissions = [
  {
    name                          = "with-permissions"
    enable_encrypted_uploads_only = true
    enable_ssl_requests_only      = true
  }
]
