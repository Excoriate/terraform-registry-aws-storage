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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../../modules/s3/s3-storage | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_bucket_config"></a> [bucket\_config](#input\_bucket\_config) | A list of objects that contains the configuration of the buckets to be created. The following attributes<br>are currently supported:<br>- name: A terraform identifier. It shouldn't be used for naming this resource. However, if the 'bucket\_name'<br>attribute is not set, it'll be used as the bucket name.<br>- bucket\_name: The name of the bucket. If it's not set, the 'name' attribute will be used.<br>- force\_destroy: A boolean that indicates if the bucket can be destroyed even if it contains objects<br>- object\_lock\_enabled: A boolean that indicates if the bucket will have object lock enabled.<br>For a more detailed documentation about this resource, please refer to the following link:<br>https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket | <pre>list(object({<br>    name                = string<br>    bucket_name         = optional(string, null) // If it's set in null, it'll take the 'name' value.<br>    force_destroy       = optional(bool, false)<br>    object_lock_enabled = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_bucket_options"></a> [bucket\_options](#input\_bucket\_options) | A list of objects that contains optional configurations for the buckets. The following attributes<br>are currently supported:<br>- name: A terraform identifier. It shouldn't be used for naming this resource.<br>- enable\_transfer\_acceleration: A boolean that indicates if the bucket will have transfer acceleration enabled.<br>- enable\_versioning: A boolean that indicates if the bucket will have versioning enabled.<br>- enable\_default\_server\_side\_encryption: A boolean that indicates if the bucket will have default server side encryption enabled.<br>For a more detailed documentation about this resource, please refer to the following link:<br>https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket | <pre>list(object({<br>    name                                  = string<br>    enable_transfer_acceleration          = optional(bool, false)<br>    enable_versioning                     = optional(bool, false)<br>    enable_default_server_side_encryption = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_bucket_permissions"></a> [bucket\_permissions](#input\_bucket\_permissions) | A list of objects to configure specific permissions for one or many buckets. The following attributes<br>are currently supported:<br>- name: A terraform identifier. It shouldn't be used for naming this resource.<br>- enable\_encrypted\_uploads\_only: A boolean that indicates if the bucket will have encrypted uploads only enabled.<br>- enable\_ssl\_requests\_only: A boolean that indicates if the bucket will have SSL requests only enabled.<br>- iam\_policy\_documents\_to\_attach: A list of IAM policy documents to attach to the bucket. Each policy document<br>in JSON format. | <pre>list(object({<br>    name                          = string<br>    enable_encrypted_uploads_only = optional(bool, false)<br>    enable_ssl_requests_only      = optional(bool, false)<br>    iam_policy_documents_to_attach = optional(list(object({<br>      sid     = string<br>      effect  = string<br>      actions = list(string)<br>      principals = optional(list(object({<br>        type        = string<br>        identifiers = list(string)<br>      })), [])<br>      conditions = optional(list(object({<br>        test     = string<br>        variable = string<br>        values   = list(string)<br>      })), [])<br>    })), [])<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy"></a> [aws\_region\_for\_deploy](#output\_aws\_region\_for\_deploy) | The AWS region where the module is deployed. |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the S3 bucket. |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The bucket domain name. |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The ID of the S3 bucket. |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | The bucket region domain name. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
<!-- END_TF_DOCS -->
