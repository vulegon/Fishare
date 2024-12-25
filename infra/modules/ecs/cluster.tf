resource "aws_ecs_cluster" "app_cluster" {
  name = "${var.env}-${var.product_name}-cluster"
}
