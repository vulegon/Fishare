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

resource "aws_security_group" "ecs_service_sg" {
  vpc_id = var.vpc_id
  name = "${var.env}-${var.product_name}-ecs-sg"
  description = "ECS Service Security Group"

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
    Name = "${var.env}-${var.product_name}-ecs-sg"
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

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.private_subnet_cidr] # プライベートサブネットからのHTTPを許可
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.private_subnet_cidr] # プライベートサブネットからのHTTPSを許可
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.my_ips # 自分のIPアドレスからSSHを許可
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # すべてのIPアドレスからHTTPを許可
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # すべてのIPアドレスからHTTPSを許可
  }
  tags = {
    Name = "${var.env}-${var.product_name}-nat-instance-sg"
  }
}
