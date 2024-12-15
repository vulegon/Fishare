resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-alb-sg"
  description = "ALB Security Group: Allow traffic on ports 80 (HTTP) and 443 (HTTPS)"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # すべてのIPアドレスからHTTPを許可
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # すべてのIPアドレスからHTTPSを許可
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # 全プロトコル
    cidr_blocks = ["0.0.0.0/0"] # 全ての宛先を許可
  }

  tags = {
    Name = "${var.env}-${var.product_name}-alb-sg"
  }
}

resource "aws_security_group" "ecs_service_api_sg" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-ecs-api-sg"
  description = "ECS Service API Security Group"

  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    security_groups = [aws_security_group.alb_sg.id] # ALBからのHTTPを許可
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # 全プロトコル
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.product_name}-ecs-api-sg"
  }
}

resource "aws_security_group" "ecs_service_front_sg" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-ecs-front-sg"
  description = "ECS Service Front Security Group"

# インターネットからのHTTPアクセスを許可
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 全世界からのアクセス
  }

  # HTTPSも許可（必要なら）
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # APIへのアクセス許可
  egress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_service_api_sg.id] # APIへのアウトバウンド
  }

  # すべてのアウトバウンドを許可
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.product_name}-front-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-rds-sg"
  description = "RDS Security Group"

  tags = {
    Name = "${var.env}-${var.product_name}-rds-sg"
  }
}

resource "aws_security_group" "nat_instance_sg" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-nat-instance-sg"
  description = "NAT Instance Security Group"

  # プライベートサブネットからのすべての通信を許可
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.private_subnet_cidr]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.my_ips # 自分のIPアドレスからSSHを許可
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.product_name}-nat-instance-sg"
  }
}

resource "aws_security_group" "redis_sg" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-redis-sg"
  description = "Redis Security Group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # 全てのアウトバウンド通信を許可
  }

  tags = {
    Name = "${var.env}-${var.product_name}-redis-sg"
  }
}

resource "aws_security_group" "sidekiq_sg" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-sidekiq-sg"
  description = "Sidekiq Security Group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # 全てのアウトバウンド通信を許可
  }
}
