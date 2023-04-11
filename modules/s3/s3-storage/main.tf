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

resource "aws_s3_bucket_versioning" "this" {
  for_each = local.bucket_versioning_cfg_map
  bucket   = join("", [for k, v in aws_s3_bucket.this : v.bucket if k == each.key])
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  for_each = local.bucket_default_server_side_encryption_cfg_map
  bucket   = join("", [for k, v in aws_s3_bucket.this : v.bucket if k == each.key])

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  for_each = local.bucket_permissions_cfg_map
  bucket   = join("", [for k, v in aws_s3_bucket.this : v.bucket if k == each.key])
  policy   = data.aws_iam_policy_document.this[each.key].json
}
