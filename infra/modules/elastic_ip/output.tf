output "elastic_ip_id" {
  value = aws_eip.main.id
}

output "elastic_ip_address" {
  value = aws_eip.main.public_ip
}
