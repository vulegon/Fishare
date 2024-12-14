# ECSからRDSへのアクセスを許可するためのセキュリティグループルールを追加する。
resource "aws_security_group_rule" "rds_from_ecs" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.ecs_service_api_sg.id
}

resource "aws_security_group_rule" "redis_from_api" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_service_api_sg.id
  source_security_group_id = aws_security_group.redis_sg.id
}

resource "aws_security_group_rule" "redis_from_sidekiq" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.redis_sg.id
  source_security_group_id = aws_security_group.sidekiq_sg.id
}

resource "aws_security_group_rule" "sidekiq_from_redis" {
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sidekiq_sg.id
  source_security_group_id = aws_security_group.redis_sg.id
}
