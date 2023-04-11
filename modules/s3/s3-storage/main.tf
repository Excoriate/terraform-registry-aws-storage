resource "aws_s3_bucket" "this" {
  for_each            = local.bucket_cfg_map
  bucket              = each.value["bucket_name"]
  force_destroy       = each.value["force_destroy"]
  object_lock_enabled = each.value["object_lock_enabled"]
  tags                = var.tags
}
