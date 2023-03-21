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

output "dynamodb_table_arn" {
  value       = module.main_module.dynamodb_table_arn
  description = "The ARN of the DynamoDB table."
}

output "dynamodb_table_name" {
  value       = module.main_module.dynamodb_table_name
  description = "The name of the DynamoDB table."
}

output "dynamodb_table_id" {
  value       = module.main_module.dynamodb_table_id
  description = "The ID of the DynamoDB table."
}

output "dynamodb_table_stream_arn" {
  value       = module.main_module.dynamodb_table_stream_arn
  description = "The ARN of the DynamoDB table stream."
}

output "dynamodb_table_stream_label" {
  value       = module.main_module.dynamodb_table_stream_label
  description = "A timestamp, in ISO 8601 format, for this stream."
}

output "dynamodb_table_stream_view_type" {
  value       = module.main_module.dynamodb_table_stream_view_type
  description = "When an item in the table is modified, StreamViewType determines what information is written to the stream for this table."
}

output "dynamodb_table_write_capacity" {
  value       = module.main_module.dynamodb_table_write_capacity
  description = "The write capacity for the table."
}

output "dynamodb_table_read_capacity" {
  value       = module.main_module.dynamodb_table_read_capacity
  description = "The read capacity for the table."
}
