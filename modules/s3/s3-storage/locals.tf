locals {
  aws_region_to_deploy = var.aws_region

  /*
    * Feature flags
  */
  is_enabled = !var.is_enabled ? false : var.bucket_config == null ? false : length(var.bucket_config) > 0

  bucket_cfg_normalised = !local.is_enabled ? [] : [for bucket in var.bucket_config : {
    name                = lower(trimspace(bucket.name))
    bucket_name         = lookup(bucket, "bucket_name", trimspace(bucket.name))
    force_destroy       = bucket["force_destroy"] == null ? false : bucket["force_destroy"]
    object_lock_enabled = bucket["object_lock_enabled"] == null ? false : bucket["object_lock_enabled"]
  }]

  bucket_cfg_map = !local.is_enabled ? {} : { for bucket in local.bucket_cfg_normalised : bucket["name"] => bucket }
}
