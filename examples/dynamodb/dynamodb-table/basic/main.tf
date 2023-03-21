module "main_module" {
  source     = "../../../../modules/dynamodb/dynamodb-table"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  table_config                  = var.table_config
  dynamodb_attributes           = var.dynamodb_attributes
  dynamodb_keys                 = var.dynamodb_keys
  ttl_config                    = var.ttl_config
  server_side_encryption_config = var.server_side_encryption_config
  global_secondary_index_map    = var.global_secondary_index_map
  local_secondary_index_map     = var.local_secondary_index_map
}
