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
  default = null
}

variable "rotation_rules_config" {
  type = list(object({
    name                              = string
    secret_name                       = optional(string, null)
    rotation_duration                 = optional(number, null)
    rotation_automatically_after_days = optional(number, null)
    rotation_by_schedule_expression   = optional(string, null)
  }))
  default = null
}
