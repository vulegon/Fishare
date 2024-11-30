resource "aws_s3_bucket" "fishare_image_bucket" {
  bucket = "${var.env}-fishare"

  tags = {
    Name = "${var.env}-fishare"
    Product = var.product_name
    Purpose = "${var.env} ${var.product_name} image bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "fishare_image_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.fishare_image_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "fishare_image_bucket_acl" {
  bucket = aws_s3_bucket.fishare_image_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_cors_configuration" "fishare_image_bucket_cors_rule" {
  bucket = aws_s3_bucket.fishare_image_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["HEAD", "GET", "PUT", "POST", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
  }
}
