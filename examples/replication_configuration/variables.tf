variable "source_bucket" {
  type        = string
  description = "The name of the source bucket"
  default     = "boldlink-replication-example-src-bucket"
}

variable "destination_bucket" {
  type        = string
  description = "The name of the destination bucket"
  default     = "boldlink-replication-example-dest-bucket"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the resources"
  default = {
    Environment        = "example"
    "user::CostCenter" = "terraform"
    Department         = "DevOps"
    Project            = "Examples"
    InstanceScheduler  = true
    Owner              = "Boldlink"
    LayerName          = "cExample"
    LayerId            = "cExample"
  }
}
