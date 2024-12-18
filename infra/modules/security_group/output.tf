output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "api_service_id" {
  value = aws_security_group.api_service.id
}

output "api_alb_id" {
  value = aws_security_group.api_alb.id
}

output "front_service_id" {
  value = aws_security_group.front_service.id
}

output "front_alb_id" {
  value = aws_security_group.front_alb.id
}

output "redis_service_id" {
  value = aws_security_group.redis_service.id
}

output "sidekiq_service_id" {
  value = aws_security_group.sidekiq_service.id
}
