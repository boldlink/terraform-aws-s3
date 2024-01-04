data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_organizations_organization" "current" {}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = compact([
    var.attach_org_cloudtrail_policy ? data.aws_iam_policy_document.org_s3[0].json : "",
    var.attach_non_org_trail_policy ? data.aws_iam_policy_document.non_org_trail_policy[0].json : "",
    data.aws_iam_policy_document.default.json,
  var.bucket_policy])
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

#Organization_trail_policy
data "aws_iam_policy_document" "org_s3" {
  count = var.attach_org_cloudtrail_policy ? 1 : 0

  version = "2012-10-17"
  statement {
    sid    = "AWSCloudTrailAclCheckOrg"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.${local.dns_suffix}"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:${local.partition}:s3:::${var.bucket}"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${local.partition}:cloudtrail:${local.region}:${local.account_id}:trail/${var.bucket}"]
    }
  }

  statement {
    sid    = "AWSCloudTrailWriteOrg"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.${local.dns_suffix}"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = ["arn:${local.partition}:s3:::${var.bucket}/AWSLogs/${local.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${local.partition}:cloudtrail:${local.region}:${local.account_id}:trail/${var.bucket}"]
    }
  }

  statement {
    sid    = "AWSCloudTrailWriteOrgSrc"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.${local.dns_suffix}"]
    }
    actions = [
      "s3:PutObject"
    ]
    resources = ["arn:${local.partition}:s3:::${var.bucket}/AWSLogs/${local.organization_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${local.partition}:cloudtrail:${local.region}:${local.account_id}:trail/${var.bucket}"]
    }
  }
}

##Non-Organization_cloudtrail_policy
data "aws_iam_policy_document" "non_org_trail_policy" {
  count = var.attach_non_org_trail_policy ? 1 : 0

  version = "2012-10-17"
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.${local.dns_suffix}"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:${local.partition}:s3:::${var.bucket}"]
  }
  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.${local.dns_suffix}"]
    }
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = ["arn:${local.partition}:s3:::${var.bucket}/AWSLogs/${local.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
