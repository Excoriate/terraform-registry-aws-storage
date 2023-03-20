<!-- BEGIN_TF_DOCS -->
# ☁️ AWS Secrets Manager
## Description


This module simplifies the management of AWS Secrets Manager by creating a secret and integrating it with a Go application called "secret-manager-filler". The application is responsible for setting the actual value of the secret outside of Terraform, ensuring a secure and efficient secret handling process. The capabilities of this module correspond to the aws_secretsmanager_secret resource.
A summary of its main features:

🚀 Create a new AWS Secrets Manager secret.
🚀 Seamlessly integrate with the "secret-manager-filler" Go application to set secret values outside Terraform.
🚀 Utilize the aws_secretsmanager_secret resource for advanced secret management options.
🚀 Enhance security and management of sensitive data in your AWS environment.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source                     = "../../../modules/secrets-manager"
  is_enabled                 = var.is_enabled
  aws_region                 = var.aws_region
  secrets_config             = var.secrets_config
  secrets_replication_config = var.secrets_replication_config
  secrets_rotation_config    = var.secrets_rotation_config
  enforced_prefixes          = var.enforced_prefixes
}
```


Simple recipe:
```hcl
aws_region = "us-east-1"
is_enabled = true

secrets_config = [
  {
    name = "test"
    path = "my_secret/test"
  }
]
```

Multiple secrets created, each with custom configurations.
```hcl
aws_region = "us-east-1"
is_enabled = true

secrets_config = [
  {
    name = "test"
    path = "my_secret/test"
  },
  {
    name                    = "test2"
    path                    = "my_secret/test2"
    recovery_window_in_days = 7
  },
]
```
Multiple secrets, some of them with enforced prefixes (for their paths)
```hcl
aws_region = "us-east-1"
is_enabled = true

secrets_config = [
  {
    name = "test"
    path = "my_secret/test"
  },
  {
    name                    = "test2"
    path                    = "my_secret/test2"
    recovery_window_in_days = 7
  },
  {
    name                    = "test3"
    path                    = "my_secret/test3"
    recovery_window_in_days = 0
  },
]

enforced_prefixes = [{
  name   = "test3"
  prefix = "my_custom_prefix"
}]
```
Secrets with replication enabled
```hcl
aws_region = "us-east-1"
is_enabled = true

secrets_config = [
  {
    name = "test"
    path = "my_secret/test"
  },
  {
    name                    = "test2"
    path                    = "my_secret/test2"
    recovery_window_in_days = 7
  },
]

secrets_replication_config = [
  {
    region = "us-east-1"
    name   = "test2"
  }
]
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
output "secret_id" {
  value       = [for secret in aws_secretsmanager_secret.this : secret.id]
  description = "The ID of the secret."
}

output "secret_arn" {
  value       = [for secret in aws_secretsmanager_secret.this : secret.arn]
  description = "The ARN of the secret."
}

output "secret_name" {
  value       = [for secret in aws_secretsmanager_secret.this : secret.name]
  description = "The name of the secret."
}

output "secret_policy" {
  value       = [for secret in aws_secretsmanager_secret.this : secret.policy]
  description = "The policy of the secret."
}
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.59.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_enforced_prefixes"></a> [enforced\_prefixes](#input\_enforced\_prefixes) | A list of prefixes to enforce. If the list is empty, all prefixes are allowed.<br>E.g.: if the prefix set is 'service', then all the paths should start with service/custom-path/my-secret | <pre>list(object({<br>    name   = string<br>    prefix = string<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_secrets_config"></a> [secrets\_config](#input\_secrets\_config) | A list of objects with the following attributes:<br>  - path: the path where the secret will be stored<br>  - description: the description of the secret<br>  - policy: the policy to apply to the secret<br>  - kms\_key\_id: the KMS key to use for the secret. If not provided, the default KMS key for the region will be used.<br>  - recovery\_window\_in\_days: the number of days that the recovered secret can be accessed. If not provided, the default value of 30 days will be used.<br>For more details about this specific configuration, please visit the official AWS documentation at https://docs.aws.amazon.com/secretsmanager/latest/userguide/manage_delete-secret.html | <pre>list(object({<br>    name                    = string<br>    path                    = string<br>    description             = optional(string, null)<br>    policy                  = optional(string, null)<br>    kms_key_id              = optional(string, null)<br>    recovery_window_in_days = optional(number, 0)<br>  }))</pre> | `null` | no |
| <a name="input_secrets_replication_config"></a> [secrets\_replication\_config](#input\_secrets\_replication\_config) | A list of objects with the following attributes:<br>  - region: the region where the secret will be replicated<br>  - kms\_key\_id: the KMS key to use for the replication. If not provided, the default KMS key for the region will be used.<br>For more details about this specific configuration, please visit the official AWS documentation at https://docs.aws.amazon.com/secretsmanager/latest/userguide/replication.html | <pre>list(object({<br>    name       = string<br>    region     = string<br>    kms_key_id = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_secret_arn"></a> [secret\_arn](#output\_secret\_arn) | The ARN of the secret. |
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | The ID of the secret. |
| <a name="output_secret_name"></a> [secret\_name](#output\_secret\_name) | The name of the secret. |
| <a name="output_secret_policy"></a> [secret\_policy](#output\_secret\_policy) | The policy of the secret. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
