locals {
  name               = "replication-example-boldlink-bucket"
  account_id         = data.aws_caller_identity.current.account_id
  partition          = data.aws_partition.current.partition
  destination_bucket = "boldlink-logs-bucket"

  tags = {
    name        = local.name
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
        "Sid" : "AllowAssumeRoleViaS3"
      }
    ]
  })

  role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "s3:GetReplicationConfiguration",
          "s3:ListBucket"
        ],
        "Effect" : "Allow",
        "Resource" : [module.replication_example.arn]
      },
      {
        "Action" : [
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging"
        ],
        "Effect" : "Allow",
        "Resource" : [
          "${module.replication_example.arn}/*"
        ]
      },
      {
        "Action" : [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:s3:::${local.destination_bucket}/*"
      }
    ]
  })
}
