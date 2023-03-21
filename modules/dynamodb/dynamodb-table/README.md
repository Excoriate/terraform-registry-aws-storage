<!-- BEGIN_TF_DOCS -->
# ☁️ AWS Dynamo db table
## Description


This module creates a DynamoDB table with the following features:
🚀 Create a DynamoDB table with a single partition key.
🚀 Create a DynamoDB table with a single partition key and a single sort key.
🚀 Create a DynamoDB table with a single partition key and multiple sort keys.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../../modules/dynamodb/dynamodb-table"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  table_config                  = var.table_config
  dynamodb_attributes           = var.dynamodb_attributes
  dynamodb_keys                 = var.dynamodb_keys
  ttl_config                    = var.ttl_config
  server_side_encryption_config = var.server_side_encryption_config
  global_secondary_index_map    = var.global_secondary_index_map
  local_secondary_index_map     = var.local_secondary_index_map
}
```

Simple recipe:
```hcl
aws_region = "us-east-1"
is_enabled = true

table_config = {
  name                                  = "test1"
  table_name                            = "test_table"
  hash_key                              = "id"
  enable_ignore_changes_on_auto_scaling = true
}

dynamodb_keys = {
  hash_key = "id"
}
```
An example that shows a full configuration, with TTL, attributes and indexes:
```hcl
aws_region = "us-east-1"
is_enabled = true

table_config = {
  name                                  = "test1"
  table_name                            = "test_table"
  hash_key                              = "id"
  enable_ignore_changes_on_auto_scaling = false
}

dynamodb_keys = {
  hash_key = "id"
  sort_key = "name"
}

dynamodb_attributes = [
  {
    name = "DailyAverage"
    type = "N"
  },
  {
    name = "HighWater"
    type = "N"
  },
  {
    name = "Timestamp"
    type = "S"
  }
]

local_secondary_index_map = [
  {
    name               = "TimestampSortIndex"
    range_key          = "Timestamp"
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  },
  {
    name               = "HighWaterIndex"
    range_key          = "Timestamp"
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  }
]

global_secondary_index_map = [
  {
    name               = "DailyAverageIndex"
    hash_key           = "DailyAverage"
    range_key          = "HighWater"
    write_capacity     = 5
    read_capacity      = 5
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  }
]

ttl_config = {
  attribute_name = "HighWater"
  enabled        = true
}
```
An example that implements server side encryption:
```hcl
aws_region = "us-east-1"
is_enabled = true

table_config = {
  name                                  = "test1"
  table_name                            = "test_table"
  hash_key                              = "id"
  enable_ignore_changes_on_auto_scaling = false
}

dynamodb_keys = {
  hash_key = "id"
  sort_key = "name"
}

dynamodb_attributes = [
  {
    name = "DailyAverage"
    type = "N"
  },
  {
    name = "HighWater"
    type = "N"
  },
  {
    name = "Timestamp"
    type = "S"
  }
]

local_secondary_index_map = [
  {
    name               = "TimestampSortIndex"
    range_key          = "Timestamp"
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  },
  {
    name               = "HighWaterIndex"
    range_key          = "Timestamp"
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  }
]

global_secondary_index_map = [
  {
    name               = "DailyAverageIndex"
    hash_key           = "DailyAverage"
    range_key          = "HighWater"
    write_capacity     = 5
    read_capacity      = 5
    projection_type    = "INCLUDE"
    non_key_attributes = ["HashKey", "RangeKey"]
  }
]

ttl_config = {
  attribute_name = "HighWater"
  enabled        = true
}

