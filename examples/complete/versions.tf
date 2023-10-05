terraform {
  required_version = ">= 0.14.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.9"
    }

    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}
