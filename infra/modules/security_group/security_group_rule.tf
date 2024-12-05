# ECSからRDSへのアクセスを許可するためのセキュリティグループルールを追加する。
resource "aws_security_group_rule" "rds_from_ecs" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.ecs_service_sg.id
}
