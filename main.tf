#### S3 Module
resource "aws_s3_bucket" "main" {
  bucket              = var.bucket
  bucket_prefix       = var.bucket_prefix
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags                = var.tags
}

resource "aws_s3_bucket_policy" "main" {
  count  = var.bucket_policy != null ? 1 : 0
  bucket = aws_s3_bucket.main.bucket
  policy = var.bucket_policy
}

resource "aws_s3_bucket_public_access_block" "main" {
  count                   = length(var.public_access_block) > 0 ? 1 : 0
  bucket                  = aws_s3_bucket.main.bucket
  block_public_acls       = try(var.public_access_block["block_public_acls"], null)
  block_public_policy     = try(var.public_access_block["block_public_policy"], null)
  ignore_public_acls      = try(var.public_access_block["ignore_public_acls"], null)
  restrict_public_buckets = try(var.public_access_block["restrict_public_buckets"], null)
}
