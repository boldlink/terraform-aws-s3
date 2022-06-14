module "complete" {
  source        = "../../"
  bucket        = local.name
  bucket_policy = data.aws_iam_policy_document.s3.json

  versioning = {
    versioning_configuration = {
      status     = "Enabled"
      mfa_delete = "Disabled"
    }
  }

  cors_rule = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://boldlink.io"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    },
    {
      allowed_methods = ["GET"]
      allowed_origins = ["*"]
    }
  ]

  ## Bucket ACL
  bucket_acl = {
    access_control_policy = {

      owner = {
        id = data.aws_canonical_user_id.current.id
      }

      grants = [
        {
          grantee = {
            id   = data.aws_canonical_user_id.current.id
            type = "CanonicalUser"
          }
          permission = "READ"
        },
        {
          grantee = {
            type = "Group"
            uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
          }
          permission = "READ_ACP"
        }
      ]
    }
  }

  server_side_encryption = {
    expected_bucket_owner = data.aws_caller_identity.current.account_id
    rules = [
      {
        bucket_key_enabled = true
        apply_server_side_encryption_by_default = {
          sse_algorithm = "aws:kms"
        }
      }
    ]
  }

  tags = {
    Name        = local.name
    Environment = "Dev"
  }
}
