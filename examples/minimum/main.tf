locals {
  name = "minimum-example-boldlink-bucket"
}

module "minimum" {
  source = "../../"
  bucket = local.name

  tags = {
    Name        = local.name
    Environment = "Dev"
  }
}
