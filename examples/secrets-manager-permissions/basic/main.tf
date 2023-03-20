module "main_module" {
  source             = "../../../modules/secrets-manager-permissions"
  is_enabled         = var.is_enabled
  aws_region         = var.aws_region
  secret_permissions = var.secret_permissions
}
