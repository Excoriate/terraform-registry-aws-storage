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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/secrets-manager-rotation | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |
| <a name="input_rotation_config"></a> [rotation\_config](#input\_rotation\_config) | This configuration allows you to set up a rotation for an existing secret.<br>Attributes:<br>- name: Friendly Terraform identifier used to create the rotation name.<br>- secret\_name: Name of the existing secret (optional). If not provided, 'name' will be used.<br>- secret\_arn: ARN of the existing secret (optional). If not provided, the ARN will be fetched using 'secret\_name'.<br>- enable\_default\_iam\_policy: If true, the module creates a default IAM policy for rotation.<br><br>Note: If 'secret\_arn' is provided, 'secret\_name' will be ignored. | <pre>list(object({<br>    name                      = string<br>    secret_name               = optional(string, null)<br>    secret_arn                = optional(string, null)<br>    enable_default_iam_policy = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_rotation_lambda_config"></a> [rotation\_lambda\_config](#input\_rotation\_lambda\_config) | This configuration allows you to set up a rotation for an existing secret using a Lambda function.<br>Attributes:<br>- name: Friendly Terraform identifier used to create the rotation name.<br>- secret\_name: Name of the existing secret (optional). If not provided, 'name' will be used.<br>- lambda\_arn: ARN of the Lambda function (optional). If not provided, the ARN will be fetched using 'lambda\_name'.<br>- lambda\_name: Name of the Lambda function (optional). If provided, it generates the necessary 'lambda\_permissions' for the secret to invoke the Lambda function.<br>- enable\_default\_lambda: If true, the module creates a default Lambda function for rotation.<br><br>Note: If 'lambda\_arn' is provided, 'lambda\_name' will be ignored. | <pre>list(object({<br>    name                  = string<br>    secret_name           = optional(string, null)<br>    lambda_arn            = optional(string, null)<br>    lambda_name           = optional(string, null)<br>    enable_default_lambda = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_rotation_rules_config"></a> [rotation\_rules\_config](#input\_rotation\_rules\_config) | This configuration allows you to set up rotation rules for an existing secret.<br>Attributes:<br>- name: Friendly Terraform identifier used to create the rotation name.<br>- secret\_name: Name of the existing secret (optional). If not provided, 'name' will be used.<br>- rotation\_duration: Number of days between automatic scheduled rotations of the secret (optional).<br>- rotation\_automatically\_after\_days: Number of days after the previous rotation when Secrets Manager triggers the next automatic rotation (optional).<br>- rotation\_by\_schedule\_expression: A cron expression that defines the schedule for the rotation (optional).<br><br>For more information, refer to the AWS documentation on rotation rules:<br>https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html | <pre>list(object({<br>    name                              = string<br>    secret_name                       = optional(string, null)<br>    rotation_duration                 = optional(number, null)<br>    rotation_automatically_after_days = optional(number, null)<br>    rotation_by_schedule_expression   = optional(string, null)<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_lookup_arn_secret_id"></a> [lookup\_arn\_secret\_id](#output\_lookup\_arn\_secret\_id) | The ID of the secret. |
| <a name="output_lookup_arn_secret_name"></a> [lookup\_arn\_secret\_name](#output\_lookup\_arn\_secret\_name) | The name of the secret. |
| <a name="output_lookup_name_secret_id"></a> [lookup\_name\_secret\_id](#output\_lookup\_name\_secret\_id) | The ID of the secret. |
| <a name="output_lookup_name_secret_name"></a> [lookup\_name\_secret\_name](#output\_lookup\_name\_secret\_name) | The name of the secret. |
| <a name="output_secret_rotation_default_policy_arn"></a> [secret\_rotation\_default\_policy\_arn](#output\_secret\_rotation\_default\_policy\_arn) | The default policy for the secret rotation. |
| <a name="output_secret_rotation_default_policy_doc"></a> [secret\_rotation\_default\_policy\_doc](#output\_secret\_rotation\_default\_policy\_doc) | The default policy document for the secret rotation. |
| <a name="output_secret_rotation_enabled"></a> [secret\_rotation\_enabled](#output\_secret\_rotation\_enabled) | Whether the rotation is enabled. |
| <a name="output_secret_rotation_id"></a> [secret\_rotation\_id](#output\_secret\_rotation\_id) | The ID of the secret rotation. |
<!-- END_TF_DOCS -->