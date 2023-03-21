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

output "dynamodb_table_arn" {
  value       = length([for table in aws_dynamodb_table.default : table.arn]) > 0 ? join("", [for table in aws_dynamodb_table.default : table.arn]) : join("", [for table in aws_dynamodb_table.ignore_auto_scaling_changes : table.arn])
  description = "The ARN of the DynamoDB table."
}

output "dynamodb_table_name" {
  value       = length([for table in aws_dynamodb_table.default : table.name]) > 0 ? join("", [for table in aws_dynamodb_table.default : table.name]) : join("", [for table in aws_dynamodb_table.ignore_auto_scaling_changes : table.name])
  description = "The name of the DynamoDB table."
}

output "dynamodb_table_id" {
  value       = length([for table in aws_dynamodb_table.default : table.id]) > 0 ? join("", [for table in aws_dynamodb_table.default : table.id]) : join("", [for table in aws_dynamodb_table.ignore_auto_scaling_changes : table.id])
  description = "The ID of the DynamoDB table."
}

output "dynamodb_table_stream_arn" {
  value       = length([for table in aws_dynamodb_table.default : table.stream_arn]) > 0 ? join("", [for table in aws_dynamodb_table.default : table.stream_arn]) : join("", [for table in aws_dynamodb_table.ignore_auto_scaling_changes : table.stream_arn])
  description = "The ARN of the DynamoDB table stream."
}

output "dynamodb_table_stream_label" {
  value       = length([for table in aws_dynamodb_table.default : table.stream_label]) > 0 ? join("", [for table in aws_dynamodb_table.default : table.stream_label]) : join("", [for table in aws_dynamodb_table.ignore_auto_scaling_changes : table.stream_label])
  description = "A timestamp, in ISO 8601 format, for this stream."
}

output "dynamodb_table_stream_view_type" {
  value       = length([for table in aws_dynamodb_table.default : table.stream_view_type]) > 0 ? join("", [for table in aws_dynamodb_table.default : table.stream_view_type]) : join("", [for table in aws_dynamodb_table.ignore_auto_scaling_changes : table.stream_view_type])
  description = "When an item in the table is modified, StreamViewType determines what information is written to the stream for this table."
}

output "dynamodb_table_write_capacity" {
  value       = length([for table in aws_dynamodb_table.default : table.write_capacity]) > 0 ? join("", [for table in aws_dynamodb_table.default : table.write_capacity]) : join("", [for table in aws_dynamodb_table.ignore_auto_scaling_changes : table.write_capacity])
  description = "The write capacity for the table."
}

output "dynamodb_table_read_capacity" {
  value       = length([for table in aws_dynamodb_table.default : table.read_capacity]) > 0 ? join("", [for table in aws_dynamodb_table.default : table.read_capacity]) : join("", [for table in aws_dynamodb_table.ignore_auto_scaling_changes : table.read_capacity])
  description = "The read capacity for the table."
}
