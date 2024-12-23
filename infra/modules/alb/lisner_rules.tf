resource "aws_lb_listener_rule" "front_rule" {
  listener_arn = aws_lb_listener.front_https_listener.arn
  priority     = 20

  condition {
    path_pattern {
      values = ["/*"] # ルートパスを指定
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front.arn
  }
}

resource "aws_lb_listener_rule" "api_rule" {
  listener_arn = aws_lb_listener.front_https_listener.arn
  priority     = 10

  condition {
    path_pattern {
      values = ["/api/*"] # API パスを指定
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}
