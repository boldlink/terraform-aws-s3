module "complete" {
  source        = "../../"
  bucket        = local.name
  bucket_policy = data.aws_iam_policy_document.s3.json

  versioning = {
    expected_bucket_owner = data.aws_caller_identity.current.account_id

    versioning_configuration = {
      status     = "Enabled"
      mfa_delete = "Disabled"
    }
  }

  tags = {
    Name        = local.name
    Environment = "Dev"
  }
}
