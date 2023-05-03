output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "aws_region_for_deploy" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "bucket_id" {
  value       = [for bucket in aws_s3_bucket.this : bucket.id]
  description = "The ID of the S3 bucket."
}

output "bucket_arn" {
  value       = [for bucket in aws_s3_bucket.this : bucket.arn]
  description = "The ARN of the S3 bucket."
}

output "bucket_domain_name" {
  value       = [for bucket in aws_s3_bucket.this : bucket.bucket_domain_name]
  description = "The bucket domain name."
}

output "bucket_regional_domain_name" {
  value       = [for bucket in aws_s3_bucket.this : bucket.bucket_regional_domain_name]
  description = "The bucket region domain name."
}
