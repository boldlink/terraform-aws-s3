# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- fix: replication example is broken, possible issue with the configurations or change on the aws provider
- fix: replication configuration showing drift detection when filter is used, even when values are unchanged
- fix: CKV_AWS_300 #Ensure S3 lifecycle configuration sets period for aborting failed uploads
- fix: CKV2_AWS_65: #Ensure access control lists for S3 buckets are disabled
- feat: show notification usage in complete example after fixing the notification error
- feat: Document on README needed permissions and steps to replicate encrypted bucket objects
- feat: Acceleration Configuration
- feat: Object Lock Configuration
- feat: Request Payment Configuration
- feat: Website Configuration
- feat: Analytics configuration
- feat: Intelligent Tiering Configuration
- feat: Bucket Inventory
- feat: Bucket Metric
- feat: S3 Object Copy
- feat: S3 Object
- fix: CKV_TF_1 Ensure Terraform module sources use a commit hash
- fix: CKV2_AWS_67 Ensure AWS S3 bucket encrypted with Customer Managed Key (CMK) has regular rotation

## [2.6.0] - 2025-07-20
- feat: make encryption bucket key enabled by default when using aws:kms.
- feat: re-add the replication example, now it is working with the latest aws provider version.
- fix: region data source name attribute (deprecated) changed to id

## [2.5.1] - 2025-02-23
- fix: Create/configure aws_s3_bucket_public_access_block.main before the bucket policy to circumvent issues with policies which require policies which use principal `*` or principal AWS = `*`.
- comment out the replication example as it is broken, possible issue with the configurations or change on the aws provider.
- fix: lifecycle block bug fixed.

## [2.5.0] - 2024-06-07
- feat: Add the option to enable/disable block public access configuration, this is by default disabled.
- fix: CKV2_AWS_67 Adding exception to fix checkov false positive [CKV2_AWS_67](https://github.com/bridgecrewio/checkov/issues/6294)

## [2.4.0] - 2024-01-04
- feat: Added both organizational and non-organizational cloudtrail bucket policy documents to be attached when condition is met

## [2.3.1] - 2023-09-26
- fix: `Error Putting S3 Notification Configuration: Unable to validate the following destination configurations` when using using notifications on complete example.
- feat: show full module coverage in complete examples for bucket notification feature.

## [2.3.0] - 2023-09-07
- feat: Added Lifecycle Configuration which fixes checkov alert `CKV2_AWS_62`
- feat: Added Bucket Notification which fixes checkov alert `CKV2_AWS_61`
- feat: Added `aws_s3_bucket_ownership_controls` which fixes acl error due to recent s3 update by aws from April 2023. See [here](https://aws.amazon.com/blogs/aws/heads-up-amazon-s3-security-changes-are-coming-in-april-of-2023/)

## [2.2.1] - 2023-08-16
-fix: added checkov exceptions to `.checkov.yml` file

## [2.2.0] - 2022-08-11
### Added Features
- feat: Replication Configuration
- Fix: CKV_AWS_144 #Ensure that S3 bucket has cross-region replication enabled

## [2.1.1] - 2022-07-07
### Description
- Feature: S3 bucket logging

## [2.1.0] - 2022-06-14
### Added Features
- CORS Configuration
- Server Side Encryption Configuration
- Bucket Acl

## [2.0.0] - 2022-06-06
### Description
This release is intented to use the new AWS provider version (v4 or above) which has breaking changes from the previous version (version 3).
Since AWS provider version 4, S3 uses stand-alone resources to configure many of the options and this is triggering a refactor of all the module. Release 2.0.0 will have less features/configurations than the previous version which are programmed to be gradually added in new releases.

### Changes/Refactor
The following features have now been added as stand-alone resources in this release:
- Bucket
- Policy
- Public access block
- Versioning

### Added
- Add: the `.github/workflow` folder (not supposed to run gitcommit)
- Re-factor examples to have `minimum` and `complete`
- Add: `CHANGELOG.md`
- Add: `CODEOWNERS`
- Add: `versions.tf`, which is important for pre-commit checks
- Add: `Makefile` for examples automation
- Add: `.gitignore` file

## [1.0.1] - 2022-04-29
### Changes
- Restructuring example

## [1.0.0] - 2022-03-04
### Description
- Initial commit
- Included most basic/common settings in module

[Unreleased]: https://github.com/boldlink/terraform-aws-s3/compare/2.6.0...HEAD
[2.6.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.6.0
[2.5.1]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.5.1
[2.5.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.5.0
[2.4.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.4.0
[2.3.1]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.3.1
[2.3.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.3.0
[2.2.1]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.2.1
[2.2.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.2.0
[2.1.1]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.1.1
[2.1.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.1.0
[2.0.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.0.0
[1.0.1]: https://github.com/boldlink/terraform-aws-s3/releases/tag/1.0.1
[1.0.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/1.0.0
