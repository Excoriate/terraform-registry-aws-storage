data "aws_secretsmanager_secret" "lookup_by_arn" {
  for_each = local.lookup_by_arn
  arn      = each.value["secret_arn"]
}

data "aws_secretsmanager_secret" "lookup_by_name" {
  for_each = local.lookup_by_name
  name     = each.value["secret_name"]
}

data "aws_lambda_function" "rotation_lambda" {
  for_each      = { for k, v in local.lambda_cfg : k => v if v["rotation_lambda_name"] != null }
  function_name = each.value["rotation_lambda_name"]
}
