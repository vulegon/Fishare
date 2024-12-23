resource "aws_acm_certificate" "fishare_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.env}-${var.product_name}-certificate"
  }
}

resource "aws_acm_certificate_validation" "fishare_certificate_validation" {
  certificate_arn         = aws_acm_certificate.fishare_certificate.arn
  validation_record_fqdns = var.front_validation_record_fqdns
}
