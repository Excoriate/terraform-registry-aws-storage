locals {
  aws_region_to_deploy = var.aws_region

  /*
  * Feature flags
  */
  is_enabled                 = !var.is_enabled ? false : var.rotation_config == null ? false : length(var.rotation_config) > 0
  is_rotation_lambda_enabled = !local.is_enabled ? false : var.rotation_lambda_config == null ? false : length(var.rotation_lambda_config) > 0
  is_rotation_rules_config   = !local.is_enabled ? false : var.rotation_rules_config == null ? false : length(var.rotation_rules_config) > 0
  is_rotation_module_enabled = local.is_enabled && local.is_rotation_lambda_enabled && local.is_rotation_rules_config

  /* Lookup configuration
   * This configuration allow this module to lookup for an existing secret.
   * The lookup could happen by two mechanism: 'arn' and 'name'.
  */
  lookup = !local.is_rotation_module_enabled ? [] : [
    for s in var.rotation_config : {
      name              = trimspace(s.name)
      secret_name       = s["secret_name"] == null ? trimspace(s.name) : trimspace(s["secret_name"])
      secret_arn        = s["secret_arn"] == null ? "" : trimspace(s["secret_arn"])
      is_lookup_by_arn  = s["secret_name"] != null ? false : s["secret_name"] != "" ? false : true
      is_lookup_by_name = s["secret_name"] == null ? false : s["secret_name"] == "" ? false : true
    }
  ]

  lookup_by_arn = !local.is_rotation_module_enabled ? {} : {
  for r in local.lookup : r["name"] => r if r["is_lookup_by_arn"] }

  lookup_by_name = !local.is_rotation_module_enabled ? {} : {
  for r in local.lookup : r["name"] => r if r["is_lookup_by_name"] }

  /*
  * Rotation configuration
  * This configuration allow this module to create a rotation for a secret.
  */
  rotation = !local.is_rotation_module_enabled ? [] : [
    for s in var.rotation_config : {
      name              = trimspace(s.name)
      is_lookup_by_arn  = s["secret_name"] != null ? false : s["secret_name"] != "" ? false : true
      is_lookup_by_name = s["secret_name"] == null ? false : s["secret_name"] == "" ? false : true
    }
  ]

  rotation_cfg = !local.is_rotation_module_enabled ? {} : {
  for r in local.rotation : r["name"] => r }

  /*
  * Rotation lambda.
  */
  lambda = !local.is_rotation_module_enabled ? [] : [
    for s in var.rotation_lambda_config : {
      name                               = trimspace(s.name)
      rotation_lambda_arn                = s["lambda_arn"] == null ? "" : trimspace(s["lambda_arn"])
      is_default_rotation_lambda_enabled = s["lambda_arn"] != null ? false : s["lambda_arn"] != "" ? false : true
    }
  ]

  lambda_cfg = !local.is_rotation_module_enabled ? {} : {
  for r in local.lambda : r["name"] => r }

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
