variable "is_enabled" {
  type        = bool
  description = <<EOF
  Whether this module will be created or not. It is useful, for stack-composite
modules that conditionally includes resources provided by this module..
EOF
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the resources"
}

/*
-------------------------------------
Custom input variables
-------------------------------------
*/
variable "table_config" {
  type = object({
    name                                  = string
    table_name                            = string
    billing_mode                          = optional(string, "PAY_PER_REQUEST")
    read_capacity                         = optional(number, 1)
    write_capacity                        = optional(number, 1)
    stream_enabled                        = optional(bool, false)
    stream_view_type                      = optional(string, "NEW_AND_OLD_IMAGES")
    enable_point_in_time_recovery         = optional(bool, false)
    enable_ignore_changes_on_auto_scaling = optional(bool, false)
    replicate_in_regions                  = optional(list(string), [])
    table_class                           = optional(string, "STANDARD")
  })
  description = <<EOF
  A list of objects that contains the configuration for each table to be created.
  Each object must contain the following attributes:
  - name: A terraform friendly identifier. Used for internal computations.
  - table_name: The name of the table.
  - billing_mode: The billing mode of the table. Valid values are PROVISIONED or PAY_PER_REQUEST. Default value is PAY_PER_REQUEST.
  - read_capacity: The read capacity of the table. Only valid if billing_mode is PROVISIONED. Default value is 1.
  - write_capacity: The write capacity of the table. Only valid if billing_mode is PROVISIONED. Default value is 1.
  - stream_enabled: Whether the DynamoDB stream is enabled. Default value is false.
  - stream_view_type: The DynamoDB stream view type. Valid values are KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES. Default value is NEW_AND_OLD_IMAGES.
  - enable_point_in_time_recovery: Whether point in time recovery is enabled. Default value is false.
  - enable_ignore_changes_on_auto_scaling: Whether to ignore changes on auto scaling. Default value is false.
  - replicate_in_regions: A list of regions where the table will be replicated. Default value is [].
  EOF
  default     = null
}

variable "dynamodb_attributes" {
  type = list(object({
    name = string
    type = string
  }))
  default     = []
  description = <<EOF
  A list of objects that contains the configuration for each attribute to be created.
  Each object must contain the following attributes:
  - name: The name of the attribute.
  - type: The type of the attribute. Valid values are S, N, B, SS, NS, BS, BOOL, NULL, M, L, and S.
  EOF
}

variable "server_side_encryption_config" {
  type = object({
    enabled     = optional(bool, false)
    kms_key_arn = optional(string, null)
  })
  default     = null
  description = <<EOF
  An object that contains the configuration for server side encryption.
  The object must contain the following attributes:
  - enabled: Whether server side encryption is enabled. Default value is false.
  - kms_key_arn: The ARN of the KMS key to use for encryption. Only valid if enabled is true. Default value is null.
  EOF
}

variable "ttl_config" {
  type = object({
    enabled        = optional(bool, false)
    attribute_name = optional(string, null)
  })
  default     = null
  description = <<EOF
  An object that contains the configuration for time to live.
  The object must contain the following attributes:
  - enabled: Whether time to live is enabled. Default value is false.
  - attribute_name: The name of the attribute to use for time to live. Only valid if enabled is true. Default value is null.
  EOF
}

variable "dynamodb_keys" {
  type = object({
    hash_key      = string
    hash_key_type = optional(string, "S")
    sort_key      = optional(string, null)
    sort_key_type = optional(string, "S")
  })
  default = {
    hash_key      = "id"
    hash_key_type = "S"
    sort_key      = null
    sort_key_type = null
  }
  description = <<EOF
  An object that contains the configuration for the table keys.
  The object must contain the following attributes:
  - hash_key: The name of the hash key.
  - hash_key_type: The type of the hash key. Valid values are S, N, B, SS, NS, BS, BOOL, NULL, M, L, and S. Default value is S.
  - sort_key: The name of the sort key. Default value is null.
  - sort_key_type: The type of the sort key. Valid values are S, N, B, SS, NS, BS, BOOL, NULL, M, L, and S. Default value is S.
  EOF
}

variable "global_secondary_index_map" {
  type = list(object({
    hash_key           = string
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
    read_capacity      = number
    write_capacity     = number
  }))
  default     = []
  description = "Additional global secondary indexes in the form of a list of mapped values"
}

variable "local_secondary_index_map" {
  type = list(object({
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
  }))
  default     = []
  description = "Additional local secondary indexes in the form of a list of mapped values"
}
