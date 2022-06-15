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

variable "bucket_acl" {
  type        = any
  description = "The canned ACL to apply."
  default     = {}
}

variable "server_side_encryption" {
  type        = any
  description = "A configuration of server-side encryption configuration."
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

### Versioning
variable "versioning" {
  type        = any
  description = "A configuration of the S3 bucket versioning state."
  default     = {}
}
