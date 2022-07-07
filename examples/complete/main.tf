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

  s3_logging = {
    target_bucket = module.s3_logging.id
    target_prefix = "/logs"
  }

  cors_rule = [
    {
      allowed_headers = ["*"]
      allowed_methods = [
        "PUT",
        "POST",
        "GET",
        "HEAD",
        "DELETE"
      ]
      allowed_origins = [
        "cdn.myapp.com",
        "myapp.com",
        "https://cdn.myapp.com",
        "https://myapp.com"
      ]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]

  ## Bucket ACL: NOT RECOMMENDED by AWS, Use S3 Bucket policy instead
  bucket_acl = {
    access_control_policy = {

      owner = {
        id = data.aws_canonical_user_id.current.id
      }

      grants = [
        {
          grantee = {
            type = "Group"
            uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
          }
          permission = "READ_ACP"
        },
        {
          grantee = {
            type = "Group"
            uri  = "http://acs.amazonaws.com/groups/s3/LogDelivery"
          }
          permission = "WRITE"
        }
      ]
    }
  }

  tags = {
    Name        = local.name
    Environment = "Dev"
  }
}

module "s3_logging" {
  source        = "./../../"
  bucket        = "example-logging-bucket"
  force_destroy = true
}
