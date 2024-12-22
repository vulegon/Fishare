resource "aws_ecs_service" "api_service" {
  name            = "${var.env}-${var.product_name}-api-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = var.desired_count

  network_configuration {
    subnets          = var.public_subnet_ids
    security_groups  = var.api_service_security_group_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.api_alb_target_group_arn
    container_name   = "${var.env}-${var.product_name}-api"
    container_port   = 3000
  }
}

resource "aws_ecs_service" "front" {
  name            = "${var.env}-${var.product_name}-front-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.front.arn
  desired_count   = var.desired_count

  network_configuration {
    subnets         = var.public_subnet_ids
    security_groups = var.front_service_security_group_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.front_alb_target_group_arn
    container_name   = "${var.env}-${var.product_name}-front"
    container_port   = 8000
  }
}
