module "replication_role" {
  source                = "boldlink/iam-role/aws"
  name                  = local.name
  assume_role_policy    = local.assume_role_policy
  description           = "S3 replication role"
  force_detach_policies = true
  policies = {
    "${local.name}-policy" = {
      policy = local.role_policy
    }
  }
}

module "kms_key" {
  source           = "boldlink/kms/aws"
  description      = "kms key for ${local.name}"
  create_kms_alias = true
  alias_name       = "alias/${local.name}-key-alias"
  tags             = local.tags
}

module "destination_bucket" {
  source                 = "../../"
  bucket                 = local.destination_bucket
  bucket_policy          = data.aws_iam_policy_document.destination.json
  sse_kms_master_key_arn = module.kms_key.arn
  force_destroy          = true
  tags = {
    environment = "examples"
    name        = "destination-${local.name}"
  }
}

module "replication_example" {
  source                 = "../../"
  bucket                 = local.name
  bucket_policy          = data.aws_iam_policy_document.s3.json
  sse_kms_master_key_arn = module.kms_key.arn
  force_destroy          = true
  tags                   = local.tags

  replication_configuration = {
    role = module.replication_role.arn
    rule = {
      id = "boldlink"

      filter = {
        prefix = "bold"
      }

      status = "Enabled"

      delete_marker_replication = {
        status = "Enabled"
      }

      destination = {
        account       = local.account_id
        bucket        = "arn:aws:s3:::${local.destination_bucket}"
        storage_class = "STANDARD"
      }
    }
  }
}
