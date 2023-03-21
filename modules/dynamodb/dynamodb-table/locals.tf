locals {
  aws_region_to_deploy = var.aws_region

  /*
    * Feature flags
  */
  is_enabled        = !var.is_enabled ? false : var.table_config == null ? false : true
  is_stream_enabled = !local.is_enabled ? false : var.table_config.replicate_in_regions == null ? false : length(var.table_config.replicate_in_regions) == 0 ? false : var.table_config.stream_enabled == null ? false : var.table_config.stream_enabled
  is_ttl_enabled    = !local.is_enabled ? false : var.ttl_config == null ? false : var.ttl_config.enabled == null ? false : var.ttl_config.enabled
  is_sse_enabled    = !local.is_enabled ? false : var.server_side_encryption_config == null ? false : var.server_side_encryption_config.enabled == null ? false : var.server_side_encryption_config.enabled

  table_config_create = !local.is_enabled ? null : {
    name                                  = lower(trimspace(var.table_config.name))
    table_name                            = lower(trimspace(var.table_config.table_name))
    billing_mode                          = var.table_config.billing_mode == null ? "PAY_PER_REQUEST" : upper(trimspace(var.table_config.billing_mode))
    read_capacity                         = var.table_config.billing_mode == "PAY_PER_REQUEST" ? null : var.table_config.read_capacity == null ? null : var.table_config.read_capacity
    write_capacity                        = var.table_config.billing_mode == "PAY_PER_REQUEST" ? null : var.table_config.write_capacity == null ? null : var.table_config.write_capacity
    stream_enabled                        = local.is_stream_enabled
    stream_view_type                      = !local.is_stream_enabled ? null : var.table_config.stream_view_type == null ? "NEW_AND_OLD_IMAGES" : upper(trimspace(var.table_config.stream_view_type))
    enable_point_in_time_recovery         = var.table_config.enable_point_in_time_recovery == null ? false : var.table_config.enable_point_in_time_recovery
    enable_ignore_changes_on_auto_scaling = var.table_config.enable_ignore_changes_on_auto_scaling == null ? false : var.table_config.enable_ignore_changes_on_auto_scaling
    replicas                              = var.table_config.replicate_in_regions == null ? [] : [for r in var.table_config.replicate_in_regions : trimspace(r)]
    table_class                           = var.table_config.table_class == null ? "STANDARD" : upper(trimspace(var.table_config.table_class))
  }

  table_keys_normalised = !local.is_enabled ? null : {
    hash_key      = var.dynamodb_keys.hash_key == null ? "id" : trimspace(var.dynamodb_keys.hash_key)
    hash_key_type = var.dynamodb_keys.hash_key_type == null ? "S" : upper(trimspace(var.dynamodb_keys.hash_key_type))
    sort_key      = var.dynamodb_keys.sort_key == null ? null : trimspace(var.dynamodb_keys.sort_key)
    sort_key_type = var.dynamodb_keys.sort_key_type == null ? "S" : upper(trimspace(var.dynamodb_keys.sort_key_type))
  }

  table_attributes_based_on_keys = !local.is_enabled ? [] : [
    {
      name = lookup(local.table_keys_normalised, "hash_key")
      type = lookup(local.table_keys_normalised, "hash_key_type")
    }, lookup(local.table_keys_normalised, "sort_key") == null ? null :
    {
      name = lookup(local.table_keys_normalised, "sort_key")
      type = lookup(local.table_keys_normalised, "sort_key_type")
    },
  ]

  table_attributes = !local.is_enabled ? [] : [
    for a in var.dynamodb_attributes : {
      name = trimspace(a.name)
      type = upper(trimspace(a.type))
    }
  ]

  table_attributes_normalised = !local.is_enabled ? [] : [
    for a in concat(local.table_attributes_based_on_keys, local.table_attributes) : a if a != null
  ]

  ttl_normalised = !local.is_ttl_enabled ? {} : {
    attribute_name = trimspace(var.ttl_config.attribute_name)
    enabled        = local.is_ttl_enabled
  }

  sse_normalised = !local.is_sse_enabled ? {} : {
    enabled     = local.is_sse_enabled
    kms_key_arn = var.server_side_encryption_config.kms_key_arn == null ? null : trimspace(var.server_side_encryption_config.kms_key_arn)
  }
}
