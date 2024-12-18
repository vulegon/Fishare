resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "${var.env}-${var.product_name}-public"
  }
}

resource "aws_main_route_table_association" "main" {
  vpc_id          = var.vpc_id
  route_table_id  = aws_route_table.public.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = var.public_subnet_ids[0]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_secondary" {
  subnet_id      = var.public_subnet_ids[1]
  route_table_id = aws_route_table.public.id
}

