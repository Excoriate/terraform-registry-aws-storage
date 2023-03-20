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
variable "enforced_prefixes" {
  type = list(object({
    name   = string
    prefix = string
  }))
  description = <<EOF
  A list of prefixes to enforce. If the list is empty, all prefixes are allowed.
E.g.: if the prefix set is 'service', then all the paths should start with service/custom-path/my-secret
  EOF
  default     = null
}

variable "secrets_config" {
  type = list(object({
    name                    = string
    path                    = string
    description             = optional(string, null)
    policy                  = optional(string, null)
    kms_key_id              = optional(string, null)
    recovery_window_in_days = optional(number, 0)
  }))
  description = <<EOF
  A list of objects with the following attributes:
  - path: the path where the secret will be stored
  - description: the description of the secret
  - policy: the policy to apply to the secret
  - kms_key_id: the KMS key to use for the secret. If not provided, the default KMS key for the region will be used.
  - recovery_window_in_days: the number of days that the recovered secret can be accessed. If not provided, the default value of 30 days will be used.
For more details about this specific configuration, please visit the official AWS documentation at https://docs.aws.amazon.com/secretsmanager/latest/userguide/manage_delete-secret.html
  EOF
  default     = null
}

variable "secrets_replication_config" {
  type = list(object({
    name       = string
    region     = string
    kms_key_id = optional(string, null)
  }))
  description = <<EOF
  A list of objects with the following attributes:
  - region: the region where the secret will be replicated
  - kms_key_id: the KMS key to use for the replication. If not provided, the default KMS key for the region will be used.
For more details about this specific configuration, please visit the official AWS documentation at https://docs.aws.amazon.com/secretsmanager/latest/userguide/replication.html
  EOF
  default     = null
}

#variable "secrets_rotation_config" {
#  type = list(object({
#    name                     = string
#    rotation_lambda_arn      = string
#    automatically_after_days = optional(number, null)
#  }))
#  description = <<EOF
#  A list of objects with the following attributes:
#  - rotation_lambda_arn: the ARN of the Lambda function that can rotate the secret
#  - automatically_after_days: the number of days after the previous rotation when Secrets Manager triggers the next automatic rotation. If not provided, the rotation will be triggered manually.
#For more details about this specific configuration, please visit the official AWS documentation at https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html
#  EOF
#  default     = null
#}
