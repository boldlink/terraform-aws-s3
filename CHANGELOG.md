# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- Acceleration Configuration
- Lifecycle Configuration
- Bucket Logging Configuration
- Object Lock Configuration
- Replication Configuration
- Request Payment Configuration
- Website Configuration

## [2.1.0] - 2022-06-14
### Added Features
- CORS Configuration
- Server Side Encryption Configuration
- Bucket Acl

[2.1.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.1.0

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

[2.0.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/2.0.0

## [1.0.1] - 2022-04-29
### Changes
- Restructuring example

[1.0.1]: https://github.com/boldlink/terraform-aws-s3/releases/tag/1.0.1

## [1.0.0] - 2022-03-04
### Description
- Initial commit
- Included most basic/common settings in module


[1.0.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/1.0.0
