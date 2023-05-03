resource "aws_s3_bucket_policy" "this" {
  for_each = local.bucket_permissions_cfg
  bucket   = join("", [for k, v in aws_s3_bucket.this : v.bucket if k == each.key])
  policy   = data.aws_iam_policy_document.this[each.key].json
}
