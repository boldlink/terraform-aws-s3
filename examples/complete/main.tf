module "complete" {
  source        = "../../"
  bucket        = local.name
  bucket_policy = data.aws_iam_policy_document.s3.json

  versioning = {
    status = "Enabled"
  }
}
