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
