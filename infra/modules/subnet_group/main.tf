resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.env}-${var.product_name}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids # プライベートサブネットのIDを使用

  tags = {
    Name = "${var.env}-${var.product_name}-rds-subnet-group"
  }
}
