locals {
  aws_region_to_deploy = var.aws_region

  /*
  * Feature flags
  */
  is_enabled                 = !var.is_enabled ? false : var.rotation_config == null ? false : length(var.rotation_config) > 0
  is_rotation_rules_config   = !local.is_enabled ? false : var.rotation_rules_config == null ? false : length(var.rotation_rules_config) > 0
  is_rotation_module_enabled = local.is_enabled && local.is_rotation_rules_config

  /* Lookup configuration
   * This configuration allow this module to lookup for an existing secret.
   * The lookup could happen by two mechanism: 'arn' and 'name'.
  */
  secret_lookup = !local.is_rotation_module_enabled ? [] : [
    for s in var.rotation_config : {
      name              = trimspace(s.name)
      secret_name       = s["secret_name"] == null ? null : trimspace(s["secret_name"])
      secret_arn        = s["secret_arn"] == null ? null : trimspace(s["secret_arn"])
      is_lookup_by_arn  = s["secret_arn"] != null
      is_lookup_by_name = s["secret_name"] != null
    }
  ]

  secret_lookup_by_arn = !local.is_rotation_module_enabled ? {} : {
  for r in local.secret_lookup : r["name"] => r if r["is_lookup_by_arn"] }

  secret_lookup_by_name = !local.is_rotation_module_enabled ? {} : {
  for r in local.secret_lookup : r["name"] => r if r["is_lookup_by_name"] }


  /*
  * Rotation configuration
  * This configuration allow this module to create a rotation for a secret.
  */
  rotation = !local.is_rotation_module_enabled ? [] : [
    for s in var.rotation_config : {
      name                                   = trimspace(s.name)
      is_lookup_by_arn                       = s["secret_arn"] != null
      is_lookup_by_name                      = s["secret_name"] != null
      create_default_iam_policy_for_rotation = s["enable_default_iam_policy"] == null ? false : s["enable_default_iam_policy"]
      rotation_lambda_arn                    = s["rotation_lambda_arn"] == null ? null : s["rotation_lambda_arn"]
      rotation_lambda_name                   = s["rotation_lambda_name"] == null ? null : s["rotation_lambda_name"]
      disable_built_in_lambda_permissions    = s["disable_built_in_lambda_permissions"] == null ? false : s["disable_built_in_lambda_permissions"]
    }
  ]

  rotation_cfg = !local.is_rotation_module_enabled ? {} : {
  for r in local.rotation : r["name"] => r }

  /*
  * Rotation Lambda lookup
  * Currently, the used data source supports only the function name
  */

  lambda_lookup = !local.is_rotation_module_enabled ? {} : {
    for l in local.rotation_cfg : l["name"] => l if l["rotation_lambda_name"] != null
  }

  /*
   * Rotation rules configuration.
  */
  rules = !local.is_rotation_module_enabled ? [] : [
    for s in var.rotation_rules_config : {
      name                     = trimspace(s.name)
      secret_name              = s["secret_name"] == null ? trimspace(s.name) : trimspace(s["secret_name"])
      automatically_after_days = s["rotation_automatically_after_days"]
      duration                 = s["rotation_duration"]
      schedule_expression      = s["rotation_by_schedule_expression"]
    }
  ]

  rules_cfg = !local.is_rotation_module_enabled ? {} : {
  for r in local.rules : r["name"] => r }

}
