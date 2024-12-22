resource "aws_lb_target_group" "api" {
  name     = "${var.env}-${var.product_name}-api-tg"
  port     = 3000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health_check"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "${var.env}-${var.product_name}-api-tg"
  }
}

resource "aws_lb_target_group" "front" {
  name     = "${var.env}-${var.product_name}-front-tg"
  port     = 8000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    enabled  = true
    path     = "/health_check"
    port     = 8000
    protocol = "HTTP"
  }

  tags = {
    Name = "${var.env}-${var.product_name}-front-tg"
  }
}
