resource "aws_route53_zone" "public" {
  name = var.domain_name
  comment = "公開ホストゾーン"

  tags = {
    Name = "${var.env}-${var.product_name}-zone"
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in var.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      type  = dvo.resource_record_type
      value = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.public.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.value]
  ttl     = var.ttl
}

resource "aws_route53_record" "alias" {
  zone_id = aws_route53_zone.public.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
