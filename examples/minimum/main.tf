resource "random_string" "bucket" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

module "minimum" {
  source = "../../"
  bucket = "${var.name}-${random_string.bucket.result}"
  tags   = merge({ "Name" = "${var.name}-${random_string.bucket.result}" }, var.tags)
}
