resource "aws_cloudfront_origin_access_identity" "create-bucket-origin-identity" {
  comment = "Cloudfront identity for access to S3 Bucket"
}
