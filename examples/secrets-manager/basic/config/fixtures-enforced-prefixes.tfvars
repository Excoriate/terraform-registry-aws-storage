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
  {
    name                    = "test3"
    path                    = "my_secret/test3"
    recovery_window_in_days = 0
  },
]

enforced_prefixes = [{
  name   = "test3"
  prefix = "my_custom_prefix"
}]
