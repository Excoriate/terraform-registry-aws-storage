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
    permissions   = try(permission["permissions"], ["*"]) == null || length(try(permission["permissions"], ["*"])) == 0 ? ["*"] : [for action in try(permission["permissions"], []) : format("secretsmanager:%s", trimspace(action))]
    allow         = try(permission["allow"], true)
    deny          = try(permission["deny"], false)
    iam_role_name = try(lower(trimspace(permission["iam_role_name"])), null)
    iam_role_arn  = try(lower(trimspace(permission["iam_role_arn"])), null)

    // feature flags
    is_attachment_enabled = try(permission["iam_role_name"], null) != null || try(permission["iam_role_arn"], null) != null
    is_deny_enabled       = try(permission["deny"], false) && try(permission["allow"], true)
  }]

  secret_permissions_create = !local.is_enabled ? {} : {
  for permission in local.secret_permissions_normalised : permission["name"] => permission }
}
