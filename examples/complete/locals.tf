locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  bucket     = "${var.name}-${random_string.bucket.result}"
  s3_arn     = "arn:${local.partition}:s3:::${local.bucket}"
  tags       = merge({ "Name" = local.bucket }, var.tags)

  additional_lambda_permissions = {
    statement = {
      sid    = "AllowS3GetObject"
      effect = "Allow"
      actions = [
        "s3:GetObject"
      ]
      resources = ["arn:${local.partition}:s3:::*/*"]
    }
  }
}