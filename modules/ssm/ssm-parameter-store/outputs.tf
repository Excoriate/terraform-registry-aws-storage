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

output "parameters_normalised" {
  value       = local.parameters_cfg_create
  description = "The parameters normalised."
}

output "parameters_path" {
  value       = [for p in aws_ssm_parameter.this : p.name]
  description = "The parameters path or name."
}

output "parameters_value" {
  value       = [for p in aws_ssm_parameter.this : p.value]
  description = "The actual parameters, or their values."
  sensitive   = true
}

output "parameters_type" {
  value       = [for p in aws_ssm_parameter.this : p.type]
  description = "The parameters type."
}

output "parameters_version" {
  value       = [for p in aws_ssm_parameter.this : p.version]
  description = "The parameters version."
}

output "parameters_arn" {
  value       = [for p in aws_ssm_parameter.this : p.arn]
  description = "The parameters ARN."
}
