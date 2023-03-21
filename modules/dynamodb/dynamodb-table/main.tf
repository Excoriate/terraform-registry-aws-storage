resource "aws_dynamodb_table" "ignore_auto_scaling_changes" {
  for_each         = !local.is_enabled ? {} : lookup(local.table_config_create, "enable_ignore_changes_on_auto_scaling") == false ? {} : { enabled = true }
  name             = lookup(local.table_config_create, "name")
  billing_mode     = lookup(local.table_config_create, "billing_mode")
  read_capacity    = lookup(local.table_config_create, "read_capacity")
  write_capacity   = lookup(local.table_config_create, "write_capacity")
  hash_key         = lookup(local.table_keys_normalised, "hash_key")
  range_key        = lookup(local.table_keys_normalised, "sort_key")
  stream_enabled   = lookup(local.table_config_create, "stream_enabled")
  stream_view_type = lookup(local.table_config_create, "stream_view_type")
  table_class      = lookup(local.table_config_create, "table_class")

  dynamic "point_in_time_recovery" {
    for_each = lookup(local.table_config_create, "enable_point_in_time_recovery") ? [1] : []
    content {
      enabled = true
    }
  }

  lifecycle {
    ignore_changes = [
      read_capacity,
      write_capacity
    ]
  }

  dynamic "attribute" {
    for_each = local.table_attributes_normalised
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index_map
    content {
      hash_key           = global_secondary_index.value.hash_key
      name               = global_secondary_index.value.name
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_index_map
    content {
      name               = local_secondary_index.value.name
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
      projection_type    = local_secondary_index.value.projection_type
      range_key          = local_secondary_index.value.range_key
    }
  }

  dynamic "ttl" {
    for_each = local.is_ttl_enabled ? [1] : []
    content {
      attribute_name = lookup(local.ttl_normalised, "attribute_name")
      enabled        = lookup(local.ttl_normalised, "enabled")
    }
  }

  dynamic "server_side_encryption" {
    for_each = local.is_sse_enabled ? [1] : []
    content {
      enabled     = lookup(local.sse_normalised, "enabled")
      kms_key_arn = lookup(local.sse_normalised, "kms_key_arn")
    }
  }

  dynamic "replica" {
    for_each = lookup(local.table_config_create, "replicas")
    content {
      region_name = replica.value
    }
  }

  tags = var.tags
}

resource "aws_dynamodb_table" "default" {
  for_each         = !local.is_enabled ? {} : lookup(local.table_config_create, "enable_ignore_changes_on_auto_scaling") == true ? {} : { enabled = true }
  name             = lookup(local.table_config_create, "name")
  billing_mode     = lookup(local.table_config_create, "billing_mode")
  read_capacity    = lookup(local.table_config_create, "read_capacity")
  write_capacity   = lookup(local.table_config_create, "write_capacity")
  hash_key         = lookup(local.table_keys_normalised, "hash_key")
  range_key        = lookup(local.table_keys_normalised, "sort_key")
  stream_enabled   = lookup(local.table_config_create, "stream_enabled")
  stream_view_type = lookup(local.table_config_create, "stream_view_type")
  table_class      = lookup(local.table_config_create, "table_class")

  dynamic "point_in_time_recovery" {
    for_each = lookup(local.table_config_create, "enable_point_in_time_recovery") ? [1] : []
    content {
      enabled = true
    }
  }

  dynamic "attribute" {
    for_each = local.table_attributes_normalised
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }

  dynamic "ttl" {
    for_each = local.is_ttl_enabled ? [1] : []
    content {
      attribute_name = lookup(local.ttl_normalised, "attribute_name")
      enabled        = lookup(local.ttl_normalised, "enabled")
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index_map
    content {
      hash_key           = global_secondary_index.value.hash_key
      name               = global_secondary_index.value.name
      non_key_attributes = lookup(global_secondary_index.value, "non_key_attributes", null)
      projection_type    = global_secondary_index.value.projection_type
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_index_map
    content {
      name               = local_secondary_index.value.name
      non_key_attributes = lookup(local_secondary_index.value, "non_key_attributes", null)
      projection_type    = local_secondary_index.value.projection_type
      range_key          = local_secondary_index.value.range_key
    }
  }

  dynamic "server_side_encryption" {
    for_each = local.is_sse_enabled ? [1] : []
    content {
      enabled     = lookup(local.sse_normalised, "enabled")
      kms_key_arn = lookup(local.sse_normalised, "kms_key_arn")
    }
  }


  dynamic "replica" {
    for_each = lookup(local.table_config_create, "replicas")
    content {
      region_name = replica.value
    }
  }

  tags = var.tags
}
