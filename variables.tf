variable "acl" {
  type        = string
  description = "The canned ACL to apply. Valid values are `private`, `public-read`, `public-read-write`, `aws-exec-read`, `authenticated-read`, and `log-delivery-write`. Defaults to private. Conflicts with `grant`"
  default     = null # Although default is `Private`, it is set to null here so as not to conflict with grant
}

variable "block_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  default     = true
}

variable "logging" {
  type = object({
    logging_target_bucket = string
    logging_target_prefix = string
  })
  default     = null
  description = "Bucket access logging configuration."
}

variable "restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
}

variable "policy" {
  type        = string
  description = "The bucket policy for resource access filtering"
  default     = null
}

variable "force_destroy" {
  type        = bool
  description = "Default:`false`. A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = "false"
}

variable "request_payer" {
  type        = string
  description = "Specifies who should bear the cost of Amazon S3 data transfer. Can be either `BucketOwner` or `Requester`. By default, the owner of the S3 bucket would incur the costs of any data transfer."
  default     = null
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket."
  default     = false
}

variable "versioning_mfa_delete" {
  type        = bool
  description = "Enable MFA delete for either `Change the versioning state of your bucket` or `Permanently delete an object version`. Default is `false`"
  default     = false
}

variable "cors_allowed_headers" {
  type        = list(string)
  description = "Specifies which headers are allowed."
  default     = []
}

variable "cors_allowed_methods" {
  type        = list(string)
  description = "Specifies which methods are allowed. Can be `GET`, `PUT`, `POST`, `DELETE` or `HEAD`"
  default     = []
}

variable "cors_allowed_origins" {
  type        = list(string)
  description = "Specifies which origins are allowed."
  default     = []
}

variable "cors_expose_headers" {
  type        = list(string)
  description = "Specifies expose header in the response."
  default     = []
}

variable "cors_max_age_seconds" {
  type        = number
  description = "Specifies time in seconds that browser can cache the response for a preflight request."
  default     = null
}


variable "website_index_document" {
  type        = string
  description = "(Required, unless using redirect_all_requests_to) Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders."
  default     = null
}

variable "website_error_document" {
  type        = string
  default     = null
  description = "An absolute path to the document to return in case of a 4XX error."
}

variable "website_routing_rules" {
  type        = string
  default     = null
  description = "A json array containing routing rules describing redirect behavior and when redirects are applied."
}

variable "website_redirect_all_requests_to" {
  type        = string
  default     = null
  description = "A hostname to redirect all website requests for this bucket to. Hostname can optionally be prefixed with a protocol (`http:// or https://`) to use when redirecting requests. The default is the protocol that is used in the original request."
}

variable "lifecycle_rule_id" {
  type        = string
  description = "Unique identifier for the rule. Must be less than or equal to 255 characters in length."
  default     = null
}

variable "lifecycle_rule_enabled" {
  type        = bool
  description = "Specifies lifecycle rule status."
  default     = null
}

variable "lifecycle_rule_prefix" {
  type        = string
  description = "Object key prefix identifying one or more objects to which the rule applies."
  default     = null
}

variable "abort_incomplete_multipart_upload_days" {
  type        = string
  description = "Specifies the number of days after initiating a multipart upload when the multipart upload must be completed."
  default     = null
}

variable "transition_days" {
  type        = string
  description = "Specifies the number of days after object creation when the specific rule action takes effect."
  default     = null
}

variable "transition_date" {
  type        = string
  description = "Specifies the date after which you want the corresponding action to take effect."
  default     = null
}

variable "transition_storage_class" {
  type        = string
  description = "Specifies the Amazon S3 storage class to which you want the object to transition."
  default     = null
}

variable "expiration_days" {
  type        = number
  description = "Specifies the number of days after object creation when the specific rule action takes effect."
  default     = null
}

variable "expiration_date" {
  type        = string
  description = "Specifies the date after which you want the corresponding action to take effect."
  default     = null
}

variable "expiration_expired_object_delete_marker" {
  type        = string
  description = "On a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Amazon S3 to delete expired object delete markers. This cannot be specified with Days or Date in a Lifecycle Expiration Policy."
  default     = null
}

variable "noncurrent_version_expiration_days" {
  type        = number
  description = "Specifies the number of days noncurrent object versions expire."
  default     = null
}

variable "noncurrent_version_transition_days" {
  type        = number
  description = "Specifies the number of days noncurrent object versions transition."
  default     = null
}

variable "noncurrent_version_transition_storage_class" {
  type        = string
  description = "Specifies the Amazon S3 storage class to which you want the object to transition."
  default     = null
}

variable "grant_id" {
  type        = string
  description = "Canonical user id to grant for. Used only when type is `CanonicalUser`."
  default     = null
}

variable "grant_type" {
  type        = string
  description = "Type of grantee to apply for. Valid values are `CanonicalUser` and `Group`. `AmazonCustomerByEmail` is not supported."
  default     = null
}

variable "grant_permissions" {
  type        = list(string)
  description = "List of permissions to apply for grantee. Valid values are `READ`, `WRITE`, `READ_ACP`, `WRITE_ACP`, `FULL_CONTROL`."
  default     = null
}

variable "grant_uri" {
  type        = string
  description = "Uri address to grant for. Used only when `type` is `Group`."
  default     = null
}

variable "sse_bucket_key_enabled" {
  type        = bool
  description = "Choose whether or not to use Amazon S3 Bucket Keys for SSE-KMS."
  default     = null
}

variable "sse_algorithm" {
  type        = string
  description = "The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`"
  default     = null
}

variable "sse_kms_master_key_id" {
  type        = any
  description = "The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as `aws:kms`. The default `aws/s3` AWS KMS master key is used if this element is absent while the sse_algorithm is `aws:kms.`"
  default     = null
}

variable "object_lock_enabled" {
  description = "Indicates whether this bucket has an Object Lock configuration enabled. Valid value is `Enabled`."
  type        = string
  default     = null
}

variable "default_retention_mode" {
  description = " The default Object Lock retention mode you want to apply to new objects placed in this bucket. Valid values are `GOVERNANCE` and `COMPLIANCE`"
  type        = string
  default     = null
}

variable "default_retention_days" {
  description = "The number of days that you want to specify for the default retention period."
  type        = number
  default     = null
}

variable "default_retention_years" {
  description = "The number of years that you want to specify for the default retention period."
  type        = number
  default     = null
}

variable "acceleration_status" {
  description = "Sets the accelerate configuration of an existing bucket. Can be `Enabled` or `Suspended`"
  type        = string
  default     = null
}

/*
Tags
*/
variable "name" {
  type        = string
  default     = null
  description = "The name of the bucket."
}

variable "environment" {
  type        = string
  description = "The environment this resource is belongs to"
  default     = null
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}
