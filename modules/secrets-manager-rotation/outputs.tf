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
output "lookup_arn_secret_id" {
  value       = [for secret in data.aws_secretsmanager_secret.lookup_by_arn : secret.id]
  description = "The ID of the secret."
}

output "lookup_arn_secret_name" {
  value       = [for secret in data.aws_secretsmanager_secret.lookup_by_arn : secret.name]
  description = "The name of the secret."
}

output "lookup_name_secret_id" {
  value       = [for secret in data.aws_secretsmanager_secret.lookup_by_name : secret.id]
  description = "The ID of the secret."
}

output "lookup_name_secret_name" {
  value       = [for secret in data.aws_secretsmanager_secret.lookup_by_name : secret.name]
  description = "The name of the secret."
}

output "secret_rotation_id" {
  value       = [for secret in aws_secretsmanager_secret_rotation.this : secret.id]
  description = "The ID of the secret rotation."
}

output "secret_rotation_enabled" {
  value       = [for secret in aws_secretsmanager_secret_rotation.this : secret.rotation_enabled]
  description = "Whether the rotation is enabled."
}
