resource "aws_s3_bucket" "this" {
  for_each      = local.bucket_cfg
  force_destroy = each.value["force_destroy"]
  bucket        = lower(each.value["bucket_name"])
  tags          = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  for_each = local.bucket_cfg
  bucket   = aws_s3_bucket.this[each.key].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  for_each = local.bucket_cfg
  bucket   = aws_s3_bucket.this[each.key].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  for_each = local.bucket_cfg
  bucket   = aws_s3_bucket.this[each.key].id
  rule {
    id     = "lambda-deployment-lifecycle"
    status = "Enabled"

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 60
      storage_class   = "GLACIER"
    }

    noncurrent_version_expiration {
      noncurrent_days = 180
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  for_each                = local.bucket_cfg
  bucket                  = aws_s3_bucket.this[each.key].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
