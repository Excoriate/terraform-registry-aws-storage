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
    name          = string
    bucket_name   = optional(string, null) // If it's set in null, it'll take the 'name' value.
    force_destroy = optional(bool, false)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration of the buckets to be created. The following attributes
are currently supported:
- name: A terraform identifier. It shouldn't be used for naming this resource.
- bucket_name: The name of the bucket. If it's set in null, it'll take the 'name' value.
- force_destroy: A boolean that indicates if the bucket can be destroyed even if it has objects inside.
For a more detailed documentation about this resource, please refer to the following link:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
EOF
}

variable "bucket_permissions" {
  type = list(object({
    name                          = string
    enable_encrypted_uploads_only = optional(bool, false)
    enable_ssl_requests_only      = optional(bool, false)
    iam_policy_documents_to_attach = optional(list(object({
      sid     = string
      effect  = string
      actions = list(string)
      principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })), [])
      conditions = optional(list(object({
        test     = string
        variable = string
        values   = list(string)
      })), [])
    })), [])
  }))
  default     = null
  description = <<EOF
 A list of objects to configure specific permissions for one or many buckets. The following attributes
are currently supported:
- name: A terraform identifier. It shouldn't be used for naming this resource.
- enable_encrypted_uploads_only: A boolean that indicates if the bucket will have encrypted uploads only enabled.
- enable_ssl_requests_only: A boolean that indicates if the bucket will have SSL requests only enabled.
- iam_policy_documents_to_attach: A list of IAM policy documents to attach to the bucket. Each policy document
in JSON format.
EOF
}
