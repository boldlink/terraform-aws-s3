output "s3_id" {
  value       = aws_s3_bucket.main.id
  description = "The name of the bucket."
}

output "s3_arn" {
  value       = aws_s3_bucket.main.arn
  description = "The ARN of the bucket. Will be of format `arn:aws:s3:::bucketname`"
}

output "s3_region" {
  value       = aws_s3_bucket.main.region
  description = "The AWS region this bucket resides in."
}

output "s3_bucket_domain_name" {
  value       = aws_s3_bucket.main.bucket_domain_name
  description = "The bucket domain name. Will be of format `bucketname.s3.amazonaws.com`."
}

output "s3_bucket_regional_domain_name" {
  value       = aws_s3_bucket.main.bucket_regional_domain_name
  description = "The bucket region-specific domain name. The bucket domain name including the region name"
}

output "s3_hosted_zone_id" {
  value       = aws_s3_bucket.main.hosted_zone_id
  description = "The Route 53 Hosted Zone ID for this bucket's region."
}

output "s3_tags_all" {
  value       = aws_s3_bucket.main.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags"
}

output "s3_website_endpoint" {
  value       = aws_s3_bucket.main.website_endpoint
  description = "The website endpoint, if the bucket is configured with a website. If not, this will be an empty string"
}

output "s3_website_domain" {
  value       = aws_s3_bucket.main.website_domain
  description = "The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records."
}
