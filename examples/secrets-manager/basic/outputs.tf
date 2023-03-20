output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "secret_id" {
  value       = module.main_module.secret_id
  description = "The ID of the secret."
}

output "secret_arn" {
  value       = module.main_module.secret_arn
  description = "The ARN of the secret."
}

output "secret_name" {
  value       = module.main_module.secret_name
  description = "The name of the secret."
}

output "secret_policy" {
  value       = module.main_module.secret_policy
  description = "The policy of the secret."
}
