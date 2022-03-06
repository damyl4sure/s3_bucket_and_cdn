# S3 bucket policy to allow OAI to  GEtObject on any path of the bucket

resource "aws_s3_bucket_policy" "create_bucket_policy" {
  bucket = aws_s3_bucket.create_bucket.id
  policy = data.aws_iam_policy_document.documents-cloudfront-policy.json
}
data "aws_iam_policy_document" "documents-cloudfront-policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.create-bucket-origin-identity.iam_arn]
    }
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.create_bucket.arn}/*",
    ]
  }
}