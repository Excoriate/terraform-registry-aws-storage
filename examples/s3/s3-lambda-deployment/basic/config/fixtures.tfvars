aws_region = "us-east-1"
is_enabled = true

bucket_config = [
  {
    name = "deployment-bucket-test-lambda-1"
  },
  {
    name          = "deployment-bucket-test-lambda-2"
    force_destroy = true
    bucket_name   = "deployment-bucket-test-lambda-2"
  }
]
