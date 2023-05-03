module "main_module" {
  source     = "../../../../modules/s3/s3-lambda-deployment"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  bucket_config      = var.bucket_config
  bucket_permissions = var.bucket_permissions
}
