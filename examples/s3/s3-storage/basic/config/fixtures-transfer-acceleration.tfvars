aws_region = "us-east-1"
is_enabled = true

bucket_config = [
  {
    name = "my-bucket"
  },
  {
    name = "with-transfer-acceleration"
  }
]

bucket_options = [
  {
    name                         = "with-transfer-acceleration"
    enable_transfer_acceleration = true
  }
]
