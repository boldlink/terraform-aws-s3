module "kms_key" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source           = "boldlink/kms/aws"
  description      = "kms key for ${var.name}"
  create_kms_alias = true
  alias_name       = "alias/${var.name}-key-alias"
  tags             = local.tags
}

module "complete" {
  source                 = "../../"
  bucket                 = var.name
  bucket_policy          = data.aws_iam_policy_document.s3.json
  sse_kms_master_key_arn = module.kms_key.arn
  force_destroy          = true
  eventbridge            = true
  tags                   = local.tags

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

  lifecycle_configuration = [
    {
      id     = "config"
      status = "Enabled"

      filter = {
        prefix = "config/"
      }

      noncurrent_version_expiration = [
        {
          days = 150
        }
      ]

      abort_incomplete_multipart_upload_days = 7

      noncurrent_version_transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
          storage_class = "ONEZONE_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
    },
    {
      id     = "log"
      status = "Enabled"

      expiration = [
        {
          days = 90
        }
      ]

      filter = {
        and = {
          prefix = "log/"

          tags = {
            rule      = "log"
            autoclean = "true"
          }
        }
      }

      transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
          storage_class = "GLACIER"
        }
      ]
    },
    {
      id     = "tmp"
      status = "Enabled"

      filter = {
        prefix = "tmp/"
      }

      expiration = [
        {
          date = "2024-01-13T00:00:00Z"
        }
      ]
    }
  ]
}

module "s3_logging" {
  source        = "./../../"
  bucket        = "example-logging-bucket"
  force_destroy = true
}
