locals {
  tags   = merge({ "Name" = "${var.name}-${random_string.bucket.result}" }, var.tags)
  bucket = "${var.name}-${random_string.bucket.result}"
}
