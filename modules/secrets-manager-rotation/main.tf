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

resource "aws_lambda_permission" "this" {
  for_each      = { for k, v in local.lambda_cfg : k => v if v["rotation_lambda_name"] != null }
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.rotation_lambda[each.key].function_name
  principal     = "secretsmanager.amazonaws.com"
  statement_id  = "AllowSecretsManagerInvoke"
  source_arn    = each.value["is_lookup_by_name"] ? data.aws_secretsmanager_secret.lookup_by_name[each.key].arn : data.aws_secretsmanager_secret.lookup_by_arn[each.key].arn
}
