resource "aws_lb" "front" {
  name            = "${var.env}-${var.product_name}-front-alb"
  internal        = false
  load_balancer_type = "application"
  subnets         = var.public_subnet_ids
  security_groups = var.front_alb_sg_ids

  tags = {
    Name = "${var.env}-${var.product_name}-front-alb"
  }
}
