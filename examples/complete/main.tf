module "kms_key" {
  source           = "boldlink/kms/aws"
  description      = "kms key for ${local.name}"
  create_kms_alias = true
  alias_name       = "alias/${local.name}-key-alias"

  tags = {
    environment = "dev"
    name        = local.name
  }
}

module "complete" {
  source                 = "../../"
  bucket                 = local.name
  bucket_policy          = data.aws_iam_policy_document.s3.json
  sse_kms_master_key_arn = module.kms_key.arn

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

  tags = {
    Name        = local.name
    Environment = "Dev"
  }
}
