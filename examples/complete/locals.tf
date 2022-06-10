locals {
  name       = "complete-example-boldlink-bucket"
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
}
