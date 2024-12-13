output "ssl_certificate_arn" {
  value = aws_acm_certificate.ssl_certificate.arn
  description = "The ARN of the ACM certificate"
}

output "domain_validation_options" {
  value = aws_acm_certificate.ssl_certificate.domain_validation_options
  description = "The domain validation options for the ACM certificate"
}
