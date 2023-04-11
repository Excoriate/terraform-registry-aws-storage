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

  // Custom statements
  dynamic "statement" {
    for_each = length(each.value["iam_policy_documents_to_attach"]) > 0 ? each.value["iam_policy_documents_to_attach"] : []
    content {
      sid       = statement.value["sid"]
      effect    = statement.value["effect"]
      actions   = statement.value["actions"]
      resources = [aws_s3_bucket.this[each.key].arn, format("%s/*", aws_s3_bucket.this[each.key].arn)]

      dynamic "principals" {
        for_each = length(statement.value["principals"]) > 0 ? statement.value["principals"] : []
        content {
          identifiers = principals.value["identifiers"]
          type        = principals.value["type"]
        }
      }

      dynamic "condition" {
        for_each = length(statement.value["conditions"]) > 0 ? statement.value["conditions"] : []
        iterator = c
        content {
          test     = c.value["test"]
          values   = c.value["values"]
          variable = c.value["variable"]
        }
      }
    }
  }
}
