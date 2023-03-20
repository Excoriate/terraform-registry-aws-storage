resource "aws_secretsmanager_secret" "this" {
  for_each                = local.secrets_config_create
  name                    = each.value["is_prefix_enforced"] ? format("%s/%s", lookup(local.prefixes_create[each.key], "prefix"), each.value["path"]) : each.value["path"]
  description             = each.value["description"]
  kms_key_id              = each.value["kms_key_id"]
  recovery_window_in_days = each.value["recovery_window_in_days"]
  policy                  = each.value["policy"]

  tags = var.tags
}
