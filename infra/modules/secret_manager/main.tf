# AWS Secrets Managerのリソースを作成するためのコード。
# 実際の値はAWS Secrets Managerのコンソールから設定する。

# RDSのユーザー
resource "aws_secretsmanager_secret" "rds_username" {
  name = "${var.env}-${var.product_name}-rds-username"
  description = "RDSのユーザー"

  tags = {
    Name = "${var.env}-${var.product_name}-rds-username"
  }
}

# RDSのパスワード
resource "aws_secretsmanager_secret" "rds_password" {
  name = "${var.env}-${var.product_name}-rds-password"
  description = "RDSのパスワード"

  tags = {
    Name = "${var.env}-${var.product_name}-rds-password"
  }
}

