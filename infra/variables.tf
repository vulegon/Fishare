variable "env" {
  type        = string
  description = "環境名"
}

variable "product_name" {
  type        = string
  description = "プロダクト名"
}

variable "domain_name" {
  type        = string
  description = "ドメイン名"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "パブリックサブネットのCIDR"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "プライベートサブネットのCIDR"
}

variable "tokyo_availability_zone" {
  type        = string
  description = "東京のアベイラビリティゾーン"
}

variable "osaka_availability_zone" {
  type        = string
  description = "大阪のアベイラビリティゾーン"
}
