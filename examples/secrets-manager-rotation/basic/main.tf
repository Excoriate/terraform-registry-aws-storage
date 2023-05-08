module "main_module" {
  source     = "../../../modules/secrets-manager-rotation"
  is_enabled = var.is_enabled
  aws_region = var.aws_region
  rotation_config = [
    {
      name                 = "secrets-manager-rotation-module"
      rotation_lambda_name = module.lambda_function.lambda_full_managed_function_name[0]
      secret_name          = "test-secret"
    }
  ]
  rotation_rules_config = [
    {
      name                              = "secrets-manager-rotation-module"
      rotation_automatically_after_days = 7
    }
  ]

  depends_on = [
    module.lambda_function
  ]
}


module "lambda_function" {
  source     = "git::https://github.com/Excoriate/terraform-registry-aws-events//modules/lambda/lambda-function?ref=v0.1.9"
  is_enabled = var.is_enabled
  aws_region = var.aws_region
  lambda_config = [
    {
      name    = "secrets-manager-rotation-module"
      handler = "handler.handler"
      deployment_type = {
        full_managed = true
      }
    }
  ]

  lambda_full_managed_config = [
    {
      name               = "secrets-manager-rotation-module"
      compress_from_file = "handler.js"
    }
  ]

  lambda_permissions_config = [
    {
      name = "secrets-manager-rotation-module"
    }
  ]
}