server_side_encryption_config = {
  enabled = true
}
```

```
For module composition, It's recommended to take a look at the module's `outputs` to understand what's available:
```hcl
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
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.59.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table.ignore_auto_scaling_changes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_dynamodb_attributes"></a> [dynamodb\_attributes](#input\_dynamodb\_attributes) | A list of objects that contains the configuration for each attribute to be created.<br>  Each object must contain the following attributes:<br>  - name: The name of the attribute.<br>  - type: The type of the attribute. Valid values are S, N, B, SS, NS, BS, BOOL, NULL, M, L, and S. | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | `[]` | no |
| <a name="input_dynamodb_keys"></a> [dynamodb\_keys](#input\_dynamodb\_keys) | An object that contains the configuration for the table keys.<br>  The object must contain the following attributes:<br>  - hash\_key: The name of the hash key.<br>  - hash\_key\_type: The type of the hash key. Valid values are S, N, B, SS, NS, BS, BOOL, NULL, M, L, and S. Default value is S.<br>  - sort\_key: The name of the sort key. Default value is null.<br>  - sort\_key\_type: The type of the sort key. Valid values are S, N, B, SS, NS, BS, BOOL, NULL, M, L, and S. Default value is S. | <pre>object({<br>    hash_key      = string<br>    hash_key_type = optional(string, "S")<br>    sort_key      = optional(string, null)<br>    sort_key_type = optional(string, "S")<br>  })</pre> | <pre>{<br>  "hash_key": "id",<br>  "hash_key_type": "S",<br>  "sort_key": null,<br>  "sort_key_type": null<br>}</pre> | no |
| <a name="input_global_secondary_index_map"></a> [global\_secondary\_index\_map](#input\_global\_secondary\_index\_map) | Additional global secondary indexes in the form of a list of mapped values | <pre>list(object({<br>    hash_key           = string<br>    name               = string<br>    non_key_attributes = list(string)<br>    projection_type    = string<br>    range_key          = string<br>    read_capacity      = number<br>    write_capacity     = number<br>  }))</pre> | `[]` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_local_secondary_index_map"></a> [local\_secondary\_index\_map](#input\_local\_secondary\_index\_map) | Additional local secondary indexes in the form of a list of mapped values | <pre>list(object({<br>    name               = string<br>    non_key_attributes = list(string)<br>    projection_type    = string<br>    range_key          = string<br>  }))</pre> | `[]` | no |
| <a name="input_server_side_encryption_config"></a> [server\_side\_encryption\_config](#input\_server\_side\_encryption\_config) | An object that contains the configuration for server side encryption.<br>  The object must contain the following attributes:<br>  - enabled: Whether server side encryption is enabled. Default value is false.<br>  - kms\_key\_arn: The ARN of the KMS key to use for encryption. Only valid if enabled is true. Default value is null. | <pre>object({<br>    enabled     = optional(bool, false)<br>    kms_key_arn = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_table_config"></a> [table\_config](#input\_table\_config) | A list of objects that contains the configuration for each table to be created.<br>  Each object must contain the following attributes:<br>  - name: A terraform friendly identifier. Used for internal computations.<br>  - table\_name: The name of the table.<br>  - billing\_mode: The billing mode of the table. Valid values are PROVISIONED or PAY\_PER\_REQUEST. Default value is PAY\_PER\_REQUEST.<br>  - read\_capacity: The read capacity of the table. Only valid if billing\_mode is PROVISIONED. Default value is 1.<br>  - write\_capacity: The write capacity of the table. Only valid if billing\_mode is PROVISIONED. Default value is 1.<br>  - stream\_enabled: Whether the DynamoDB stream is enabled. Default value is false.<br>  - stream\_view\_type: The DynamoDB stream view type. Valid values are KEYS\_ONLY, NEW\_IMAGE, OLD\_IMAGE, NEW\_AND\_OLD\_IMAGES. Default value is NEW\_AND\_OLD\_IMAGES.<br>  - enable\_point\_in\_time\_recovery: Whether point in time recovery is enabled. Default value is false.<br>  - enable\_ignore\_changes\_on\_auto\_scaling: Whether to ignore changes on auto scaling. Default value is false.<br>  - replicate\_in\_regions: A list of regions where the table will be replicated. Default value is []. | <pre>object({<br>    name                                  = string<br>    table_name                            = string<br>    billing_mode                          = optional(string, "PAY_PER_REQUEST")<br>    read_capacity                         = optional(number, 1)<br>    write_capacity                        = optional(number, 1)<br>    stream_enabled                        = optional(bool, false)<br>    stream_view_type                      = optional(string, "NEW_AND_OLD_IMAGES")<br>    enable_point_in_time_recovery         = optional(bool, false)<br>    enable_ignore_changes_on_auto_scaling = optional(bool, false)<br>    replicate_in_regions                  = optional(list(string), [])<br>    table_class                           = optional(string, "STANDARD")<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_ttl_config"></a> [ttl\_config](#input\_ttl\_config) | An object that contains the configuration for time to live.<br>  The object must contain the following attributes:<br>  - enabled: Whether time to live is enabled. Default value is false.<br>  - attribute\_name: The name of the attribute to use for time to live. Only valid if enabled is true. Default value is null. | <pre>object({<br>    enabled        = optional(bool, false)<br>    attribute_name = optional(string, null)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy"></a> [aws\_region\_for\_deploy](#output\_aws\_region\_for\_deploy) | The AWS region where the module is deployed. |
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | The ARN of the DynamoDB table. |
| <a name="output_dynamodb_table_id"></a> [dynamodb\_table\_id](#output\_dynamodb\_table\_id) | The ID of the DynamoDB table. |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | The name of the DynamoDB table. |
| <a name="output_dynamodb_table_read_capacity"></a> [dynamodb\_table\_read\_capacity](#output\_dynamodb\_table\_read\_capacity) | The read capacity for the table. |
| <a name="output_dynamodb_table_stream_arn"></a> [dynamodb\_table\_stream\_arn](#output\_dynamodb\_table\_stream\_arn) | The ARN of the DynamoDB table stream. |
| <a name="output_dynamodb_table_stream_label"></a> [dynamodb\_table\_stream\_label](#output\_dynamodb\_table\_stream\_label) | A timestamp, in ISO 8601 format, for this stream. |
| <a name="output_dynamodb_table_stream_view_type"></a> [dynamodb\_table\_stream\_view\_type](#output\_dynamodb\_table\_stream\_view\_type) | When an item in the table is modified, StreamViewType determines what information is written to the stream for this table. |
| <a name="output_dynamodb_table_write_capacity"></a> [dynamodb\_table\_write\_capacity](#output\_dynamodb\_table\_write\_capacity) | The write capacity for the table. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->