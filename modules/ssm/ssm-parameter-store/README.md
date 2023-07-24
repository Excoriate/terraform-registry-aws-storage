<!-- BEGIN_TF_DOCS -->
# ☁️ AWS SSM Parameter Store
## Description


This module manages an AWS SSM Parameter, a simple storage service for configuration data management and secrets. Capabilities of this module include:

* 🚀 **Name** - The name of the parameter.
* 🚀 **Type** - The type of the parameter - "String", "StringList" or "SecureString".
* 🚀 **Value** - The value of the parameter.
* 🚀 **Key-ID** - The KMS Key ID to use when encrypting the value of a SecureString.
* 🚀 **Overwrite** - Overwrite an existing parameter. Default is `false`.
* 🚀 **Tags** - A mapping of tags to assign to the object.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../../modules/ssm/ssm-parameter-store"
  is_enabled = var.is_enabled
  aws_region = var.aws_region
  parameters_config = length(var.parameters_config) == 0 ? [
    {
      name           = "from_main"
      parameter_path = "config/service/json/something"
      parameter_type = "String"
      value = jsonencode({
        key1 = "value1"
        key2 = "value2"
      })
    }
  ] : var.parameters_config
}
```

Simple recipe:
```hcl
aws_region = "us-east-1"
is_enabled = true

parameters_config = [
  {
    name           = "param1"
    parameter_path = "mypath"
    parameter_type = "String"
    value          = "value1"
  }
]
```

Multiple parameters.
```hcl
aws_region = "us-east-1"
is_enabled = true

parameters_config = [
  {
    name           = "param1"
    parameter_path = "mypath/param1"
    parameter_type = "String"
    value          = "value1"
  },
  {
    name           = "param2"
    parameter_path = "mypath/param2"
    parameter_type = "String"
    value          = "value2"
  },
  {
    name           = "param3"
    parameter_path = "mypath/param3"
    parameter_type = "String"
    value          = json
    description    = "my description"
    overwrite      = true
  },
]
```

JSON values
```hcl
aws_region = "us-east-1"
is_enabled = true

parameters_config = []
```
For module composition, It's recommended to take a look at the module's `outputs` to understand what's available:
```hcl
output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "aws_region_for_deploy" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "parameters_normalised" {
  value       = local.parameters_cfg_create
  description = "The parameters normalised."
}

output "parameters_path" {
  value       = [for p in aws_ssm_parameter.this : p.name]
  description = "The parameters path or name."
}

output "parameters_value" {
  value       = [for p in aws_ssm_parameter.this : p.value]
  description = "The actual parameters, or their values."
  sensitive = true
}

output "parameters_type" {
  value       = [for p in aws_ssm_parameter.this : p.type]
  description = "The parameters type."
}

output "parameters_version" {
  value       = [for p in aws_ssm_parameter.this : p.version]
  description = "The parameters version."
}

output "parameters_arn" {
  value       = [for p in aws_ssm_parameter.this : p.arn]
  description = "The parameters ARN."
}
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_parameters_config"></a> [parameters\_config](#input\_parameters\_config) | A list of parameters to create. Each element in the list must be a map with the following keys:<br>  name - (Required) It's used as an ID or Terrafrom identifier. It's not considered as part of the resource configuration.<br>  parameter\_path - (Required) The full path name of the parameter.<br>  parameter\_type - (Required) The type of the parameter. Valid values are String, StringList and SecureString.<br>  allowed\_pattern - (Optional) A regular expression used to validate the parameter value. For example, for String types with values restricted to numbers, you can specify the following: AllowedPattern=^\d+$<br>  data\_type - (Optional) The data type of the parameter, such as text or aws:ec2:image. The default value is text.<br>  description - (Optional) Information about the parameter that you want to add to the system. Important: You can't use the following symbols: equal sign (=), comma (,), colon (:), forward slash (/), square brackets ([]), curly braces ({}) at the start or end of the description. The description can't begin with a white space character.<br>  insecure\_value - (Optional) The parameter value that you want to add to the system. It's not considered as part of the resource configuration.<br>  key\_id - (Optional) The KMS Key ID that you want to use to encrypt a SecureString parameter. Either KeyId or KeyName must be specified.<br>  overwrite - (Optional) Overwrite an existing parameter. If not specified, will default to false.<br>  tier - (Optional) The tier of the parameter. Valid values are Standard and Advanced. Standard parameters have a content size limit of 4 KB and can't be configured to use parameter policies. You can create a maximum of 10,000 standard parameters for each Region in an AWS account. Standard parameters are offered at no additional cost. Advanced parameters have a content size limit of 8 KB and can be configured to use parameter policies. You can create a maximum of 100,000 advanced parameters for each Region in an AWS account. Advanced parameters incur a charge. For more information, see AWS Systems Manager Pricing.<br>  value - (Optional) The parameter value that you want to add to the system. It's not considered as part of the resource configuration. | <pre>list(object({<br>    name           = string<br>    parameter_path = string<br>    parameter_type = string<br>    // Optional set of parameters that can be passed.<br>    allowed_pattern = optional(string, null)<br>    data_type       = optional(string, null)<br>    description     = optional(string, null)<br>    insecure_value  = optional(string, null)<br>    key_id          = optional(string, null)<br>    overwrite       = optional(bool, null)<br>    tier            = optional(string, null)<br>    value           = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy"></a> [aws\_region\_for\_deploy](#output\_aws\_region\_for\_deploy) | The AWS region where the module is deployed. |
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_parameters_arn"></a> [parameters\_arn](#output\_parameters\_arn) | The parameters ARN. |
| <a name="output_parameters_normalised"></a> [parameters\_normalised](#output\_parameters\_normalised) | The parameters normalised. |
| <a name="output_parameters_path"></a> [parameters\_path](#output\_parameters\_path) | The parameters path or name. |
| <a name="output_parameters_type"></a> [parameters\_type](#output\_parameters\_type) | The parameters type. |
| <a name="output_parameters_value"></a> [parameters\_value](#output\_parameters\_value) | The actual parameters, or their values. |
| <a name="output_parameters_version"></a> [parameters\_version](#output\_parameters\_version) | The parameters version. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->