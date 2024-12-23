output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "api_service_id" {
  value = aws_security_group.api_service.id
}

output "front_service_id" {
  value = aws_security_group.front_service.id
}

output "front_alb_id" {
  value = aws_security_group.front_alb.id
}
