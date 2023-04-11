data "aws_iam_policy_document" "this" {
  for_each = local.bucket_permissions_cfg_map

  dynamic "statement" {
    for_each = each.value["enable_encrypted_uploads_only"] ? [1] : []
    content {
      sid       = "DenyIncorrectEncryptionHeader"
      effect    = "Deny"
      actions   = ["s3:PutObject"]
      resources = [format("%s/*", aws_s3_bucket.this[each.key].arn)]

      principals {
        identifiers = ["*"]
        type        = "*"
      }

      condition {
        test     = "StringNotEquals"
        values   = ["AES256"]
        variable = "s3:x-amz-server-side-encryption"
      }
    }
  }

  dynamic "statement" {
    for_each = each.value["enable_encrypted_uploads_only"] ? [1] : []

    content {
      sid       = "DenyUnEncryptedObjectUploads"
      effect    = "Deny"
      actions   = ["s3:PutObject"]
      resources = [format("%s/*", aws_s3_bucket.this[each.key].arn)]

      principals {
        identifiers = ["*"]
        type        = "*"
      }

      condition {
        test     = "Null"
        values   = ["true"]
        variable = "s3:x-amz-server-side-encryption"
      }
    }
  }

  dynamic "statement" {
    for_each = each.value["enable_ssl_requests_only"] ? [1] : []

    content {
      sid       = "ForceSSLOnlyAccess"
      effect    = "Deny"
      actions   = ["s3:*"]
      resources = [aws_s3_bucket.this[each.key].arn, format("%s/*", aws_s3_bucket.this[each.key].arn)]

      principals {
        identifiers = ["*"]
        type        = "*"
      }

      condition {
        test     = "Bool"
        values   = ["false"]
        variable = "aws:SecureTransport"
      }
    }
  }
}

data "aws_iam_policy_document" "merged_policy" {
  for_each                  = local.bucket_permissions_cfg_map
  source_policy_documents   = [data.aws_iam_policy_document.this[each.key].json]
  override_policy_documents = length(each.value["iam_policy_documents_to_attach"]) > 0 ? [for policy in each.value["iam_policy_documents_to_attach"] : policy["policy_document"]] : []
}
