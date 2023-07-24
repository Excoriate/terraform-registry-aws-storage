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

output "parameters_normalised" {
  value       = module.main_module.parameters_normalised
  description = "The parameters normalised."
}

output "parameters_path" {
  value       = module.main_module.parameters_path
  description = "The parameters path or name."
}

output "parameters_value" {
  value       = module.main_module.parameters_value
  description = "The actual parameters, or their values."
  sensitive   = true
}

output "parameters_type" {
  value       = module.main_module.parameters_type
  description = "The parameters type."
}

output "parameters_version" {
  value       = module.main_module.parameters_version
  description = "The parameters version."
}

output "parameters_arn" {
  value       = module.main_module.parameters_arn
  description = "The parameters ARN."
}
