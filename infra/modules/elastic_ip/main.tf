resource "aws_eip" "main" {
  domain = "vpc"
  instance = var.nat_instance_id

  tags = {
    Name = "${var.env}-${var.product_name}-main-eip"
  }
}
