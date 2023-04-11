aws_region = "us-east-1"
is_enabled = true

bucket_config = [
  {
    name = "my-bucket"
  },
  {
    name = "with-versioning"
  }
]

bucket_options = [
  {
    name              = "with-versioning"
    enable_versioning = true
  }
]
