output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ecs_service_api_sg_id" {
  value = aws_security_group.ecs_service_api_sg.id
}

output "ecs_service_front_sg_id" {
  value = aws_security_group.ecs_service_front_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "nat_instance_sg_id" {
  value = aws_security_group.nat_instance_sg.id
}

output "redis_sg_id" {
  value = aws_security_group.redis_sg.id
}

output "sidekiq_sg_id" {
  value = aws_security_group.sidekiq_sg.id
}
