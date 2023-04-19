module "main_module" {
  source                 = "../../../modules/secrets-manager-rotation"
  is_enabled             = var.is_enabled
  aws_region             = var.aws_region
  rotation_config        = var.rotation_config
  rotation_lambda_config = var.rotation_lambda_config
  rotation_rules_config  = var.rotation_rules_config

}

// Create a fake secret, to be used as part of this module's tests.
#resource "random_string" "secret_value" {
#  length  = 16
#  special = false
#}
#
#resource "aws_secretsmanager_secret" "example_secret" {
#  name                    = "test-secret-rotation-1"
#  recovery_window_in_days = 0
#}
#
#resource "aws_secretsmanager_secret_version" "example_secret_version" {
#  secret_id     = aws_secretsmanager_secret.example_secret.id
#  secret_string = random_string.secret_value.result
#}
