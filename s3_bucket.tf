resource "aws_s3_bucket" "first" {
  bucket = "nm-s3-bucket"
  acl    = "private"
  # aws_s3_bucket_versioning {
  #     enabled = true
  # }
  tags = {
    Name        = "my-bucket"
    Environment = "DevOps"
  }
}

