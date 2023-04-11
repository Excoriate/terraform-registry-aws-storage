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

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

/*
-------------------------------------
Custom input variables
-------------------------------------
*/
variable "bucket_config" {
  type = list(object({
    name                = string
    bucket_name         = optional(string, null) // If it's set in null, it'll take the 'name' value.
    force_destroy       = optional(bool, false)
    object_lock_enabled = optional(bool, false)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration of the buckets to be created. The following attributes
are currently supported:
- name: A terraform identifier. It shouldn't be used for naming this resource. However, if the 'bucket_name'
attribute is not set, it'll be used as the bucket name.
- bucket_name: The name of the bucket. If it's not set, the 'name' attribute will be used.
- force_destroy: A boolean that indicates if the bucket can be destroyed even if it contains objects.
- object_lock_enabled: A boolean that indicates if the bucket will have object lock enabled.
For a more detailed documentation about this resource, please refer to the following link:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
EOF
}

variable "bucket_options" {
  type = list(object({
    name                                  = string
    enable_transfer_acceleration          = optional(bool, false)
    enable_versioning                     = optional(bool, false)
    enable_default_server_side_encryption = optional(bool, false)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains optional configurations for the buckets. The following attributes
are currently supported:
- name: A terraform identifier. It shouldn't be used for naming this resource.
- enable_transfer_acceleration: A boolean that indicates if the bucket will have transfer acceleration enabled.
- enable_versioning: A boolean that indicates if the bucket will have versioning enabled.
- enable_default_server_side_encryption: A boolean that indicates if the bucket will have default server side encryption enabled.
For a more detailed documentation about this resource, please refer to the following link:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
EOF
}
