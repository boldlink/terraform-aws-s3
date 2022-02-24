locals {
  cors_rule = [
    {
      cors_allowed_headers = var.cors_allowed_headers
      cors_allowed_methods = var.cors_allowed_methods
      cors_allowed_origins = var.cors_allowed_origins
      cors_expose_headers  = var.cors_expose_headers
      cors_max_age_seconds = var.cors_max_age_seconds
    }
  ]

  versioning = [
    {
      versioning_enabled    = var.versioning_enabled
      versioning_mfa_delete = var.versioning_mfa_delete
    }
  ]

  website = [
    {
      website_index_document           = var.website_index_document
      website_error_document           = var.website_error_document
      website_routing_rules            = var.website_routing_rules
      website_redirect_all_requests_to = var.website_redirect_all_requests_to
    }
  ]

  grants = [
    {
      grant_id          = var.grant_id
      grant_type        = var.grant_type
      grant_permissions = var.grant_permissions
      grant_uri         = var.grant_uri
    }
  ]

  lifecycle_rules = [
    {
      lifecycle_rule_id                           = var.lifecycle_rule_id
      lifecycle_rule_enabled                      = var.lifecycle_rule_enabled
      lifecycle_rule_prefix                       = var.lifecycle_rule_prefix
      abort_incomplete_multipart_upload_days      = var.abort_incomplete_multipart_upload_days
      transition                                  = null
      transition_days                             = var.transition_days
      transition_date                             = var.transition_date
      transition_storage_class                    = var.transition_storage_class
      expiration                                  = null
      expiration_days                             = var.expiration_days
      expiration_date                             = var.expiration_date
      expiration_expired_object_delete_marker     = var.expiration_expired_object_delete_marker
      noncurrent_version_expiration               = null
      noncurrent_version_expiration_days          = var.noncurrent_version_expiration_days
      noncurrent_version_transition               = null
      noncurrent_version_transition_days          = var.noncurrent_version_transition_days
      noncurrent_version_transition_storage_class = var.noncurrent_version_transition_storage_class
    }
  ]

  server_side_encryption_configuration = [
    {
      sse_bucket_key_enabled = var.sse_bucket_key_enabled
      sse_algorithm          = var.sse_algorithm
      sse_kms_master_key_id  = var.sse_kms_master_key_id
    }
  ]

  object_lock_configuration = [
    {
      object_lock_enabled     = var.object_lock_enabled
      default_retention_mode  = var.default_retention_mode
      default_retention_days  = var.default_retention_days
      default_retention_years = var.default_retention_years
    }
  ]
}
