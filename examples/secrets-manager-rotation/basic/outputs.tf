output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "lookup_arn_secret_id" {
  value       = module.main_module.lookup_arn_secret_id
  description = "The ID of the secret."
}

output "lookup_arn_secret_name" {
  value       = module.main_module.lookup_arn_secret_name
  description = "The name of the secret."
}

output "lookup_name_secret_id" {
  value       = module.main_module.lookup_name_secret_id
  description = "The ID of the secret."
}

output "lookup_name_secret_name" {
  value       = module.main_module.lookup_name_secret_name
  description = "The name of the secret."
}

output "secret_rotation_default_policy_arn" {
  value       = module.main_module.secret_rotation_default_policy_arn
  description = "The default policy for the secret rotation."
}

output "secret_rotation_default_policy_doc" {
  value       = module.main_module.secret_rotation_default_policy_doc
  description = "The default policy document for the secret rotation."
}

output "secret_rotation_id" {
  value       = module.main_module.secret_rotation_id
  description = "The ID of the secret rotation."
}

output "secret_rotation_lambda_arn" {
  value       = module.main_module.secret_rotation_lambda_arn
  description = "The ARN of the Lambda function."
}
