resource "aws_eip" "main" {
  domain = "vpc"

  tags = {
    Name = "main-eip"
  }
}
