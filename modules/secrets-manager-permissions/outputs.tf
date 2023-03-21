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
output "iam_policy_allow_id" {
  value       = [for policy in aws_iam_policy.allow : policy.id]
  description = "The secret IAM policy when the 'allow' option is enabled"
}

output "iam_policy_deny_id" {
  value       = [for policy in aws_iam_policy.deny : policy.id]
  description = "The secret IAM policy when the 'deny' option is enabled"
}

output "iam_policy_allow_arn" {
  value       = [for policy in aws_iam_policy.allow : policy.arn]
  description = "The secret IAM policy when the 'allow' option is enabled"
}

output "iam_policy_deny_arn" {
  value       = [for policy in aws_iam_policy.deny : policy.arn]
  description = "The secret IAM policy when the 'deny' option is enabled"
}

output "iam_policy_allow_name" {
  value       = [for policy in aws_iam_policy.allow : policy.name]
  description = "The secret IAM policy when the 'allow' option is enabled"
}

output "iam_policy_deny_name" {
  value       = [for policy in aws_iam_policy.deny : policy.name]
  description = "The secret IAM policy when the 'deny' option is enabled"
}
