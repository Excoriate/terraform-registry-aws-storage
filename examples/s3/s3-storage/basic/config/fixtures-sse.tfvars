aws_region = "us-east-1"
is_enabled = true

bucket_config = [
  {
    name = "my-bucket"
  },
  {
    name = "with-sse"
  }
]

bucket_options = [
  {
    name                                  = "with-sse"
    enable_default_server_side_encryption = true
  }
]
