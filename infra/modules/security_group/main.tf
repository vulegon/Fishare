resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-rds-sg"
  description = "RDS Security Group"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Name = "${var.env}-${var.product_name}-rds-sg"
  }
}

resource "aws_security_group" "api_service" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-api-service-sg"
  description = "API Service Security Group"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # 全プロトコル
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.product_name}-api-service-sg"
  }
}

resource "aws_security_group" "api_alb" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-api-alb-sg"
  description = "API ALB Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.product_name}-api-alb-sg"
  }
}

resource "aws_security_group" "front_service" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-front-service-sg"
  description = "front Service Security Group"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # 全プロトコル
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.product_name}-front-service-sg"
  }
}

resource "aws_security_group" "front_alb" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-front-alb-sg"
  description = "FRONT ALB Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.product_name}-front-alb-sg"
  }
}

resource "aws_security_group" "redis_service" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-redis-sg"
  description = "Redis Security Group"

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 全てのアウトバウンド通信を許可
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # 全てのアウトバウンド通信を許可
  }

  tags = {
    Name = "${var.env}-${var.product_name}-redis-service-sg"
  }
}

resource "aws_security_group" "sidekiq_service" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-sidekiq-service-sg"
  description = "Sidekiq Security Group"

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 全てのアウトバウンド通信を許可
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []
  }

  tags = {
    Name = "${var.env}-${var.product_name}-sidekiq-service-sg"
  }
}
