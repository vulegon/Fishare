output "front_certificate_arn" {
  value = aws_acm_certificate.front_certificate.arn
  description = "front certificate arn"
}

output "api_certificate_arn" {
  value = aws_acm_certificate.api_certificate.arn
  description = "api certificate arn"
}

output "domain_validation_options" {
  value = aws_acm_certificate.front_certificate.domain_validation_options
  description = "The domain validation options for the ACM certificate"
}
