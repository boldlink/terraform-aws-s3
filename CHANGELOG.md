# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- Acl
- Versioning
- Acceleration Configuration
- CORS Configuration
- Lifecycle Configuration
- Bucket Logging Configuration
- Object Lock Configuration
- Replication Configuration
- Request Payment Configuration
- Server Side Encryption Configuration
- Website Configuration

## [2.0.0]  - 2022-06-06
### Description
This release is intented to use the new AWS S3 version which has breaking changes from the previous version. The following features have now been added as stand-alone resources:
- Bucket
- Policy
- Public access block

- Add: the `.github/workflow` folder (not supposed to run gitcommit)
- Re-factor examples to have `minimum` and `complete`
- Add: `CHANGELOG.md`
- Add: `CODEOWNERS`
- Add: `versions.tf`, which is important for pre-commit checks
- Add: `Makefile` for examples automation
- Add: `.gitignore` file

## [1.0.0] - 2022-03-04
### Description
- Initial commit
- Included most basic/common settings in module


[1.0.0]: https://github.com/boldlink/terraform-aws-s3/releases/tag/1.0.0
