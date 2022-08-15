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
  bucket                = aws_s3_bucket.main.bucket
  expected_bucket_owner = var.expected_bucket_owner
  mfa                   = var.versioning_mfa

  versioning_configuration {
    status     = var.versioning_status
    mfa_delete = var.versioning_mfa_delete
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
  count                 = length(keys(var.bucket_acl)) > 0 ? 1 : 0
  bucket                = aws_s3_bucket.main.bucket
  acl                   = try(var.bucket_acl["acl"], null)
  expected_bucket_owner = var.expected_bucket_owner

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
  bucket                = aws_s3_bucket.main.bucket
  expected_bucket_owner = var.expected_bucket_owner
  rule {
    bucket_key_enabled = var.sse_bucket_key_enabled
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.sse_kms_master_key_arn
      sse_algorithm     = var.sse_sse_algorithm
    }
  }
}

resource "aws_s3_bucket_logging" "main" {
  count                 = length(var.s3_logging) > 0 ? 1 : 0
  bucket                = aws_s3_bucket.main.id
  target_bucket         = var.s3_logging["target_bucket"]
  target_prefix         = var.s3_logging["target_prefix"]
  expected_bucket_owner = try(var.s3_logging["expected_bucket_owner"], null)
}


### S3 Buckets only support a single replication configuration
resource "aws_s3_bucket_replication_configuration" "main" {
  count  = length(keys(var.replication_configuration)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.main.id
  token  = try(var.replication_configuration["token"], null)
  role   = var.replication_configuration["role"]

  dynamic "rule" {
    for_each = lookup(var.replication_configuration, "rules", [])
    content {

      id       = try(rule.value.id, null)
      prefix   = try(rule.value.prefix, null)
      priority = try(rule.value.priority, null)
      status   = rule.value.status

      dynamic "delete_marker_replication" {
        for_each = try([rule.value.delete_marker_replication], [])
        content {
          status = delete_marker_replication.value.status
        }
      }

      dynamic "destination" {
        for_each = try([rule.value.destination], [])
        content {
          account       = try(destination.value.account, null)
          bucket        = destination.value.bucket
          storage_class = try(destination.value.storage_class, null)

          dynamic "access_control_translation" {
            for_each = try([destination.value.access_control_translation], [])
            content {
              owner = access_control_translation.value.owner
            }
          }

          dynamic "encryption_configuration" {
            for_each = try([destination.value.encryption_configuration], [])
            content {
              replica_kms_key_id = encryption_configuration.value.replica_kms_key_id
            }
          }

          dynamic "metrics" {
            for_each = try([destination.value.metrics], [])
            content {
              status = metrics.value.status

              dynamic "event_threshold" {
                for_each = try([metrics.value.event_threshold], [])
                content {
                  minutes = event_threshold.value.minutes
                }
              }
            }
          }

          dynamic "replication_time" {
            for_each = try([destination.value.replication_time], [])
            content {
              status = replication_time.value.status

              dynamic "time" {
                for_each = replication_time.value.time
                content {
                  minutes = time.value.minutes
                }
              }
            }
          }
        }
      }

      dynamic "filter" {
        for_each = try(flatten([rule.value.filter]), []) != [] ? try(flatten([rule.value.filter]), []) : []

        content {
          prefix = try(filter.value.prefix, null)

          dynamic "tag" {
            for_each = try([filter.value.tag], [])

            content {
              key   = try(tag.value.key, null)
              value = try(tag.value.value, null)
            }
          }
        }
      }

      dynamic "filter" {
        for_each = length(try(flatten([rule.value.filter]), [])) > 0 ? [] : [true]
        content {
        }
      }

      dynamic "filter" {
        for_each = try([rule.value.filter.and.tags], [rule.value.filter.and.prefix], []) != [] ? try(flatten([rule.value.filter]), []) : []
        content {
          and {
            prefix = try(rule.value.filter.and.prefix, null)
            tags   = try(rule.value.filter.and.tags, null)
          }
        }
      }

      dynamic "source_selection_criteria" {
        for_each = try([rule.value.source_selection_criteria], [])
        content {

          dynamic "replica_modifications" {
            for_each = try([source_selection_criteria.value.replica_modifications], [])
            content {
              status = replica_modifications.value.status
            }
          }

          dynamic "sse_kms_encrypted_objects" {
            for_each = try([source_selection_criteria.value.sse_kms_encrypted_objects], [])
            content {
              status = sse_kms_encrypted_objects.value.status
            }
          }
        }
      }

      dynamic "existing_object_replication" {
        for_each = try([rule.value.existing_object_replication], [])
        content {
          status = existing_object_replication.value.status
        }
      }
    }
  }

  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.main]
}
