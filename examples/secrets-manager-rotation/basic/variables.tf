variable "is_enabled" {
  description = "Enable or disable the module"
  type        = bool
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "rotation_config" {
  type = list(object({
    name                      = string
    secret_name               = optional(string, null)
    secret_arn                = optional(string, null)
    enable_default_iam_policy = optional(bool, false)
  }))
  description = <<EOF
This configuration allows you to set up a rotation for an existing secret.
Attributes:
- name: Friendly Terraform identifier used to create the rotation name.
- secret_name: Name of the existing secret (optional). If not provided, 'name' will be used.
- secret_arn: ARN of the existing secret (optional). If not provided, the ARN will be fetched using 'secret_name'.
- enable_default_iam_policy: If true, the module creates a default IAM policy for rotation.

Note: If 'secret_arn' is provided, 'secret_name' will be ignored.
EOF
  default     = null
}

variable "rotation_lambda_config" {
  type = list(object({
    name                  = string
    secret_name           = optional(string, null)
    lambda_arn            = optional(string, null)
    lambda_name           = optional(string, null)
    enable_default_lambda = optional(bool, false)
  }))
  description = <<EOF
This configuration allows you to set up a rotation for an existing secret using a Lambda function.
Attributes:
- name: Friendly Terraform identifier used to create the rotation name.
- secret_name: Name of the existing secret (optional). If not provided, 'name' will be used.
- lambda_arn: ARN of the Lambda function (optional). If not provided, the ARN will be fetched using 'lambda_name'.
- lambda_name: Name of the Lambda function (optional). If provided, it generates the necessary 'lambda_permissions' for the secret to invoke the Lambda function.
- enable_default_lambda: If true, the module creates a default Lambda function for rotation.

Note: If 'lambda_arn' is provided, 'lambda_name' will be ignored.
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
