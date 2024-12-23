output "front_validation_record_fqdns" {
  value = [for record in aws_route53_record.front_validation : record.fqdn]
}
