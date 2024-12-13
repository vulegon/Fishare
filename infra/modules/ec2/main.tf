# NATインスタンスのEC2リソースを作成するためのコードを追加します。
resource "aws_instance" "nat_instance" {
  ami           = var.nat_ami
  instance_type = var.nat_instance_type
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = var.nat_security_group_ids
  source_dest_check = false

  tags = {
    Name = "${var.env}-${var.product_name}-nat-instance"
  }
}
