locals {
  aws_region_to_deploy = var.aws_region

  /*
  * Feature flags
  */
  is_enabled = !var.is_enabled ? false : var.secret_permissions == null ? false : length(var.secret_permissions) > 0

  /*
    * 1. Secrets permissions.
      - Deny will be prioritised over allow.
      - Normalisation of attributes passed.
      - An attachment will be created if the IAM role (name) is passed.
  */
  secret_permissions_normalised = !local.is_enabled ? [] : [for permission in var.secret_permissions : {
    name          = lower(trimspace(permission.name))
    secret_name   = lower(trimspace(permission.secret_name))
    permissions   = permission["permissions"] == null ? ["*"] : length(permission["permissions"]) == 0 ? ["*"] : [for p in permission["permissions"] : trimspace(format("secretsmanager:%s", p))]
    allow         = permission["allow"] == null ? true : permission["allow"]
    deny          = permission["deny"] == null ? false : permission["deny"]
    iam_role_name = permission["iam_role_name"] == null ? "NOT_SET" : permission["iam_role_name"] == "" ? "NOT_SET" : trimspace(permission["iam_role_name"])
    iam_role_arn  = permission["iam_role_arn"] == null ? "NOT_SET" : permission["iam_role_arn"] == "" ? "NOT_SET" : trimspace(permission["iam_role_arn"])
  }]

  secret_permissions_create = !local.is_enabled ? {} : {
  for permission in local.secret_permissions_normalised : permission["name"] => permission }

  attachments_filtered_role_arn = !local.is_enabled ? {} : {
    for p in local.secret_permissions_create : p["name"] => {
      name       = p["name"]
      role       = data.aws_iam_role.this[p["name"]].arn
      policy_arn = p["allow"] ? aws_iam_policy.allow[p["name"]].arn : aws_iam_policy.deny[p["name"]].arn
    } if p["iam_role_arn"] != "NOT_SET" && p["iam_role_name"] == "NOT_SET"
  }
}
