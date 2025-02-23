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
  source                = "boldlink/iam-role/aws"
  version               = "1.1.0"
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
  source           = "boldlink/kms/aws"
  description      = "kms key for ${local.source_bucket}"
  create_kms_alias = true
  alias_name       = "alias/${local.source_bucket}-key-alias"
  tags             = merge({ "Name" = local.source_bucket }, var.tags)
}

module "destination_kms_key" {
  source           = "boldlink/kms/aws"
  description      = "kms key for ${local.destination_bucket}"
  create_kms_alias = true
  alias_name       = "alias/${local.destination_bucket}-key-alias"
  tags             = merge({ "Name" = local.destination_bucket }, var.tags)

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
        id       = "everything"
        status   = "Enabled"
        priority = 1

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
            environment = "examples"
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
      },
      {
        id     = "example-filter"
        status = "Enabled"

        delete_marker_replication = {
          status = "Disabled"
        }

        destination = {
          bucket        = module.destination_bucket.arn
          storage_class = "STANDARD"
          account       = data.aws_caller_identity.current.account_id

          encryption_configuration = {
            replica_kms_key_id = module.destination_kms_key.arn
          }

          access_control_translation = {
            owner = "Destination"
          }

          metrics = {
            status = "Enabled"
            event_threshold = {
              minutes = 15
            }
          }

          replication_time = {
            status = "Enabled"
            time = {
              minutes = 15
            }
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

  tags = merge({ "Name" = local.source_bucket }, var.tags)
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

  tags = merge({ "Name" = local.destination_bucket }, var.tags)
}
