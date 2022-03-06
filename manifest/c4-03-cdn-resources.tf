resource "aws_cloudfront_distribution" "create_cdn" {
  
  //aliases = var.cdn_aliases

  origin {
    domain_name = aws_s3_bucket.create_bucket.bucket_regional_domain_name
    origin_id   = "s3"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.create-bucket-origin-identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Distribution of signed S3 objects"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"] # reads only
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3"
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      #locations        = ["US", "CA"]
    }
  }

  tags = {
    #Name = aws_acm_certificate.apex.domain_name # So it looks nice in the console
    Name    = "${terraform.workspace}-${var.tag_name}"
    Purpose = var.tag_purpose
  }

  # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html
  #   viewer_certificate {
  #     acm_certificate_arn      = aws_acm_certificate.apex.arn
  #     ssl_support_method       = "sni-only"
  #     minimum_protocol_version = "TLSv1.2_2021"
  #   }

  #   depends_on = [
  #     aws_acm_certificate_validation.apex-certificate
  #   ]

  viewer_certificate {
    cloudfront_default_certificate = true

  }
}