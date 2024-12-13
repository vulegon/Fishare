output "api_ecs_log_group_name" {
  value = aws_cloudwatch_log_group.api_ecs_logs.name
}

output "front_ecs_log_group_name" {
  value = aws_cloudwatch_log_group.front_ecs_logs.name
}

output "redis_ecs_log_group_name" {
  value = aws_cloudwatch_log_group.redis_ecs_logs.name
}

output "sidekiq_ecs_log_group_name" {
  value = aws_cloudwatch_log_group.sidekiq_ecs_logs.name
}
