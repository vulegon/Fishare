resource "aws_ecs_task_definition" "api" {
  family                   = "${var.env}-${var.product_name}-api-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "${var.env}-${var.product_name}-api"
      image     = var.api_repository_url
      command = ["bundle", "exec", "rails", "s", "-p", "3000", "-b"]
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
          value = "${var.env}"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.api_ecs_log_group_name
          awslogs-region        = var.log_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "front" {
  family                   = "${var.env}-${var.product_name}-front-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = var.ecs_task_role_arn

  container_definitions = jsonencode([
    {
      name      = "${var.env}-${var.product_name}-front"
      image     = var.front_repository_url
      command = ["npm", "start"]
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      environment = [
        {
          name = "NODE_ENV"
          value = "${var.env}"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.front_ecs_log_group_name
          awslogs-region        = var.log_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "redis" {
  family                   = "${var.env}-${var.product_name}-redis-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "${var.env}-${var.product_name}-redis"
      image     = var.redis_repository_url
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
          awslogs-region        = var.log_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "sidekiq" {
  family                   = "${var.env}-${var.product_name}-sidekiq-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.ecs_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "${var.env}-${var.product_name}-sidekiq"
      image     = var.api_repository_url
      essential = true
      command = ["bundle", "exec", "sidekiq"]

      environment = [
        {
          name = "RAILS_ENV"
          value = "${var.env}"
        },
        {
          name = "REDIS_URL"
          value = "redis://redis:6379/1"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.sidekiq_ecs_log_group_name
          awslogs-region        = var.log_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
