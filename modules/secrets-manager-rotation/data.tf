data "aws_secretsmanager_secret" "lookup_by_arn" {
  for_each = local.lookup_by_arn
  arn      = each.value["secret_arn"]
}

data "aws_secretsmanager_secret" "lookup_by_name" {
  for_each = local.lookup_by_name
  name     = each.value["secret_name"]
}
