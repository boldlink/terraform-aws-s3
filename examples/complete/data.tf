data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_canonical_user_id" "current" {}

### Bucket Policy
data "aws_iam_policy_document" "s3" {
  version = "2012-10-17"
  statement {
    sid    = "AclCheck"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:root"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:${local.partition}:s3:::${local.bucket}"]
  }
  statement {
    sid    = "Write"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:root"]
    }
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = ["arn:${local.partition}:s3:::${local.bucket}/AWSLogs/${local.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "./lambdazip"
  output_path = "lambda.zip"
}


# SNS Topic
data "aws_iam_policy_document" "sns" {
  statement {
    sid = "AllowSNSS3BucketNotification"

    effect = "Allow"

    actions = [
      "sns:Publish",
    ]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    resources = ["*"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${local.partition}:s3:::${local.bucket}"]
    }
  }
}

data "aws_iam_policy_document" "sqs" {
  statement {
    effect  = "Allow"
    actions = ["sqs:SendMessage"]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    resources = [aws_sqs_queue.main.arn]
  }
}
