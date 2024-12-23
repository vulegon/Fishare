output "fishare_certificate_arn" {
  value = aws_acm_certificate.fishare_certificate.arn
  description = "front certificate arn"
}

output "domain_validation_options" {
  value = aws_acm_certificate.fishare_certificate.domain_validation_options
  description = "The domain validation options for the ACM certificate"
}
