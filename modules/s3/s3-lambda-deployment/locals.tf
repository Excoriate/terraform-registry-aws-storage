locals {
  aws_region_to_deploy = var.aws_region

  /*
    * Feature flags
  */
  is_enabled                    = !var.is_enabled ? false : var.bucket_config == null ? false : length(var.bucket_config) > 0
  is_bucket_permissions_enabled = !local.is_enabled ? false : var.bucket_permissions == null ? false : length(var.bucket_permissions) > 0

  bucket = !local.is_enabled ? [] : [
    for b in var.bucket_config : {
      name          = trimspace(b.name)
      bucket_name   = b["bucket_name"] == null ? trimspace(b.name) : trimspace(b["bucket_name"])
      force_destroy = b["force_destroy"] == null ? false : b["force_destroy"]

      is_permissions_enabled = !local.is_bucket_permissions_enabled ? false : lookup(local.bucket_permissions_cfg, lower(trimspace(b["name"])), null) != null
    }
  ]

  bucket_cfg = !local.is_enabled ? {} : { for b in local.bucket : b["name"] => b }

  bucket_permissions = !local.is_bucket_permissions_enabled ? [] : [
    for p in var.bucket_permissions : {
      name                           = lower(trimspace(p.name))
      enable_encrypted_uploads_only  = p["enable_encrypted_uploads_only"] == null ? false : p["enable_encrypted_uploads_only"]
      enable_ssl_requests_only       = p["enable_ssl_requests_only"] == null ? false : p["enable_ssl_requests_only"]
      iam_policy_documents_to_attach = p["iam_policy_documents_to_attach"] == null ? [] : p["iam_policy_documents_to_attach"]
    }
  ]

  bucket_permissions_cfg = !local.is_bucket_permissions_enabled ? {} : { for p in local.bucket_permissions : p["name"] => p }
}
