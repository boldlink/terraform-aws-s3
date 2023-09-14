output "id" {
  value       = aws_s3_bucket.main.id
  description = "The name of the bucket."
}

output "bucket" {
  value       = aws_s3_bucket.main.bucket
  description = "The name of the bucket."
}

output "arn" {
  value       = aws_s3_bucket.main.arn
  description = "The ARN of the bucket. Will be of format `arn:aws:s3:::bucketname`"
}

output "region" {
  value       = aws_s3_bucket.main.region
  description = "The AWS region this bucket resides in."
}

output "bucket_domain_name" {
  value       = aws_s3_bucket.main.bucket_domain_name
  description = "The bucket domain name. Will be of format `bucketname.s3.amazonaws.com`."
}

output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.main.bucket_regional_domain_name
  description = "The bucket region-specific domain name. The bucket domain name including the region name"
}

output "hosted_zone_id" {
  value       = aws_s3_bucket.main.hosted_zone_id
  description = "The Route 53 Hosted Zone ID for this bucket's region."
}

output "tags_all" {
  value       = aws_s3_bucket.main.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags"
}
