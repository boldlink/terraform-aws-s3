##This example must be deployed in the management account
resource "random_string" "bucket" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

module "organization_trail_bucket" {
  source                       = "../../"
  bucket                       = local.bucket
  attach_org_cloudtrail_policy = true
  tags                         = local.tags
}
