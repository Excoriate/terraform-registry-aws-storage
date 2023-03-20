variable "is_enabled" {
  description = "Enable or disable the module"
  type        = bool
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "secret_permissions" {
  type = list(object({
    name          = string
    secret_name   = string
    permissions   = optional(list(string), null)
    allow         = optional(bool, true)
    deny          = optional(bool, false)
    iam_role_name = optional(string, null)
    iam_role_arn  = optional(string, null)
  }))
  description = <<EOF
Configure a set of permissions for an AWS secrets manager secret. If the 'iam_role_to_attach' is not provided, no
attachment (IAM policy attachment) will be created, and just the IAM policy will be generated. If it's provided,
the IAM policy will be attached to the IAM role.
The attributes are:
- name: Terraform friendly-name, which is used just to internal computations.
- secret_name: The name of the AWS secrets manager secret.
- permissions (optional): A list of permissions to be granted to the IAM role. If not provided, the default permissions will be used [*].
- allow (optional): Whether to allow the permissions or not. Default is true.
- deny (optional): Whether to deny the permissions or not. Default is false.
- iam_role_name (optional): The name of the IAM role to attach the IAM policy to. If not provided, no attachment will be created.
- iam_role_arn (optional): The ARN of the IAM role to attach the IAM policy to. If not provided, no attachment will be created.
  EOF
  default     = null
}
