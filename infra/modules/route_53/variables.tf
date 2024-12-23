variable "product_name" {
  description = "プロダクト名"
  type        = string
}

variable "env" {
  description = "環境名"
  type        = string
}

variable "domain_name" {
  description = "FRONTドメイン名"
  type        = string
}

variable "ttl" {
  description = "TTL"
  type        = number
}

variable "domain_validation_options" {
  description = "ドメインのバリデーションオプション"
  type        = any
}

variable "front_alb_dns_name" {
  description = "FRONTDNS名"
  type        = string
}

variable "front_alb_zone_id" {
  description = "FRONTゾーンID"
  type        = string
}
