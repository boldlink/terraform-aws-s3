module "replication_role" {
  source                = "boldlink/iam-role/aws"
  name                  = local.source_bucket
  description           = "S3 replication role"
  assume_role_policy    = local.assume_role_policy
  force_detach_policies = true
  policies = {
    "${local.source_bucket}-policy" = {
      policy = local.role_policy
    }
  }
}

module "kms_key" {
  source           = "boldlink/kms/aws"
  description      = "kms key for ${local.source_bucket}"
  create_kms_alias = true
  alias_name       = "alias/${local.source_bucket}-key-alias"
  tags             = local.tags
}

module "source_bucket" {
  source                 = "../../"
  bucket                 = local.source_bucket
  sse_kms_master_key_arn = module.kms_key.arn
  force_destroy          = true

  replication_configuration = {
    role = module.replication_role.arn

    rules = [
      {
        id     = "everything"
        status = "Enabled"

        delete_marker_replication = {
          status = "Enabled"
        }

        destination = {
          bucket        = module.destination_bucket.arn
          storage_class = "STANDARD"

          encryption_configuration = {
            replica_kms_key_id = module.kms_key.arn
          }
        }

        source_selection_criteria = {
          replica_modifications = {
            status = "Enabled"
          }

          sse_kms_encrypted_objects = {
            status = "Enabled"
          }
        }
      },
      {
        id       = "log-filter"
        status   = "Enabled"
        priority = 5

        filter = {
          prefix = "log"

          tag = {
            key   = "environment"
            value = "examples"
          }
        }

        delete_marker_replication = {
          status = "Disabled"
        }

        destination = {
          bucket        = module.destination_bucket.arn
          storage_class = "STANDARD"

          encryption_configuration = {
            replica_kms_key_id = module.kms_key.arn
          }
        }

        source_selection_criteria = {
          sse_kms_encrypted_objects = {
            status = "Enabled"
          }
        }
      }
    ]
  }

  tags = local.tags
}

module "destination_bucket" {
  source                 = "../../"
  bucket                 = local.destination_bucket
  sse_kms_master_key_arn = module.kms_key.arn
  force_destroy          = true

  tags = {
    environment = "examples"
    name        = local.destination_bucket
  }
}
