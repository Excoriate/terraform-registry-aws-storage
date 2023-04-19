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
variable "rotation_config" {
  type = list(object({
    name        = string
    secret_name = optional(string, null)
    secret_arn  = optional(string, null)
  }))
  description = <<EOF
  default     = null
This configuration allow you to create a rotation for a secret that already exists.
The current attributes of the secret will be used to create the rotation:
- name: Friendly terraform identifier. It will be used to create the rotation name.
- secret_name: The name of the secret. If not provided, the name will be used.
- secret_arn: The ARN of the secret. If not provided, the ARN will be retrieved from the secret name.
If the 'secret_arn' is provided, the 'secret_name' will be ignored.
EOF
  default     = null
}

variable "rotation_lambda_config" {
  type = list(object({
    name                  = string
    secret_name           = optional(string, null)
    lambda_arn            = optional(string, null)
    enable_default_lambda = optional(bool, false) // Available in future version of this module.
  }))
  description = <<EOF
This configuration allow you to create a rotation for a secret that already exists.
The current attributes of the secret will be used to create the rotation:
- name: Friendly terraform identifier. It will be used to create the rotation name.
- secret_name: The name of the secret. If not provided, the name will be used.
- lambda_arn: The ARN of the lambda function. If not provided, the ARN will be retrieved from the lambda name.
If the 'lambda_arn' is provided, the 'lambda_name' will be ignored.
- enable_default_lambda: If true, the module will create a default lambda function to perform the rotation.
EOF
  default     = null
}

variable "rotation_rules_config" {
  type = list(object({
    name                              = string
    secret_name                       = optional(string, null)
    rotation_duration                 = optional(number, null)
    rotation_automatically_after_days = optional(number, null)
    rotation_by_schedule_expression   = optional(string, null)
  }))
  description = <<EOF
This configuration allow you to create a rotation for a secret that already exists.
The current attributes of the secret will be used to create the rotation:
- name: Friendly terraform identifier. It will be used to create the rotation name.
- secret_name: The name of the secret. If not provided, the name will be used.
- rotation_duration: The number of days between automatic scheduled rotations of the secret.
- rotation_automatically_after_days: The number of days after the previous rotation when Secrets Manager triggers the next automatic rotation.
- rotation_by_schedule_expression: A cron expression that defines the schedule for the rotation.
EOF
  default     = null
}
