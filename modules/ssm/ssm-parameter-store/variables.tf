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
variable "parameters_config" {
  type = list(object({
    name           = string
    parameter_path = string
    parameter_type = string
    // Optional set of parameters that can be passed.
    allowed_pattern = optional(string, null)
    data_type       = optional(string, null)
    description     = optional(string, null)
    insecure_value  = optional(string, null)
    key_id          = optional(string, null)
    overwrite       = optional(bool, null)
    tier            = optional(string, null)
    value           = optional(string, null)
  }))
  description = <<EOF
  A list of parameters to create. Each element in the list must be a map with the following keys:
  name - (Required) It's used as an ID or Terrafrom identifier. It's not considered as part of the resource configuration.
  parameter_path - (Required) The full path name of the parameter.
  parameter_type - (Required) The type of the parameter. Valid values are String, StringList and SecureString.
  allowed_pattern - (Optional) A regular expression used to validate the parameter value. For example, for String types with values restricted to numbers, you can specify the following: AllowedPattern=^\d+$
  data_type - (Optional) The data type of the parameter, such as text or aws:ec2:image. The default value is text.
  description - (Optional) Information about the parameter that you want to add to the system. Important: You can't use the following symbols: equal sign (=), comma (,), colon (:), forward slash (/), square brackets ([]), curly braces ({}) at the start or end of the description. The description can't begin with a white space character.
  insecure_value - (Optional) The parameter value that you want to add to the system. It's not considered as part of the resource configuration.
  key_id - (Optional) The KMS Key ID that you want to use to encrypt a SecureString parameter. Either KeyId or KeyName must be specified.
  overwrite - (Optional) Overwrite an existing parameter. If not specified, will default to false.
  tier - (Optional) The tier of the parameter. Valid values are Standard and Advanced. Standard parameters have a content size limit of 4 KB and can't be configured to use parameter policies. You can create a maximum of 10,000 standard parameters for each Region in an AWS account. Standard parameters are offered at no additional cost. Advanced parameters have a content size limit of 8 KB and can be configured to use parameter policies. You can create a maximum of 100,000 advanced parameters for each Region in an AWS account. Advanced parameters incur a charge. For more information, see AWS Systems Manager Pricing.
  value - (Optional) The parameter value that you want to add to the system. It's not considered as part of the resource configuration.
EOF
  default     = null
}
