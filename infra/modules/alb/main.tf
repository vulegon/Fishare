resource "aws_lb" "alb" {
  name            = "${var.env}-${var.product_name}-alb"
  internal        = false
  load_balancer_type = "application"
  security_groups = var.security_group_ids
  subnets         = var.subnet_ids

  tags = {
    Name = "${var.env}-${var.product_name}-alb"
  }
}
