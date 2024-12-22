resource "aws_ecs_task_definition" "api" {
  family                   = "${var.env}-${var.product_name}-api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"

  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "${var.env}-${var.product_name}-api"
      image     = "${var.api_repository_url}:latest"
      command = ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = [
        {
          name = "RAILS_ENV"
          value = var.env
        },
        {
          name = "REDIS_URL"
          value = "redis://localhost:6379/1"
        }
      ]
      secrets = [
        {
          name      = "RAILS_MASTER_KEY"
          valueFrom = var.api_rails_master_key_arn
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.api_ecs_log_group_name
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    },
    {
      name      = "${var.env}-${var.product_name}-redis"
      image     = "redis:alpine"
      essential = true
      portMappings = [
        {
          containerPort = 6379
          hostPort      = 6379
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.redis_ecs_log_group_name
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    },
    {
      name      = "${var.env}-${var.product_name}-sidekiq"
      image     = "${var.api_repository_url}:latest"
      command = ["bundle", "exec", "sidekiq"]
      essential = true
      environment = [
        {
          name = "RAILS_ENV"
          value = var.env
        },
        {
          name = "REDIS_URL"
          value = "redis://localhost:6379/1"
        }
      ]
      secrets = [
        {
          name      = "RAILS_MASTER_KEY"
          valueFrom = var.api_rails_master_key_arn
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.sidekiq_ecs_log_group_name
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "front" {
  family                   = "${var.env}-${var.product_name}-front"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"

  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "${var.env}-${var.product_name}-front"
      image     = "${var.front_repository_url}:latest"
      command = ["serve", "-s", "build", "-l", "8000"]
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
      environment = [
        {
          name = "NODE_ENV"
          value = var.env
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.front_ecs_log_group_name
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
