terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  cloud {
    organization = "codyfisher"

    workspaces {
      name = "portfolio"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = "codyfisher-website-bucket"

  tags = {
    Terraform   = "True"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject"
        ],
        Effect = "Allow",
        Principal = "*",
        Resource = [
          "${aws_s3_bucket.website_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_route53_record" "website_record" {
  name = "codyfisher.dev"
  type = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.website_distribution.domain_name}"
    zone_id               = "${aws_cloudfront_distribution.website_distribution.hosted_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "portfolio" {
  domain_name       = "codyfisher.dev"
  validation_method = "DNS"

  tags = {
    Terraform   = "True"
    Environment = "Production"
  }
}

resource "aws_cloudfront_distribution" "website_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.website_bucket.bucket_domain_name}"
    origin_id   = "S3Origin"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin"

    forward_values = "all"

    viewer_protocol_policy = "redirect-to-https"
  }

  enabled = true

  default_root_object = "index.html"

  aliases = [
    "codyfisher.dev"
  ]

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA"]
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.portfolio.arn
  }
}
