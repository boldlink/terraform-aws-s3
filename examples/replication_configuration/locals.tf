locals {
  source_bucket      = "boldlink-replication-src-bucket"
  destination_bucket = "boldlink-replication-dest-bucket"

  tags = {
    name        = local.source_bucket
    environment = "examples"
  }

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
          "kms:Decrypt"
        ],
        "Effect" : "Allow",
        "Resource" : module.kms_key.arn
      },
      {
        "Action" : [
          "kms:Encrypt"
        ],
        "Effect" : "Allow",
        "Resource" : module.kms_key.arn
      }
    ]
  })
}
