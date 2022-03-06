# Create s3 bucket
resource "aws_s3_bucket" "create_bucket" {
  bucket        = "${terraform.workspace}-${var.s3_bucket_name}"
  force_destroy = var.force_destroy

  tags = {
    Name    = var.tag_name
    Purpose = var.tag_purpose
  }

}

# s3 bucket access list config
resource "aws_s3_bucket_acl" "create_acl" {
  bucket = aws_s3_bucket.create_bucket.id
  acl    = var.acl
}

# Block public access to s3 bucket
resource "aws_s3_bucket_public_access_block" "create_block_public_access" {
  bucket = aws_s3_bucket.create_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}