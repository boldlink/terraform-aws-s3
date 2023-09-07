locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  tags       = merge({ "Name" = var.name }, var.tags)
}
