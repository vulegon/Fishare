resource "aws_acm_certificate" "front_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.env}-${var.product_name}-front-certificate"
  }
}

resource "aws_acm_certificate" "api_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.env}-${var.product_name}-api-certificate"
  }
}

resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.front_certificate.arn
  validation_record_fqdns = var.validation_record_fqdns
}
