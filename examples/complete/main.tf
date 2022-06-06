module "complete" {
  source        = "../../"
  bucket        = local.name
  bucket_policy = data.aws_iam_policy_document.s3.json

  public_access_block = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}
