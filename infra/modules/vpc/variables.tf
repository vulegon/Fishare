variable "cidr_block" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "name" {
  description = "VPCの名前"
  type        = string
}

variable "enable_dns_support" {
  description = "DNSサポートを有効にするか"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "DNSホスト名を有効にするか"
  type        = bool
}
