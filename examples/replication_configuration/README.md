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

# Terraform module example showing replication configuration usage


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.31.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_destination_bucket"></a> [destination\_bucket](#module\_destination\_bucket) | ../../ | n/a |
| <a name="module_destination_kms_key"></a> [destination\_kms\_key](#module\_destination\_kms\_key) | boldlink/kms/aws | n/a |
| <a name="module_replication_role"></a> [replication\_role](#module\_replication\_role) | boldlink/iam-role/aws | n/a |
| <a name="module_source_bucket"></a> [source\_bucket](#module\_source\_bucket) | ../../ | n/a |
| <a name="module_source_kms_key"></a> [source\_kms\_key](#module\_source\_kms\_key) | boldlink/kms/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.bucket](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_bucket"></a> [destination\_bucket](#input\_destination\_bucket) | The name of the destination bucket | `string` | `"replication-example-dest-bucket"` | no |
| <a name="input_source_bucket"></a> [source\_bucket](#input\_source\_bucket) | The name of the source bucket | `string` | `"replication-example-src-bucket"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the resources | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "example",<br>  "InstanceScheduler": true,<br>  "LayerId": "cExample",<br>  "LayerName": "cExample",<br>  "Owner": "Boldlink",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform"<br>}</pre> | no |

## Outputs

No outputs.
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

#### BOLDLink-SIG 2024
