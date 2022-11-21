terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my-bucket" {
  bucket = "${var.bucket-name}"
  # acl    = "private"
  policy = data.template_file.policy.rendered
}

resource "aws_s3_bucket_website_configuration" "statik-web" {
  bucket = aws_s3_bucket.my-bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public-access-block" {
  bucket = aws_s3_bucket.my-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "template_file" "policy" {
  template = file("${abspath(path.module)}/static-website-policy.json")
  vars = {
    bucket-name = var.bucket-name
  }
}