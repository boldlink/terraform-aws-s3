resource "random_string" "bucket" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

resource "aws_sqs_queue" "main" {
  #checkov:skip=CKV_AWS_27: "Ensure all data stored in the SQS queue is encrypted"
  name = "${var.name}-${random_string.bucket.result}"
}

resource "aws_sqs_queue_policy" "main" {
  queue_url = aws_sqs_queue.main.id
  policy    = data.aws_iam_policy_document.sqs.json
}

module "first_topic" {
  source  = "boldlink/sns/aws"
  version = "1.1.1"
  name    = "${var.name}-${random_string.bucket.result}-1"
  policy  = data.aws_iam_policy_document.sns.json
  tags    = local.tags
}

module "second_topic" {
  source  = "boldlink/sns/aws"
  version = "1.1.1"
  name    = "${var.name}-${random_string.bucket.result}-2"
  policy  = data.aws_iam_policy_document.sns.json
  tags    = local.tags
}

module "s3_notification_lambda" {
  source                        = "boldlink/lambda/aws"
  version                       = "1.0.0"
  function_name                 = local.bucket
  description                   = "Lambda function for s3 notification"
  filename                      = "lambda.zip"
  handler                       = "index.lambda_handler"
  publish                       = true
  runtime                       = "python3.9"
  additional_lambda_permissions = local.additional_lambda_permissions
  source_code_hash              = data.archive_file.lambda_zip.output_base64sha256
  tags                          = local.tags
  ## Allow lambda invokation s3
  lambda_permissions = [
    {
      statement_id = "AllowExecutionFromS3Bucket"
      action       = "lambda:InvokeFunction"
      principal    = "s3.amazonaws.com"
      source_arn   = local.s3_arn
    }
  ]
}

#Prevent conflict between s3 notification and lambda permission, sns and sqs
resource "time_sleep" "main" {
  create_duration = "60s"

  triggers = {
    # This sets up a proper dependency on the function association
    lambda_function_arn = module.s3_notification_lambda.arn
    first_topic_arn     = module.first_topic.arn
    second_topic_arn    = module.second_topic.arn
  }
}

module "kms_key" {
  source           = "boldlink/kms/aws"
  version          = "1.1.0"
  description      = "kms key for ${local.bucket}"
  create_kms_alias = true
  alias_name       = "alias/${var.name}-key-alias"
  tags             = local.tags
}

module "complete" {
  source                 = "../../"
  bucket                 = local.bucket
  bucket_policy          = data.aws_iam_policy_document.s3.json
  sse_kms_master_key_arn = module.kms_key.arn
  force_destroy          = true
  eventbridge            = true
  versioning_status      = "Enabled"
  tags                   = local.tags

  lambda_function = [
    {
      lambda_function_arn = time_sleep.main.triggers["lambda_function_arn"]
      events              = ["s3:ObjectCreated:*"]
      filter_prefix       = "AWSLogs/"
    }
  ]

  topic = [
    {
      topic_arn     = time_sleep.main.triggers["first_topic_arn"]
      events        = ["s3:ObjectRemoved:Delete"]
      filter_prefix = "example/"
    },
    {
      topic_arn = time_sleep.main.triggers["second_topic_arn"]
      events    = ["s3:ObjectRemoved:DeleteMarkerCreated"]
    }
  ]

  queue = [
    {
      queue_arn     = aws_sqs_queue.main.arn
      events        = ["s3:ObjectCreated:Put"]
      filter_prefix = "example2/"
    }
  ]

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

  depends_on = [
    random_string.bucket
  ]
}

module "s3_logging" {
  source        = "./../../"
  bucket        = "logging-example-bucket-${random_string.bucket.result}"
  force_destroy = true

  depends_on = [
    random_string.bucket
  ]
}

module "bucket_with_log_policies" {
  source                      = "./../../"
  enable_block_public_access  = false
  bucket                      = "logging-policies-${random_string.bucket.result}"
  force_destroy               = true
  attach_non_org_trail_policy = true
}
