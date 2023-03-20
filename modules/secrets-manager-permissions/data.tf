data "aws_secretsmanager_secret" "this" {
  for_each = local.secret_permissions_create
  name     = each.value["secret_name"]
}

locals {
  filtered_permissions_for_roles = !local.is_enabled ? {} : { for k, v in local.secret_permissions_create : k => v if v["iam_role_arn"] != null || v["iam_role_name"] != null }

}

data "aws_iam_role" "this" {
  #  for_each = {for k, v in local.secret_permissions_create: k => v if v["iam_role_arn"] != null || v["iam_role_name"] != null}
  for_each = local.filtered_permissions_for_roles
  name     = each.value["iam_role_name"]
}
