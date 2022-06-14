#### S3 Module
resource "aws_s3_bucket" "main" {
  bucket        = var.bucket
  bucket_prefix = var.bucket_prefix
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_policy" "main" {
  count  = var.bucket_policy != null ? 1 : 0
  bucket = aws_s3_bucket.main.bucket
  policy = var.bucket_policy
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket                  = aws_s3_bucket.main.bucket
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "main" {
  count                 = length(var.versioning) > 0 ? 1 : 0
  bucket                = aws_s3_bucket.main.bucket
  expected_bucket_owner = try(var.versioning["expected_bucket_owner"], null)
  mfa                   = try(var.versioning["mfa"], null)

  dynamic "versioning_configuration" {
    for_each = try([var.versioning["versioning_configuration"]], [])
    content {
      status     = versioning_configuration.value.status
      mfa_delete = try(versioning_configuration.value.mfa_delete, null)
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "main" {
  count  = length(var.cors_rule) > 0 ? 1 : 0
  bucket = aws_s3_bucket.main.bucket

  dynamic "cors_rule" {
    for_each = var.cors_rule
    content {
      allowed_headers = try(cors_rule.value.allowed_headers, null)
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = try(cors_rule.value.expose_headers, null)
      max_age_seconds = try(cors_rule.value.max_age_seconds, null)
      id              = try(cors_rule.value.id, null)
    }
  }
}

resource "aws_s3_bucket_acl" "main" {
  count                 = length(var.bucket_acl) > 0 ? 1 : 0
  bucket                = aws_s3_bucket.main.bucket
  acl                   = try(var.bucket_acl["acl"], null)
  expected_bucket_owner = try(var.bucket_acl["expected_bucket_owner"], null)

  dynamic "access_control_policy" {
    for_each = try([var.bucket_acl["access_control_policy"]], [])
    content {

      dynamic "owner" {
        for_each = try([access_control_policy.value.owner], [])
        content {
          id           = owner.value.id
          display_name = try(owner.value.display_name, null)
        }
      }

      dynamic "grant" {
        for_each = lookup(access_control_policy.value, "grants", [])
        content {

          dynamic "grantee" {
            for_each = try([grant.value.grantee], [])
            content {
              email_address = try(grantee.value.email_address, null)
              id            = try(grantee.value.id, null)
              type          = grantee.value.type
              uri           = try(grantee.value.uri, null)
            }
          }

          permission = grant.value.permission
        }
      }
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  count                 = length(var.server_side_encryption) > 0 ? 1 : 0
  bucket                = aws_s3_bucket.main.bucket
  expected_bucket_owner = try(var.server_side_encryption["expected_bucket_owner"], null)

  dynamic "rule" {
    for_each = lookup(var.server_side_encryption, "rules", [])
    content {
      bucket_key_enabled = try(rule.value.bucket_key_enabled, null)
      dynamic "apply_server_side_encryption_by_default" {
        for_each = try([rule.value.apply_server_side_encryption_by_default], [])
        content {
          kms_master_key_id = try(apply_server_side_encryption_by_default.value.kms_master_key_id, null)
          sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
        }
      }
    }
  }
}
