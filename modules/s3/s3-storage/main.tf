resource "aws_s3_bucket" "this" {
  for_each            = local.bucket_cfg_map
  bucket              = each.value["bucket_name"]
  force_destroy       = each.value["force_destroy"]
  object_lock_enabled = each.value["object_lock_enabled"]
  tags                = var.tags
}

resource "aws_s3_bucket_accelerate_configuration" "this" {
  for_each = local.bucket_transfer_acceleration_cfg_map
  bucket   = join("", [for k, v in aws_s3_bucket.this : v.bucket if k == each.key])
  status   = "Enabled"
}
