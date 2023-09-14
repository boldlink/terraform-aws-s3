data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = compact([data.aws_iam_policy_document.default.json, var.bucket_policy])
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = "DefaultS3BucketPolicyStatement"
    actions = [
      "s3:GetBucketLocation"
    ]
    effect = "Allow"
    resources = [
      aws_s3_bucket.main.arn
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:${local.partition}:iam::${local.account_id}:root"
      ]
    }
  }
}
