provider "aws" {
  access_key = "${var.myaccess_key}"
  secret_key = "${var.mysecret_key}"
  region = "${var.region}"
}

# creta S3 lifecycle Resources

resource "aws_s3_bucket" "create-s3-bucket" {

  bucket = "${var.bucket-name}"

  acl = "private"

  lifecycle_rule {
    id = "archive"
    enabled = true
    transition {
      days = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

  }

  versioning {
    enabled = true
  }

  tags = {
    Enviroment: "QA"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_metric" "enable-metrics-bucket" {
  bucket = "${var.bucket-name}"
  name   = "EntireBucket"
}