resource "aws_secretsmanager_secret" "this" {
  for_each                = local.secrets_config_create
  name                    = each.value["is_prefix_enforced"] ? format("%s/%s", lookup(local.prefixes_create[each.key], "prefix"), each.value["path"]) : each.value["path"]
  description             = each.value["description"]
  kms_key_id              = each.value["kms_key_id"]
  recovery_window_in_days = each.value["recovery_window_in_days"]
  policy                  = each.value["policy"]

  dynamic "replica" {
    for_each = local.is_replication_set ? { for k, v in local.replication_create : k => v if v["name"] == each.key } : {}
    iterator = replica
    content {
      region     = replica.value["region"]
      kms_key_id = replica.value["kms_key_id"]
    }
  }

  tags = var.tags
}


resource "aws_secretsmanager_secret_version" "this" {
  for_each      = { for k, v in local.secrets_config_create : k => v if v["enable_random_secret_value"] }
  secret_id     = aws_secretsmanager_secret.this[each.key].id
  secret_string = random_string.random_secret_value[each.key].result
  depends_on    = [aws_secretsmanager_secret.this]
}


resource "random_string" "random_secret_value" {
  for_each   = { for k, v in local.secrets_config_create : k => v if v["enable_random_secret_value"] }
  length     = 15
  special    = false
  depends_on = [aws_secretsmanager_secret.this]
}
