output "alb_dns_name" {
  value = aws_lb.front.dns_name
}

output "alb_zone_id" {
  value = aws_lb.front.zone_id
}

output "api_alb_target_group_arn" {
  value = aws_lb_target_group.api.arn
}

output "front_alb_target_group_arn" {
  value = aws_lb_target_group.front.arn
}
