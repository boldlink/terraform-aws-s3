### Bucket
variable "bucket" {
  type        = string
  description = "(Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be lowercase and less than or equal to 63 characters in length."
  default     = null
}

variable "bucket_prefix" {
  type        = string
  description = "Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be lowercase and less than or equal to 37 characters in length."
  default     = null
}

variable "force_destroy" {
  type        = bool
  description = "(Optional, Default:false) A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the bucket."
  default     = {}
}

variable "cors_rule" {
  type        = any
  description = "A rule of Cross-Origin Resource Sharing."
  default     = []
}

variable "replication_configuration" {
  type        = any
  description = "Provides an independent configuration resource for S3 bucket replication configuration."
  default     = {}
}

variable "bucket_acl" {
  type        = any
  description = "The canned ACL to apply."
  default     = {}
}

### Bucket Policy
variable "bucket_policy" {
  type        = string
  description = "Attaches a policy to an S3 bucket resource."
  default     = null
}

## Public access block
variable "block_public_acls" {
  type        = bool
  description = "(Optional) Whether Amazon S3 should block public ACLs for this bucket."
  default     = true
}

variable "block_public_policy" {
  type        = bool
  description = "(Optional) Whether Amazon S3 should block public bucket policies for this bucket."
  default     = true
}

variable "ignore_public_acls" {
  type        = bool
  description = "(Optional) Whether Amazon S3 should ignore public ACLs for this bucket."
  default     = true
}

variable "restrict_public_buckets" {
  type        = bool
  description = "(Optional) Whether Amazon S3 should restrict public bucket policies for this bucket."
  default     = true
}

variable "expected_bucket_owner" {
  type        = string
  description = "(Optional, Forces new resource) The account ID of the expected bucket owner."
  default     = null
}

variable "versioning_mfa" {
  type        = string
  description = "The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device."
  default     = null
}

variable "versioning_status" {
  type        = string
  description = "(Required) The versioning state of the bucket. Valid values: `Enabled`, `Suspended`, or `Disabled`. Disabled should only be used when creating or importing resources that correspond to unversioned S3 buckets."
  default     = "Disabled"
}

variable "versioning_mfa_delete" {
  type        = string
  description = "(Optional) Specifies whether MFA delete is enabled in the bucket versioning configuration. Valid values: `Enabled` or `Disabled`."
  default     = null
}

variable "sse_bucket_key_enabled" {
  type        = bool
  description = "(Optional) Whether or not to use Amazon S3 Bucket Keys for SSE-KMS."
  default     = null
}

variable "sse_kms_master_key_arn" {
  type        = string
  description = "(Optional) The AWS KMS master key ARN used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as `aws:kms`. The default `aws/s3` AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms`."
  default     = null
}

variable "sse_sse_algorithm" {
  type        = string
  description = "(Required) The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`"
  default     = "aws:kms"
}

variable "s3_logging" {
  description = "A map of configurations where to store logs"
  type        = map(any)
  default     = {}
}

variable "object_ownership" {
  type        = string
  description = "Object ownership. Valid values: `BucketOwnerPreferred`, `ObjectWriter` or `BucketOwnerEnforced`"
  default     = "ObjectWriter"
}

variable "lambda_function" {
  type        = any
  description = "Configuration for S3 notification lambda function"
  default     = []
}

variable "queue" {
  type        = any
  description = "Configuration for S3 notification SQS queue"
  default     = []
}

variable "topic" {
  type        = any
  description = "Configuration for S3 notification SNS topic"
  default     = []
}

variable "lifecycle_configuration" {
  type        = any
  description = "A map of s3 lifecycle configuration"
  default     = []
}

variable "eventbridge" {
  type        = bool
  description = "Whether to enable Amazon EventBridge notifications"
  default     = false
}
