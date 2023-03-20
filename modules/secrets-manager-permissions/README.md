<!-- BEGIN_TF_DOCS -->
# ☁️ AWS Secrets Manager Permissions
## Description


This module sets IAM Policies, and optionally IAM roles attachments to specific roles in order to grant several permissions (E.g.: read a secret) to a specific service, or component.
A summary of its main features:
🚀 Create an IAM policy, based on a looked up AWS secret.
🚀 Create optionally an attachment, if there's an IAM role that's passed.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source             = "../../../modules/secrets-manager-permissions"
  is_enabled         = var.is_enabled
  aws_region         = var.aws_region
  secret_permissions = var.secret_permissions
}
```


Simple recipe:
```hcl
aws_region = "us-east-1"
is_enabled = true

secret_permissions = [
  {
    name        = "test1"
    secret_name = "test/terraform"
  }
]
```
In this example, more elaborate permissions are granted
```hcl
aws_region = "us-east-1"
is_enabled = true

secret_permissions = [
  {
    name        = "test1"
    secret_name = "test/terraform"
    permissions = ["GetSecretValue", "DescribeSecret", "PutSecretValue"]
  }
]
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
| [aws_iam_policy.allow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.deny](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.allow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.deny](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |

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
| <a name="input_secret_permissions"></a> [secret\_permissions](#input\_secret\_permissions) | Configure a set of permissions for an AWS secrets manager secret. If the 'iam\_role\_to\_attach' is not provided, no<br>attachment (IAM policy attachment) will be created, and just the IAM policy will be generated. If it's provided,<br>the IAM policy will be attached to the IAM role.<br>The attributes are:<br>- name: Terraform friendly-name, which is used just to internal computations.<br>- secret\_name: The name of the AWS secrets manager secret.<br>- permissions (optional): A list of permissions to be granted to the IAM role. If not provided, the default permissions will be used [*].<br>- allow (optional): Whether to allow the permissions or not. Default is true.<br>- deny (optional): Whether to deny the permissions or not. Default is false.<br>- iam\_role\_name (optional): The name of the IAM role to attach the IAM policy to. If not provided, no attachment will be created.<br>- iam\_role\_arn (optional): The ARN of the IAM role to attach the IAM policy to. If not provided, no attachment will be created. | <pre>list(object({<br>    name          = string<br>    secret_name   = string<br>    permissions   = optional(list(string), null)<br>    allow         = optional(bool, true)<br>    deny          = optional(bool, false)<br>    iam_role_name = optional(string, "NOT_SET")<br>    iam_role_arn  = optional(string, "NOT_SET")<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
