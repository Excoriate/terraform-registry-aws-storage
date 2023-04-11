aws_region = "us-east-1"
is_enabled = true

bucket_config = [
  {
    name = "my-bucket"
  },
  {
    name          = "second-bucket"
    force_destroy = true
    bucket_name   = "named-second-bucket"
  }
]
