locals {
  account_id      = data.aws_caller_identity.current.account_id
  partition       = data.aws_partition.current.partition
  region          = data.aws_region.current.name
  organization_id = data.aws_organizations_organization.current.id
  dns_suffix      = data.aws_partition.current.dns_suffix
}
