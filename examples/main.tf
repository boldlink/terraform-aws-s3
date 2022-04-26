provider "aws" {
  region = "eu-west-1"
}

locals {
  name            = "s3-bucket"
  target_bucket   = "test-boldlink"
  allowed_origins = ["https://s3-website-test.boldlink.io"]
}

data "aws_iam_policy_document" "s3_read_permissions" {
  statement {
    sid     = "allow-read-only-access"
    actions = ["s3:GetObject", "s3:ListBucket"]
    principals {
      identifiers = ["*"]
      type        = "*"
    }
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }
}

module "private_s3_bucket" {
  source = "boldlink/s3/aws"
  name   = local.name
  cors_allowed_headers = ["*"]
  cors_allowed_methods = ["GET"]
  cors_allowed_origins = local.allowed_origins
  cors_expose_headers  = ["ETag"]
  cors_max_age_seconds = 3000

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  sse_bucket_key_enabled = true
  sse_algorithm          = "aws:kms"
  sse_kms_master_key_id  = "aws/s3"

  object_lock_enabled    = "Enabled"
  default_retention_mode = "GOVERNANCE"
  default_retention_days = 1

  versioning_enabled = true

  grant_type        = "Group"
  grant_permissions = ["READ_ACP", "WRITE"]
  grant_uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"

  website_index_document = "index.html"
  website_error_document = "error.html"
  website_routing_rules  = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF

  lifecycle_rule_enabled                      = true
  lifecycle_rule_prefix                       = "log/"
  transition_days                             = 30
  transition_storage_class                    = "STANDARD_IA"
  expiration_days                             = 90
  noncurrent_version_transition_storage_class = "GLACIER"

}

output "outputs" {
  value = [
    module.private_s3_bucket,
  ]
}
