data "aws_iam_policy_document" "allow" {
  for_each = { for k, v in local.secret_permissions_create : k => v if !v["is_deny_enabled"] }
  statement {
    sid       = "AllowSecretsManager"
    actions   = each.value["permissions"]
    resources = [for secret in data.aws_secretsmanager_secret.this : secret.arn if secret.name == each.value["secret_name"]]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "deny" {
  for_each = { for k, v in local.secret_permissions_create : k => v if v["is_deny_enabled"] }
  statement {
    sid       = "DenySecretsManager"
    actions   = each.value["permissions"]
    resources = [for secret in data.aws_secretsmanager_secret.this : secret.arn if secret.name == each.value["secret_name"]]
    effect    = "Deny"
  }
}

resource "aws_iam_policy" "allow" {
  for_each    = { for k, v in local.secret_permissions_create : k => v if !v["is_deny_enabled"] }
  name        = format("secret-policy-%s", each.value["name"])
  description = format("Secrets Manager policy (allow) for %s", each.value["name"])
  policy      = data.aws_iam_policy_document.allow[each.key].json
  tags        = var.tags
}

resource "aws_iam_policy" "deny" {
  for_each    = { for k, v in local.secret_permissions_create : k => v if v["is_deny_enabled"] }
  name        = format("secret-policy-%s", each.value["name"])
  description = format("Secrets Manager policy (deny) for %s", each.value["name"])
  policy      = data.aws_iam_policy_document.deny[each.key].json
  tags        = var.tags
}

/*
  * Attach the policies to the IAM roles
    - Optional, only if the IAM role-related attributes are passed.
    - IAM role name dictates that it should be looked up in the data source.
    - IAM role ARN dictates that it should be used as is.
*/
resource "aws_iam_role_policy_attachment" "attachment" {
  for_each   = { for k, v in local.secret_permissions_create : k => v if v["iam_role_name"] != null || v["iam_role_arn"] != null }
  policy_arn = each.value["deny"] ? aws_iam_policy.deny[each.key].arn : aws_iam_policy.allow[each.key].arn
  role       = each.value["is_lookup_iam_role_enabled"] ? data.aws_iam_role.this[each.value["name"]].name : each.value["iam_role_arn"]
}
