# AWS S3 Terraform module

## Description
This terraform module creates a single S3 Bucket with the option of adding other s3 bucket configurations.

Example available [here](https://github.com/boldlink/terraform-aws-s3/tree/main/examples)

## Documentation

[AWS S3 Bucket documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)

[Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_abort_incomplete_multipart_upload_days"></a> [abort\_incomplete\_multipart\_upload\_days](#input\_abort\_incomplete\_multipart\_upload\_days) | Specifies the number of days after initiating a multipart upload when the multipart upload must be completed. | `string` | `null` | no |
| <a name="input_acceleration_status"></a> [acceleration\_status](#input\_acceleration\_status) | Sets the accelerate configuration of an existing bucket. Can be `Enabled` or `Suspended` | `string` | `null` | no |
| <a name="input_acl"></a> [acl](#input\_acl) | The canned ACL to apply. Valid values are `private`, `public-read`, `public-read-write`, `aws-exec-read`, `authenticated-read`, and `log-delivery-write`. Defaults to private. Conflicts with `grant` | `string` | `null` | no |
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_cors_allowed_headers"></a> [cors\_allowed\_headers](#input\_cors\_allowed\_headers) | Specifies which headers are allowed. | `list(string)` | `[]` | no |
| <a name="input_cors_allowed_methods"></a> [cors\_allowed\_methods](#input\_cors\_allowed\_methods) | Specifies which methods are allowed. Can be `GET`, `PUT`, `POST`, `DELETE` or `HEAD` | `list(string)` | `[]` | no |
| <a name="input_cors_allowed_origins"></a> [cors\_allowed\_origins](#input\_cors\_allowed\_origins) | Specifies which origins are allowed. | `list(string)` | `[]` | no |
| <a name="input_cors_expose_headers"></a> [cors\_expose\_headers](#input\_cors\_expose\_headers) | Specifies expose header in the response. | `list(string)` | `[]` | no |
| <a name="input_cors_max_age_seconds"></a> [cors\_max\_age\_seconds](#input\_cors\_max\_age\_seconds) | Specifies time in seconds that browser can cache the response for a preflight request. | `number` | `null` | no |
| <a name="input_default_retention_days"></a> [default\_retention\_days](#input\_default\_retention\_days) | The number of days that you want to specify for the default retention period. | `number` | `null` | no |
| <a name="input_default_retention_mode"></a> [default\_retention\_mode](#input\_default\_retention\_mode) | The default Object Lock retention mode you want to apply to new objects placed in this bucket. Valid values are `GOVERNANCE` and `COMPLIANCE` | `string` | `null` | no |
| <a name="input_default_retention_years"></a> [default\_retention\_years](#input\_default\_retention\_years) | The number of years that you want to specify for the default retention period. | `number` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment this resource is belongs to | `string` | `null` | no |
| <a name="input_expiration_date"></a> [expiration\_date](#input\_expiration\_date) | Specifies the date after which you want the corresponding action to take effect. | `string` | `null` | no |
| <a name="input_expiration_days"></a> [expiration\_days](#input\_expiration\_days) | Specifies the number of days after object creation when the specific rule action takes effect. | `number` | `null` | no |
| <a name="input_expiration_expired_object_delete_marker"></a> [expiration\_expired\_object\_delete\_marker](#input\_expiration\_expired\_object\_delete\_marker) | On a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Amazon S3 to delete expired object delete markers. This cannot be specified with Days or Date in a Lifecycle Expiration Policy. | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Default:`false`. A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `"false"` | no |
| <a name="input_grant_id"></a> [grant\_id](#input\_grant\_id) | Canonical user id to grant for. Used only when type is `CanonicalUser`. | `string` | `null` | no |
| <a name="input_grant_permissions"></a> [grant\_permissions](#input\_grant\_permissions) | List of permissions to apply for grantee. Valid values are `READ`, `WRITE`, `READ_ACP`, `WRITE_ACP`, `FULL_CONTROL`. | `list(string)` | `null` | no |
| <a name="input_grant_type"></a> [grant\_type](#input\_grant\_type) | Type of grantee to apply for. Valid values are `CanonicalUser` and `Group`. `AmazonCustomerByEmail` is not supported. | `string` | `null` | no |
| <a name="input_grant_uri"></a> [grant\_uri](#input\_grant\_uri) | Uri address to grant for. Used only when `type` is `Group`. | `string` | `null` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_lifecycle_rule_enabled"></a> [lifecycle\_rule\_enabled](#input\_lifecycle\_rule\_enabled) | Specifies lifecycle rule status. | `bool` | `null` | no |
| <a name="input_lifecycle_rule_id"></a> [lifecycle\_rule\_id](#input\_lifecycle\_rule\_id) | Unique identifier for the rule. Must be less than or equal to 255 characters in length. | `string` | `null` | no |
| <a name="input_lifecycle_rule_prefix"></a> [lifecycle\_rule\_prefix](#input\_lifecycle\_rule\_prefix) | Object key prefix identifying one or more objects to which the rule applies. | `string` | `null` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | Bucket access logging configuration. | <pre>object({<br>    logging_target_bucket = string<br>    logging_target_prefix = string<br>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the bucket. | `string` | `null` | no |
| <a name="input_noncurrent_version_expiration_days"></a> [noncurrent\_version\_expiration\_days](#input\_noncurrent\_version\_expiration\_days) | Specifies the number of days noncurrent object versions expire. | `number` | `null` | no |
| <a name="input_noncurrent_version_transition_days"></a> [noncurrent\_version\_transition\_days](#input\_noncurrent\_version\_transition\_days) | Specifies the number of days noncurrent object versions transition. | `number` | `null` | no |
| <a name="input_noncurrent_version_transition_storage_class"></a> [noncurrent\_version\_transition\_storage\_class](#input\_noncurrent\_version\_transition\_storage\_class) | Specifies the Amazon S3 storage class to which you want the object to transition. | `string` | `null` | no |
| <a name="input_object_lock_enabled"></a> [object\_lock\_enabled](#input\_object\_lock\_enabled) | Indicates whether this bucket has an Object Lock configuration enabled. Valid value is `Enabled`. | `string` | `null` | no |
| <a name="input_other_tags"></a> [other\_tags](#input\_other\_tags) | For adding an additional values for tags | `map(string)` | `{}` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | The bucket policy for resource access filtering | `string` | `null` | no |
| <a name="input_request_payer"></a> [request\_payer](#input\_request\_payer) | Specifies who should bear the cost of Amazon S3 data transfer. Can be either `BucketOwner` or `Requester`. By default, the owner of the S3 bucket would incur the costs of any data transfer. | `string` | `null` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_sse_algorithm"></a> [sse\_algorithm](#input\_sse\_algorithm) | The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms` | `string` | `null` | no |
| <a name="input_sse_bucket_key_enabled"></a> [sse\_bucket\_key\_enabled](#input\_sse\_bucket\_key\_enabled) | Choose whether or not to use Amazon S3 Bucket Keys for SSE-KMS. | `bool` | `null` | no |
| <a name="input_sse_kms_master_key_id"></a> [sse\_kms\_master\_key\_id](#input\_sse\_kms\_master\_key\_id) | The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as `aws:kms`. The default `aws/s3` AWS KMS master key is used if this element is absent while the sse\_algorithm is `aws:kms.` | `any` | `null` | no |
| <a name="input_transition_date"></a> [transition\_date](#input\_transition\_date) | Specifies the date after which you want the corresponding action to take effect. | `string` | `null` | no |
| <a name="input_transition_days"></a> [transition\_days](#input\_transition\_days) | Specifies the number of days after object creation when the specific rule action takes effect. | `string` | `null` | no |
| <a name="input_transition_storage_class"></a> [transition\_storage\_class](#input\_transition\_storage\_class) | Specifies the Amazon S3 storage class to which you want the object to transition. | `string` | `null` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket. | `bool` | `false` | no |
| <a name="input_versioning_mfa_delete"></a> [versioning\_mfa\_delete](#input\_versioning\_mfa\_delete) | Enable MFA delete for either `Change the versioning state of your bucket` or `Permanently delete an object version`. Default is `false` | `bool` | `false` | no |
| <a name="input_website_error_document"></a> [website\_error\_document](#input\_website\_error\_document) | An absolute path to the document to return in case of a 4XX error. | `string` | `null` | no |
| <a name="input_website_index_document"></a> [website\_index\_document](#input\_website\_index\_document) | (Required, unless using redirect\_all\_requests\_to) Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders. | `string` | `null` | no |
| <a name="input_website_redirect_all_requests_to"></a> [website\_redirect\_all\_requests\_to](#input\_website\_redirect\_all\_requests\_to) | A hostname to redirect all website requests for this bucket to. Hostname can optionally be prefixed with a protocol (`http:// or https://`) to use when redirecting requests. The default is the protocol that is used in the original request. | `string` | `null` | no |
| <a name="input_website_routing_rules"></a> [website\_routing\_rules](#input\_website\_routing\_rules) | A json array containing routing rules describing redirect behavior and when redirects are applied. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_arn"></a> [s3\_arn](#output\_s3\_arn) | The ARN of the bucket. Will be of format `arn:aws:s3:::bucketname` |
| <a name="output_s3_bucket_domain_name"></a> [s3\_bucket\_domain\_name](#output\_s3\_bucket\_domain\_name) | The bucket domain name. Will be of format `bucketname.s3.amazonaws.com`. |
| <a name="output_s3_bucket_regional_domain_name"></a> [s3\_bucket\_regional\_domain\_name](#output\_s3\_bucket\_regional\_domain\_name) | The bucket region-specific domain name. The bucket domain name including the region name |
| <a name="output_s3_hosted_zone_id"></a> [s3\_hosted\_zone\_id](#output\_s3\_hosted\_zone\_id) | The Route 53 Hosted Zone ID for this bucket's region. |
| <a name="output_s3_id"></a> [s3\_id](#output\_s3\_id) | The name of the bucket. |
| <a name="output_s3_region"></a> [s3\_region](#output\_s3\_region) | The AWS region this bucket resides in. |
| <a name="output_s3_tags_all"></a> [s3\_tags\_all](#output\_s3\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags |
| <a name="output_s3_website_domain"></a> [s3\_website\_domain](#output\_s3\_website\_domain) | The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records. |
| <a name="output_s3_website_endpoint"></a> [s3\_website\_endpoint](#output\_s3\_website\_endpoint) | The website endpoint, if the bucket is configured with a website. If not, this will be an empty string |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
