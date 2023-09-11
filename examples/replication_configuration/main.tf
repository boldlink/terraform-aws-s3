provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "dest"
  region = "eu-central-1"
}

resource "random_string" "bucket" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

module "replication_role" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                = "boldlink/iam-role/aws"
  name                  = var.source_bucket
  description           = "S3 replication role"
  assume_role_policy    = local.assume_role_policy
  force_detach_policies = true
  policies = {
    "${var.source_bucket}-policy" = {
      policy = local.role_policy
    }
  }
}

module "source_kms_key" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source           = "boldlink/kms/aws"
  description      = "kms key for ${var.source_bucket}"
  create_kms_alias = true
  alias_name       = "alias/${var.source_bucket}-key-alias"
  tags             = local.tags
}

module "destination_kms_key" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source           = "boldlink/kms/aws"
  description      = "kms key for ${var.destination_bucket}"
  create_kms_alias = true
  alias_name       = "alias/${var.destination_bucket}-key-alias"
  tags             = local.tags

  providers = {
    aws = aws.dest
  }
}

module "source_bucket" {
  source                 = "../../"
  bucket                 = local.source_bucket
  sse_kms_master_key_arn = module.source_kms_key.arn
  versioning_status      = "Enabled"
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
            replica_kms_key_id = module.destination_kms_key.arn
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
            replica_kms_key_id = module.destination_kms_key.arn
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
  sse_kms_master_key_arn = module.destination_kms_key.arn
  versioning_status      = "Enabled"
  force_destroy          = true

  providers = {
    aws = aws.dest
  }

  tags = {
    environment = "examples"
    name        = var.destination_bucket
  }
}
