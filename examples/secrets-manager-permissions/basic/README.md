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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/secrets-manager-permissions | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |
| <a name="input_secret_permissions"></a> [secret\_permissions](#input\_secret\_permissions) | Configure a set of permissions for an AWS secrets manager secret. If the 'iam\_role\_to\_attach' is not provided, no<br>attachment (IAM policy attachment) will be created, and just the IAM policy will be generated. If it's provided,<br>the IAM policy will be attached to the IAM role.<br>The attributes are:<br>- name: Terraform friendly-name, which is used just to internal computations.<br>- secret\_name: The name of the AWS secrets manager secret.<br>- permissions (optional): A list of permissions to be granted to the IAM role. If not provided, the default permissions will be used [*].<br>- allow (optional): Whether to allow the permissions or not. Default is true.<br>- deny (optional): Whether to deny the permissions or not. Default is false.<br>- iam\_role\_name (optional): The name of the IAM role to attach the IAM policy to. If not provided, no attachment will be created.<br>- iam\_role\_arn (optional): The ARN of the IAM role to attach the IAM policy to. If not provided, no attachment will be created. | <pre>list(object({<br>    name          = string<br>    secret_name   = string<br>    permissions   = optional(list(string), null)<br>    allow         = optional(bool, true)<br>    deny          = optional(bool, false)<br>    iam_role_name = optional(string, "NOT_SET")<br>    iam_role_arn  = optional(string, "NOT_SET")<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy_allow_arn"></a> [iam\_policy\_allow\_arn](#output\_iam\_policy\_allow\_arn) | The secret IAM policy when the 'allow' option is enabled |
| <a name="output_iam_policy_allow_id"></a> [iam\_policy\_allow\_id](#output\_iam\_policy\_allow\_id) | The secret IAM policy when the 'allow' option is enabled |
| <a name="output_iam_policy_allow_name"></a> [iam\_policy\_allow\_name](#output\_iam\_policy\_allow\_name) | The secret IAM policy when the 'allow' option is enabled |
| <a name="output_iam_policy_deny_arn"></a> [iam\_policy\_deny\_arn](#output\_iam\_policy\_deny\_arn) | The secret IAM policy when the 'deny' option is enabled |
| <a name="output_iam_policy_deny_id"></a> [iam\_policy\_deny\_id](#output\_iam\_policy\_deny\_id) | The secret IAM policy when the 'deny' option is enabled |
| <a name="output_iam_policy_deny_name"></a> [iam\_policy\_deny\_name](#output\_iam\_policy\_deny\_name) | The secret IAM policy when the 'deny' option is enabled |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
<!-- END_TF_DOCS -->
