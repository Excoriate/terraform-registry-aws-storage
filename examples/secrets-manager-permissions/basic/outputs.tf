output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}


/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "iam_policy_allow_id" {
  value       = module.main_module.iam_policy_allow_id
  description = "The secret IAM policy when the 'allow' option is enabled"
}

output "iam_policy_deny_id" {
  value       = module.main_module.iam_policy_deny_id
  description = "The secret IAM policy when the 'deny' option is enabled"
}

output "iam_policy_allow_arn" {
  value       = module.main_module.iam_policy_allow_arn
  description = "The secret IAM policy when the 'allow' option is enabled"
}

output "iam_policy_deny_arn" {
  value       = module.main_module.iam_policy_deny_arn
  description = "The secret IAM policy when the 'deny' option is enabled"
}

output "iam_policy_allow_name" {
  value       = module.main_module.iam_policy_allow_name
  description = "The secret IAM policy when the 'allow' option is enabled"
}

output "iam_policy_deny_name" {
  value       = module.main_module.iam_policy_deny_name
  description = "The secret IAM policy when the 'deny' option is enabled"
}
