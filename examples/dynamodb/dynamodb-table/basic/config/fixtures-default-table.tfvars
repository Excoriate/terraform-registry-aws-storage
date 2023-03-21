aws_region = "us-east-1"
is_enabled = true

table_config = {
  name                                  = "test1"
  table_name                            = "test_table"
  hash_key                              = "id"
  enable_ignore_changes_on_auto_scaling = false
}

dynamodb_keys = {
  hash_key = "id"
}
