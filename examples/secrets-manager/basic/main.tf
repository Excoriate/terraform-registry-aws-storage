module "main_module" {
  source                     = "../../../modules/secrets-manager"
  is_enabled                 = var.is_enabled
  aws_region                 = var.aws_region
  secrets_config             = var.secrets_config
  secrets_replication_config = var.secrets_replication_config
  secrets_rotation_config    = var.secrets_rotation_config
  enforced_prefixes          = var.enforced_prefixes
}
