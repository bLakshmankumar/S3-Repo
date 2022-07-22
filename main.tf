#provider block

provider "aws" {
  access_key = "${var.myaccess_key}"
  secret_key = "${var.mysecret_key}"
  region = "${var.region}"
}

# Resource bloc( Here i create s3 bucket)

resource "aws_s3_bucket" "s3tf_bucket" {
    bucket = "s3-tf-bucket-july-15-2022"
    acl = "private"
    versioning {
    enabled = true
  }

    tags = {
      "Environment" = "Test"
    }
  
}

# Uploading a single file into s3 bucket

resource "aws_s3_bucket_object" "tf_object" {
    bucket = "s3-tf-bucket-july-15-2022"
    key = "tfs3obj.txt"
    source = "/home/oem/Documents/s3obj"  
}

# uploading multiple (.txt) files to s3
# resource "aws_s3_bucket_object" "multiple_object" {
    # bucket = "s3-tf-bucket-july-15-2022"
    # for_each = fileset(path.module, "**/*.txt")
    # key = "each.value"
    # source = "${path.module}/${each.value}"
# }
