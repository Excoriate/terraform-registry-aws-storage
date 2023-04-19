resource "aws_secretsmanager_secret_rotation" "this" {
  for_each            = local.rotation_cfg
  secret_id           = each.value["is_lookup_by_name"] ? data.aws_secretsmanager_secret.lookup_by_name[each.key].id : data.aws_secretsmanager_secret.lookup_by_arn[each.key].id
  rotation_lambda_arn = lookup(local.lambda_cfg[each.key], "rotation_lambda_arn")

  rotation_rules {
    automatically_after_days = lookup(local.rules_cfg[each.key], "automatically_after_days", null)
    duration                 = lookup(local.rules_cfg[each.key], "duration", null)
    schedule_expression      = lookup(local.rules_cfg[each.key], "schedule_expression", null)
  }
}
