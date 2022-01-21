provider "aws" {
  region     = "us-west-2"
  shared_credentials_file = "C:/Users/aarthi.reddy.tumu/terraform/s3bucket/creds/cloud_user"
  profile = "cloud_user"
}

resource "aws_s3_bucket" "myfirstbuck" {
  bucket = "myfirstbuck-f186790"
  acl    = "private"
  #region = "us-west-2"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "myfirstobj" {
  bucket = "${aws_s3_bucket.myfirstbuck.id}"
  key    = "hello.html"
  source = "C:/Users/aarthi.reddy.tumu/terraform/s3bucket/hello.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("C:/Users/aarthi.reddy.tumu/terraform/s3bucket/hello.html")
}