output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "aws_region_for_deploy" {
  value       = module.main_module.aws_region_for_deploy
  description = "The AWS region where the module is deployed."
}

output "bucket_id" {
  value       = module.main_module.bucket_id
  description = "The ID of the S3 bucket."
}

output "bucket_arn" {
  value       = module.main_module.bucket_arn
  description = "The ARN of the S3 bucket."
}

output "bucket_domain_name" {
  value       = module.main_module.bucket_domain_name
  description = "The bucket domain name."
}

output "bucket_regional_domain_name" {
  value       = module.main_module.bucket_regional_domain_name
  description = "The bucket region domain name."
}
