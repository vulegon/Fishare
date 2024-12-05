output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "ecs_service_sg_id" {
  value = aws_security_group.ecs_service_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
