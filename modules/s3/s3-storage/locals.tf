locals {
  aws_region_to_deploy = var.aws_region

  /*
    * Feature flags
  */
  is_enabled                = !var.is_enabled ? false : var.bucket_config == null ? false : length(var.bucket_config) > 0
  is_bucket_options_enabled = !local.is_enabled ? false : var.bucket_options == null ? false : length(var.bucket_options) > 0

  /*
    * Bucket basic configuration
  */
  bucket_cfg_normalised = !local.is_enabled ? [] : [for bucket in var.bucket_config : {
    name                = lower(trimspace(bucket.name))
    bucket_name         = lookup(bucket, "bucket_name", trimspace(bucket.name))
    force_destroy       = bucket["force_destroy"] == null ? false : bucket["force_destroy"]
    object_lock_enabled = bucket["object_lock_enabled"] == null ? false : bucket["object_lock_enabled"]
  }]

  bucket_cfg_map = !local.is_enabled ? {} : { for bucket in local.bucket_cfg_normalised : bucket["name"] => bucket }

  /*
    * Bucket options
    - Enables versioning.
    - Enables transfer acceleration.
    - Enables server-side encryption.
  */
  bucket_options_normalised = !local.is_bucket_options_enabled ? [] : [for bucket in var.bucket_options : {
    name                                  = lower(trimspace(bucket.name))
    enable_transfer_acceleration          = bucket["enable_transfer_acceleration"] == null ? false : bucket["enable_transfer_acceleration"]
    enable_versioning                     = bucket["enable_versioning"] == null ? false : bucket["enable_versioning"]
    enable_default_server_side_encryption = bucket["enable_default_server_side_encryption"] == null ? false : bucket["enable_default_server_side_encryption"]
  }]

  // 1. Transfer acceleration option.
  bucket_transfer_acceleration_cfg_normalised = [for bucket in local.bucket_options_normalised : {
    name                         = bucket["name"]
    enable_transfer_acceleration = bucket["enable_transfer_acceleration"]
  } if bucket["enable_transfer_acceleration"] == true]

  bucket_transfer_acceleration_cfg_map = { for bucket in local.bucket_transfer_acceleration_cfg_normalised : bucket["name"] => bucket }
}
