variable "product_name" {
  description = "プロダクト名"
  type        = string
}

variable "env" {
  description = "環境名"
  type        = string
}

variable "domain_name" {
  description = "ドメイン名"
  type        = string
}

variable "ttl" {
  description = "TTL"
  type        = number
}

variable "domain_validation_options" {
  description = "The domain validation options for the ACM certificate"
  type        = any
}

variable "alb_dns_name" {
  description = "DNS名"
  type        = string
}

variable "alb_zone_id" {
  description = "ゾーンID"
  type        = string
}
