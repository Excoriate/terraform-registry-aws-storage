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
  sort_key = "name"
}

dynamodb_attributes = [
  {
    name = "DailyAverage"
    type = "N"
  },
  {
    name = "HighWater"
    type = "N"
  },
  {
    name = "Timestamp"
    type = "S"
  }
]

local_secondary_index_map = [
  {
    name               = "TimestampSortIndex"
    range_key          = "Timestamp"
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  },
  {
    name               = "HighWaterIndex"
    range_key          = "Timestamp"
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  }
]

global_secondary_index_map = [
  {
    name               = "DailyAverageIndex"
    hash_key           = "DailyAverage"
    range_key          = "HighWater"
    write_capacity     = 5
    read_capacity      = 5
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  }
]

ttl_config = {
  attribute_name = "HighWater"
  enabled        = true
}
