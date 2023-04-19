<!-- BEGIN_TF_DOCS -->
# ☁️ AWS Secrets Manager Rotation module
## Description


This module create the rotation configuration for a secret.
A summary of its main features:
🚀 Create the rotation configuration, with specific rules for the rotation lambda.
🚀 Create the lambda permissions required for the lambda function to perform rotation actions on the target secret.
🚀 Create an optional IAM (resource-based) policy that can be attached to the rotation lambda.

It do not create the rotation lambda. It is up to you to create it, and to grant the proper permissions to the secret.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source                 = "../../../modules/secrets-manager-rotation"
  is_enabled             = var.is_enabled
  aws_region             = var.aws_region
  rotation_config        = var.rotation_config
  rotation_lambda_config = var.rotation_lambda_config
  rotation_rules_config  = var.rotation_rules_config

}

// Create a fake secret, to be used as part of this module's tests.
#resource "random_string" "secret_value" {
#  length  = 16
#  special = false
#}
#
#resource "aws_secretsmanager_secret" "example_secret" {
#  name                    = "test-secret-rotation-1"
#  recovery_window_in_days = 0
#}
#
#resource "aws_secretsmanager_secret_version" "example_secret_version" {
#  secret_id     = aws_secretsmanager_secret.example_secret.id
#  secret_string = random_string.secret_value.result
#}
```

Simple recipe:
```hcl
aws_region = "us-east-1"
is_enabled = true

rotation_config = [
  {
    name        = "test-secret-1"
    secret_name = "test/terraform"
  }
]
```

In this example, a simple rotation configuration is required for a single (existing) secret
```hcl
aws_region = "us-east-1"
is_enabled = true

rotation_config = [
  {
    name        = "test-secret-1"
    secret_name = "test/terraform"
  }
]

rotation_lambda_config = [
  {
    name       = "test-secret-1"
    lambda_arn = "arn:aws:lambda:us-east-1:123456789012:function:my-function"
  }
]

rotation_rules_config = [
  {
    name                              = "test-secret-1"
    rotation_automatically_after_days = 1
  }
]
```

In this example, multiple secret rotation configurations are passed.
```hcl
aws_region = "us-east-1"
is_enabled = true

rotation_config = [
  {
    name        = "test-secret-1"
    secret_name = "test/terraform"
  },
  {
    name        = "test-secret-2"
    secret_name = "tes/terraform/other"
  }
]

rotation_lambda_config = [
  {
    name       = "test-secret-1"
    lambda_arn = "arn:aws:lambda:us-east-1:123456789012:function:my-function"
  },
  {
    name       = "test-secret-2"
    lambda_arn = "arn:aws:lambda:us-east-1:123456789012:function:my-function"
  }
]

rotation_rules_config = [
  {
    name                              = "test-secret-1"
    rotation_automatically_after_days = 1
  },
  {
    name                            = "test-secret-2"
    rotation_by_schedule_expression = "cron(0 12 * * ? *)"
  }
]
```

---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_lambda_permission.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_secretsmanager_secret_rotation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_lambda_function.rotation_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lambda_function) | data source |
| [aws_secretsmanager_secret.lookup_by_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.lookup_by_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_rotation_config"></a> [rotation\_config](#input\_rotation\_config) | This configuration allows you to set up a rotation for an existing secret.<br>Attributes:<br>- name: Friendly Terraform identifier used to create the rotation name.<br>- secret\_name: Name of the existing secret (optional). If not provided, 'name' will be used.<br>- secret\_arn: ARN of the existing secret (optional). If not provided, the ARN will be fetched using 'secret\_name'.<br>- enable\_default\_iam\_policy: If true, the module creates a default IAM policy for rotation.<br><br>Note: If 'secret\_arn' is provided, 'secret\_name' will be ignored. | <pre>list(object({<br>    name                      = string<br>    secret_name               = optional(string, null)<br>    secret_arn                = optional(string, null)<br>    enable_default_iam_policy = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_rotation_lambda_config"></a> [rotation\_lambda\_config](#input\_rotation\_lambda\_config) | This configuration allows you to set up a rotation for an existing secret using a Lambda function.<br>Attributes:<br>- name: Friendly Terraform identifier used to create the rotation name.<br>- secret\_name: Name of the existing secret (optional). If not provided, 'name' will be used.<br>- lambda\_arn: ARN of the Lambda function (optional). If not provided, the ARN will be fetched using 'lambda\_name'.<br>- lambda\_name: Name of the Lambda function (optional). If provided, it generates the necessary 'lambda\_permissions' for the secret to invoke the Lambda function.<br>- enable\_default\_lambda: If true, the module creates a default Lambda function for rotation.<br><br>Note: If 'lambda\_arn' is provided, 'lambda\_name' will be ignored. | <pre>list(object({<br>    name                  = string<br>    secret_name           = optional(string, null)<br>    lambda_arn            = optional(string, null)<br>    lambda_name           = optional(string, null)<br>    enable_default_lambda = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_rotation_rules_config"></a> [rotation\_rules\_config](#input\_rotation\_rules\_config) | This configuration allows you to set up rotation rules for an existing secret.<br>Attributes:<br>- name: Friendly Terraform identifier used to create the rotation name.<br>- secret\_name: Name of the existing secret (optional). If not provided, 'name' will be used.<br>- rotation\_duration: Number of days between automatic scheduled rotations of the secret (optional).<br>- rotation\_automatically\_after\_days: Number of days after the previous rotation when Secrets Manager triggers the next automatic rotation (optional).<br>- rotation\_by\_schedule\_expression: A cron expression that defines the schedule for the rotation (optional).<br><br>For more information, refer to the AWS documentation on rotation rules:<br>https://docs.aws.amazon.com/secretsmanager/latest/userguide/rotating-secrets.html | <pre>list(object({<br>    name                              = string<br>    secret_name                       = optional(string, null)<br>    rotation_duration                 = optional(number, null)<br>    rotation_automatically_after_days = optional(number, null)<br>    rotation_by_schedule_expression   = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_lookup_arn_secret_id"></a> [lookup\_arn\_secret\_id](#output\_lookup\_arn\_secret\_id) | The ID of the secret. |
| <a name="output_lookup_arn_secret_name"></a> [lookup\_arn\_secret\_name](#output\_lookup\_arn\_secret\_name) | The name of the secret. |
| <a name="output_lookup_name_secret_id"></a> [lookup\_name\_secret\_id](#output\_lookup\_name\_secret\_id) | The ID of the secret. |
| <a name="output_lookup_name_secret_name"></a> [lookup\_name\_secret\_name](#output\_lookup\_name\_secret\_name) | The name of the secret. |
| <a name="output_secret_rotation_default_policy_arn"></a> [secret\_rotation\_default\_policy\_arn](#output\_secret\_rotation\_default\_policy\_arn) | The default policy for the secret rotation. |
| <a name="output_secret_rotation_default_policy_doc"></a> [secret\_rotation\_default\_policy\_doc](#output\_secret\_rotation\_default\_policy\_doc) | The default policy document for the secret rotation. |
| <a name="output_secret_rotation_enabled"></a> [secret\_rotation\_enabled](#output\_secret\_rotation\_enabled) | Whether the rotation is enabled. |
| <a name="output_secret_rotation_id"></a> [secret\_rotation\_id](#output\_secret\_rotation\_id) | The ID of the secret rotation. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->