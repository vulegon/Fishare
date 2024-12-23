resource "aws_lb_target_group" "api" {
  name     = "${var.env}-${var.product_name}-api-tg"
  port     = 3000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/api/v1/health_check"
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
    path                = "/"      # React のルートパス
    interval            = 30       # ヘルスチェックの間隔 (秒)
    timeout             = 5        # ヘルスチェック応答のタイムアウト (秒)
    healthy_threshold   = 3        # 正常とみなす応答回数
    unhealthy_threshold = 3        # 異常とみなす応答回数
    matcher             = "200"    # HTTP ステータスコードが 200 の場合に正常と判断
  }

  tags = {
    Name = "${var.env}-${var.product_name}-front-tg"
  }
}
