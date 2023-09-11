locals {
  tags               = merge({ "Name" = "${var.source_bucket}-${random_string.bucket.result}" }, var.tags)
  source_bucket      = "${var.source_bucket}-${random_string.bucket.result}"
  destination_bucket = "${var.destination_bucket}-${random_string.bucket.result}"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "s3.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : "AllowS3AssumeRole"
      }
    ]
  })

  role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:ListBucket",
          "s3:GetReplicationConfiguration",
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging",
          "s3:GetObjectVersion",
          "s3:ObjectOwnerOverrideToBucketOwner"
        ],
        "Effect" : "Allow",
        "Resource" : [
          module.destination_bucket.arn,
          "${module.destination_bucket.arn}/*",
          module.source_bucket.arn,
          "${module.source_bucket.arn}/*"
        ]
      },
      {
        "Action" : [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags",
          "s3:GetObjectVersionTagging",
          "s3:ObjectOwnerOverrideToBucketOwner"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "${module.destination_bucket.arn}/*",
          "${module.source_bucket.arn}/*"
        ]
      },
      {
        "Action" : [
          "kms:Decrypt",
          "kms:Encrypt"
        ],
        "Effect" : "Allow",
        "Resource" : [
          module.source_kms_key.arn,
          module.destination_kms_key.arn
        ]
      }
    ]
  })
}
