[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-s3/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-s3.svg)](https://github.com/boldlink/terraform-aws-s3/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-s3/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-s3/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-s3/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-s3/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-s3/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-s3/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-s3/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-s3/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-s3/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-s3/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-s3/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-s3/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-s3/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-s3/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-s3/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-s3/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# AWS S3 Terraform module

## Description
This terraform module creates an S3 Bucket with the options of adding other s3 bucket configurations.

### Reasons to Use this Module over Stand Alone Resources
- This module offers simplicity through detailed examples, making it user-friendly.
- It follows AWS security best practices by utilizing checkov to ensure compliance.
- It simplifies the process of setting up s3 bucket with the desired configurations
- The module provides support for lifecycle configuration.
- In response to a recent AWS S3 update, this module now includes ownership control, allowing users to specify ownership types. The default is `ObjectWriter`
- Encryption is enabled by default, allowing users to utilize existing AWS Customer Master Keys (CMKs) or create new ones using the module. Additionally, it supports Server-Side Encryption (SSE).
- It includes support for S3 bucket notifications, enabling users to set up event-driven workflows.
- Supports versioning which is in this module disabled by default, providing automatic version control.

Examples available [here](./examples)

## Usage
**Points to NOTE**:
- These examples use the latest version of this module
- This module has encryption enabled by default, therefore when replicating buckets to other buckets the associated replication role must have `encryption` and `decryption` permissions enabled for both the source bucket kms key and the destination bucket kms key
- All public access in blocked by default in this module
- When replicating to encrypted buckets in another account, the kms policy in the destination account must enable required kms permissions for the principle(s)/role in the source/origin account. The destination bucket policy should also allow S3 Replication permissions from the source bucket.

```hcl
locals {
  name = "minimum-example-bucket"
}

module "minimum" {
  source  = "boldlink/s3/aws"
  version = "<latest_module_version>"
  bucket  = local.name
  tags    = local.tags
}
```

## Documentation

[AWS S3 Bucket documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)

[Terraform provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.15.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_cors_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_notification.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification) | resource |
| [aws_s3_bucket_ownership_controls.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_replication_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_public_acls"></a> [block\_public\_acls](#input\_block\_public\_acls) | (Optional) Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_block_public_policy"></a> [block\_public\_policy](#input\_block\_public\_policy) | (Optional) Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | (Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length. | `string` | `null` | no |
| <a name="input_bucket_acl"></a> [bucket\_acl](#input\_bucket\_acl) | The canned ACL to apply. | `any` | `{}` | no |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | Attaches a policy to an S3 bucket resource. | `string` | `null` | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be lowercase and less than or equal to 37 characters in length. | `string` | `null` | no |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | A rule of Cross-Origin Resource Sharing. | `any` | `[]` | no |
| <a name="input_eventbridge"></a> [eventbridge](#input\_eventbridge) | Whether to enable Amazon EventBridge notifications | `bool` | `false` | no |
| <a name="input_expected_bucket_owner"></a> [expected\_bucket\_owner](#input\_expected\_bucket\_owner) | (Optional, Forces new resource) The account ID of the expected bucket owner. | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_ignore_public_acls"></a> [ignore\_public\_acls](#input\_ignore\_public\_acls) | (Optional) Whether Amazon S3 should ignore public ACLs for this bucket. | `bool` | `true` | no |
| <a name="input_lambda_function"></a> [lambda\_function](#input\_lambda\_function) | Configuration for S3 notification lambda function | `any` | `[]` | no |
| <a name="input_lifecycle_configuration"></a> [lifecycle\_configuration](#input\_lifecycle\_configuration) | A map of s3 lifecycle configuration | `any` | `[]` | no |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | Object ownership. Valid values: `BucketOwnerPreferred`, `ObjectWriter` or `BucketOwnerEnforced` | `string` | `"ObjectWriter"` | no |
| <a name="input_queue"></a> [queue](#input\_queue) | Configuration for S3 notification SQS queue | `any` | `[]` | no |
| <a name="input_replication_configuration"></a> [replication\_configuration](#input\_replication\_configuration) | Provides an independent configuration resource for S3 bucket replication configuration. | `any` | `{}` | no |
| <a name="input_restrict_public_buckets"></a> [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | (Optional) Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `true` | no |
| <a name="input_s3_logging"></a> [s3\_logging](#input\_s3\_logging) | A map of configurations where to store logs | `map(any)` | `{}` | no |
| <a name="input_sse_bucket_key_enabled"></a> [sse\_bucket\_key\_enabled](#input\_sse\_bucket\_key\_enabled) | (Optional) Whether or not to use Amazon S3 Bucket Keys for SSE-KMS. | `bool` | `null` | no |
| <a name="input_sse_kms_master_key_arn"></a> [sse\_kms\_master\_key\_arn](#input\_sse\_kms\_master\_key\_arn) | (Optional) The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse\_algorithm as `aws:kms`. The default `aws/s3` AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms`. | `string` | `null` | no |
| <a name="input_sse_sse_algorithm"></a> [sse\_sse\_algorithm](#input\_sse\_sse\_algorithm) | (Required) The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms` | `string` | `"aws:kms"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the bucket. | `map(string)` | `{}` | no |
| <a name="input_topic"></a> [topic](#input\_topic) | Configuration for S3 notification SNS topic | `any` | `[]` | no |
| <a name="input_versioning_mfa"></a> [versioning\_mfa](#input\_versioning\_mfa) | The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device. | `string` | `null` | no |
| <a name="input_versioning_mfa_delete"></a> [versioning\_mfa\_delete](#input\_versioning\_mfa\_delete) | (Optional) Specifies whether MFA delete is enabled in the bucket versioning configuration. Valid values: `Enabled` or `Disabled`. | `string` | `null` | no |
| <a name="input_versioning_status"></a> [versioning\_status](#input\_versioning\_status) | (Required) The versioning state of the bucket. Valid values: `Enabled`, `Suspended`, or `Disabled`. Disabled should only be used when creating or importing resources that correspond to unversioned S3 buckets. | `string` | `"Disabled"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the bucket. Will be of format `arn:aws:s3:::bucketname` |
| <a name="output_bucket"></a> [bucket](#output\_bucket) | The name of the bucket. |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The bucket domain name. Will be of format `bucketname.s3.amazonaws.com`. |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | The bucket region-specific domain name. The bucket domain name including the region name |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | The Route 53 Hosted Zone ID for this bucket's region. |
| <a name="output_id"></a> [id](#output\_id) | The name of the bucket. |
| <a name="output_region"></a> [region](#output\_region) | The AWS region this bucket resides in. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

### Makefile
The makefile contained in this repo is optimized for linux paths and the main purpose is to execute testing for now.
* Create all tests stacks including any supporting resources:
```console
make tests
```
* Clean all tests *except* existing supporting resources:
```console
make clean
```
* Clean supporting resources - this is done separately so you can test your module build/modify/destroy independently.
```console
make cleansupporting
```
* !!!DANGER!!! Clean the state files from examples and test/supportingResources - use with CAUTION!!!
```console
make cleanstatefiles
```

#### BOLDLink-SIG 2023
