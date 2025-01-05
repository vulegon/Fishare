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

resource "aws_s3_bucket" "support_contact_image_bucket" {
  bucket = "${var.env}-${var.product_name}-support-contact-images"

  tags = {
    Name = "${var.env}-${var.product_name}-support-contact-images"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "support_contact_image_bucket_encryption" {
  bucket = aws_s3_bucket.support_contact_image_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "support_contact_image_bucket_versioning" {
  bucket = aws_s3_bucket.support_contact_image_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# パブリックアクセスを制御（必要に応じて設定）
resource "aws_s3_bucket_public_access_block" "support_contact_image_bucket_public_access" {
  bucket                  = aws_s3_bucket.support_contact_image_bucket.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "support_contact_image_bucket_cors" {
  bucket = aws_s3_bucket.support_contact_image_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "PUT"]
    allowed_origins = ["https://${var.domain_name}"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_policy" "image_upload_bucket_policy" {
  bucket = aws_s3_bucket.support_contact_image_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowPresignedUrlActions",
        Effect    = "Allow",
        Principal = "*", # 特定のユーザーやサービスを指定する場合、ここを変更
        Action    = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource  = "${aws_s3_bucket.support_contact_image_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "s3:signatureversion" = "AWS4-HMAC-SHA256" # 署名付きURLを前提
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket" "fishing_spot_image_bucket" {
  bucket = "${var.env}-${var.product_name}-fishing-spot-images"

  tags = {
    Name = "${var.env}-${var.product_name}-fishing-spot-images"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "fishing_spot_image_bucket_encryption" {
  bucket = aws_s3_bucket.fishing_spot_image_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "fishing_spot_image_bucket_versioning" {
  bucket = aws_s3_bucket.fishing_spot_image_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# パブリックアクセスを制御（必要に応じて設定）
resource "aws_s3_bucket_public_access_block" "fishing_spot_image_bucket_public_access" {
  bucket                  = aws_s3_bucket.fishing_spot_image_bucket.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_cors_configuration" "fishing_spot_image_bucket_cors" {
  bucket = aws_s3_bucket.fishing_spot_image_bucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "PUT"]
    allowed_origins = ["https://${var.domain_name}"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_policy" "fishing_spot_image_upload_bucket_policy" {
  bucket = aws_s3_bucket.fishing_spot_image_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowPresignedUrlActions",
        Effect    = "Allow",
        Principal = "*", # 特定のユーザーやサービスを指定する場合、ここを変更
        Action    = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource  = "${aws_s3_bucket.fishing_spot_image_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "s3:signatureversion" = "AWS4-HMAC-SHA256" # 署名付きURLを前提
          }
        }
      }
    ]
  })
}
