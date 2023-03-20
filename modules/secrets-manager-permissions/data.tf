data "aws_secretsmanager_secret" "this" {
  for_each = local.secret_permissions_create
  name     = each.value["secret_name"]
}

data "aws_iam_role" "this" {
  for_each = { for p in local.secret_permissions_create : p["name"] => p if p["iam_role_name"] != "NOT_SET" }
  name     = each.value["iam_role_name"]
}
