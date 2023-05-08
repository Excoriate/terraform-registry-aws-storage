data "aws_secretsmanager_secret" "lookup_by_arn" {
  for_each = local.secret_lookup_by_arn
  arn      = each.value["secret_arn"]
}

data "aws_secretsmanager_secret" "lookup_by_name" {
  for_each = local.secret_lookup_by_name
  name     = each.value["secret_name"]
}


data "aws_lambda_function" "rotation_lambda_by_name" {
  for_each      = local.lambda_lookup
  function_name = each.value["rotation_lambda_name"]
}
