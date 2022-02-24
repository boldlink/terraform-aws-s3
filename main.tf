resource "aws_s3_bucket" "main" {
  bucket              = var.name
  acl                 = var.acl
  policy              = var.policy
  force_destroy       = var.force_destroy
  acceleration_status = var.acceleration_status
  request_payer       = var.request_payer

  dynamic "versioning" {
    for_each = local.versioning

    content {
      enabled    = versioning.value.versioning_enabled
      mfa_delete = versioning.value.versioning_mfa_delete
    }
  }

  dynamic "cors_rule" {
    for_each = local.cors_rule

    content {
      allowed_headers = cors_rule.value.cors_allowed_headers
      allowed_methods = cors_rule.value.cors_allowed_methods
      allowed_origins = cors_rule.value.cors_allowed_origins
      expose_headers  = cors_rule.value.cors_expose_headers
      max_age_seconds = cors_rule.value.cors_max_age_seconds
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = local.server_side_encryption_configuration
    iterator = sse_conf

    content {
      rule {
        bucket_key_enabled = sse_conf.value.sse_bucket_key_enabled
        apply_server_side_encryption_by_default {
          kms_master_key_id = sse_conf.value.sse_kms_master_key_id
          sse_algorithm     = sse_conf.value.sse_algorithm
        }
      }
    }
  }

  dynamic "logging" {
    for_each = var.logging == null ? [] : [1]
    content {
      target_bucket = var.logging["logging_target_bucket"]
      target_prefix = var.logging["logging_target_prefix"]
    }
  }

  dynamic "object_lock_configuration" {
    for_each = local.object_lock_configuration
    iterator = oblock_conf

    content {
      object_lock_enabled = oblock_conf.value.object_lock_enabled
      rule {
        default_retention {
          mode  = oblock_conf.value.default_retention_mode
          days  = oblock_conf.value.default_retention_days
          years = oblock_conf.value.default_retention_years
        }
      }
    }
  }

  dynamic "grant" {
    for_each = local.grants

    content {
      id          = grant.value.grant_id
      type        = grant.value.grant_type
      permissions = grant.value.grant_permissions
      uri         = grant.value.grant_uri
    }
  }

  dynamic "website" {
    for_each = local.website

    content {
      index_document           = website.value.website_index_document
      error_document           = website.value.website_error_document
      routing_rules            = website.value.website_routing_rules
      redirect_all_requests_to = website.value.website_redirect_all_requests_to
    }
  }

  dynamic "lifecycle_rule" {
    for_each = local.lifecycle_rules

    content {
      enabled                                = lifecycle_rule.value.lifecycle_rule_enabled
      id                                     = lifecycle_rule.value.lifecycle_rule_id
      prefix                                 = lifecycle_rule.value.lifecycle_rule_prefix
      abort_incomplete_multipart_upload_days = lifecycle_rule.value.abort_incomplete_multipart_upload_days

      noncurrent_version_expiration {
        days = lifecycle_rule.value.noncurrent_version_expiration_days
      }

      noncurrent_version_transition {
        days          = lifecycle_rule.value.noncurrent_version_transition_days
        storage_class = lifecycle_rule.value.noncurrent_version_transition_storage_class
      }

      transition {
        days          = lifecycle_rule.value.transition_days
        date          = lifecycle_rule.value.transition_date
        storage_class = lifecycle_rule.value.transition_storage_class
      }

      expiration {
        days                         = lifecycle_rule.value.expiration_days
        date                         = lifecycle_rule.value.expiration_date
        expired_object_delete_marker = lifecycle_rule.value.expiration_expired_object_delete_marker
      }
    }
  }

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.environment
    },
    var.other_tags,
  )
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
