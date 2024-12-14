resource "aws_ecs_service" "api_service" {
  name            = "${var.env}-${var.product_name}-api-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = var.desired_count

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = var.api_security_group_ids
    assign_public_ip = false
  }
}

resource "aws_ecs_service" "front" {
  name            = "${var.env}-${var.product_name}-front-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.front.arn
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.public_subnet_ids
    security_groups = var.front_security_group_ids
    assign_public_ip = true
  }
}

resource "aws_ecs_service" "redis" {
  name            = "${var.env}-${var.product_name}-redis-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.redis.arn
  desired_count   = var.desired_count

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = var.redis_security_group_ids
    assign_public_ip = false
  }
}

resource "aws_ecs_service" "sidekiq" {
  name            = "${var.env}-${var.product_name}-sidekiq-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.sidekiq.arn
  desired_count   = var.desired_count

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = var.sidekiq_security_group_ids
    assign_public_ip = false
  }
}
