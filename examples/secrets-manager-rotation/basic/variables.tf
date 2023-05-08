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
    name                      = string
    secret_name               = optional(string, null)
    secret_arn                = optional(string, null)
    enable_default_iam_policy = optional(bool, false)
    rotation_lambda_arn       = optional(string, null)
    rotation_lambda_name      = optional(string, null)
  }))
  description = <<EOF
This configuration allows you to set up a rotation for an existing secret.
Attributes:
- name: Friendly Terraform identifier used to create the rotation name.
- secret_name: Name of the existing secret (optional). If not provided, 'name' will be used.
- secret_arn: ARN of the existing secret (optional). If not provided, the ARN will be fetched using 'secret_name'.
- enable_default_iam_policy: If true, the module creates a default IAM policy for rotation.
- rotation_lambda_arn: ARN of the Lambda function (optional). If not provided, the ARN will be fetched using 'rotation_lambda_name'.
- rotation_lambda_name: Name of the Lambda function (optional). If provided, it generates the necessary 'lambda_permissions' for the secret to invoke the Lambda function.

Note: If 'secret_arn' is provided, 'secret_name' will be ignored.
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
This configuration allows you to set up rotation rules for an existing secret.
Attributes:
- name: Friendly Terraform identifier used to create the rotation name.
- secret_name: Name of the existing secret (optional). If not provided, 'name' will be used.
- rotation_duration: Number of days between automatic scheduled rotations of the secret (optional).
- rotation_automatically_after_days: Number of days after the previous rotation when Secrets Manager triggers the next automatic rotation (optional).
- rotation_by_schedule_expression: A cron expression that defines the schedule for the rotation (optional).

For more information, refer to the AWS documentation on rotation rules:
https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html
EOF
  default     = null
}
