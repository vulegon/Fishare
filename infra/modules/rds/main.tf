resource "aws_db_instance" "postgresql" {
  allocated_storage    = 20                         # 無料枠では最大20GBまで
  engine               = "postgres"                # PostgreSQLを指定
  engine_version       = "16.3"                    # PostgreSQLのバージョン（例: 13.4）
  instance_class       = "db.t3.micro"            # 無料枠のインスタンスクラス
  db_name              = "${var.env}_${var.product_name}_db"          # データベース名
  username             = var.db_username           # 管理ユーザー名
  password             = var.db_password           # パスワード（要複雑性）
  parameter_group_name = "default.postgres16"      # デフォルトのパラメータグループ
  db_subnet_group_name = var.subnet_group_name # サブネットグループ
  publicly_accessible  = false                     # セキュリティのため、公開不可
  multi_az             = false                     # マルチAZは無料枠外
  storage_type         = "gp2"                     # 標準的な汎用SSD
  vpc_security_group_ids = var.vpc_security_group_ids # RDS用セキュリティグループ
  availability_zone  = var.availability_zone
  skip_final_snapshot = false
  final_snapshot_identifier = "${var.env}-${var.product_name}-postgresql-final-snapshot"

  tags = {
    Name = "${var.env}-${var.product_name}-postgresql"
  }
}
