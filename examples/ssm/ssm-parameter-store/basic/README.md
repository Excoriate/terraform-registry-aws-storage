<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../../modules/ssm/ssm-parameter-store | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |
| <a name="input_parameters_config"></a> [parameters\_config](#input\_parameters\_config) | A list of parameters to create. Each element in the list must be a map with the following keys:<br>  name - (Required) It's used as an ID or Terrafrom identifier. It's not considered as part of the resource configuration.<br>  parameter\_path - (Required) The full path name of the parameter.<br>  parameter\_type - (Required) The type of the parameter. Valid values are String, StringList and SecureString.<br>  allowed\_pattern - (Optional) A regular expression used to validate the parameter value. For example, for String types with values restricted to numbers, you can specify the following: AllowedPattern=^\d+$<br>  data\_type - (Optional) The data type of the parameter, such as text or aws:ec2:image. The default value is text.<br>  description - (Optional) Information about the parameter that you want to add to the system. Important: You can't use the following symbols: equal sign (=), comma (,), colon (:), forward slash (/), square brackets ([]), curly braces ({}) at the start or end of the description. The description can't begin with a white space character.<br>  insecure\_value - (Optional) The parameter value that you want to add to the system. It's not considered as part of the resource configuration.<br>  key\_id - (Optional) The KMS Key ID that you want to use to encrypt a SecureString parameter. Either KeyId or KeyName must be specified.<br>  overwrite - (Optional) Overwrite an existing parameter. If not specified, will default to false.<br>  tier - (Optional) The tier of the parameter. Valid values are Standard and Advanced. Standard parameters have a content size limit of 4 KB and can't be configured to use parameter policies. You can create a maximum of 10,000 standard parameters for each Region in an AWS account. Standard parameters are offered at no additional cost. Advanced parameters have a content size limit of 8 KB and can be configured to use parameter policies. You can create a maximum of 100,000 advanced parameters for each Region in an AWS account. Advanced parameters incur a charge. For more information, see AWS Systems Manager Pricing.<br>  value - (Optional) The parameter value that you want to add to the system. It's not considered as part of the resource configuration. | <pre>list(object({<br>    name           = string<br>    parameter_path = string<br>    parameter_type = string<br>    // Optional set of parameters that can be passed.<br>    allowed_pattern = optional(string, null)<br>    data_type       = optional(string, null)<br>    description     = optional(string, null)<br>    insecure_value  = optional(string, null)<br>    key_id          = optional(string, null)<br>    overwrite       = optional(bool, null)<br>    tier            = optional(string, null)<br>    value           = optional(string, null)<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy"></a> [aws\_region\_for\_deploy](#output\_aws\_region\_for\_deploy) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_parameters_arn"></a> [parameters\_arn](#output\_parameters\_arn) | The parameters ARN. |
| <a name="output_parameters_normalised"></a> [parameters\_normalised](#output\_parameters\_normalised) | The parameters normalised. |
| <a name="output_parameters_path"></a> [parameters\_path](#output\_parameters\_path) | The parameters path or name. |
| <a name="output_parameters_type"></a> [parameters\_type](#output\_parameters\_type) | The parameters type. |
| <a name="output_parameters_value"></a> [parameters\_value](#output\_parameters\_value) | The actual parameters, or their values. |
| <a name="output_parameters_version"></a> [parameters\_version](#output\_parameters\_version) | The parameters version. |
<!-- END_TF_DOCS -->
