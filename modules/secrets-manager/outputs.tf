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
output "secret_id" {
  value       = [for secret in aws_secretsmanager_secret.this : secret.id]
  description = "The ID of the secret."
}

output "secret_arn" {
  value       = [for secret in aws_secretsmanager_secret.this : secret.arn]
  description = "The ARN of the secret."
}

output "secret_name" {
  value       = [for secret in aws_secretsmanager_secret.this : secret.name]
  description = "The name of the secret."
}

output "secret_policy" {
  value       = [for secret in aws_secretsmanager_secret.this : secret.policy]
  description = "The policy of the secret."
}
