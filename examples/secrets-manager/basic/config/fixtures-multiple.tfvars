aws_region = "us-east-1"
is_enabled = true

secrets_config = [
  {
    name = "test"
    path = "my_secret/test"
  },
  {
    name                    = "test2"
    path                    = "my_secret/test2"
    recovery_window_in_days = 7
  },
]
