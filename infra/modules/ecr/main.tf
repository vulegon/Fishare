resource "aws_ecr_repository" "api_repository" {
  name = "${var.env}-${var.product_name}-api"

  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "${var.env}-${var.product_name}-api"
  }
}

resource "aws_ecr_repository" "front_repository" {
  name = "${var.env}-${var.product_name}-front"

  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "${var.env}-${var.product_name}-front"
  }
}
