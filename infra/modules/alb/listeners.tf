# HTTP リスナー（リダイレクト用）
resource "aws_lb_listener" "front_http_listener" {
  load_balancer_arn = aws_lb.front.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name = "${var.env}-${var.product_name}-front-http-listener"
  }
}

resource "aws_lb_listener" "api_http_listener" {
  load_balancer_arn = aws_lb.api.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }

  tags = {
    Name = "${var.env}-${var.product_name}-api-http-listener"
  }
}

# HTTPS リスナー
resource "aws_lb_listener" "front_https_listener" {
  load_balancer_arn = aws_lb.front.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.front_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front.arn
  }

  tags = {
    Name = "${var.env}-${var.product_name}-front-https-listener"
  }
}

resource "aws_lb_listener" "api_https_listener" {
  load_balancer_arn = aws_lb.api.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.api_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }

  tags = {
    Name = "${var.env}-${var.product_name}-api-https-listener"
  }
}
