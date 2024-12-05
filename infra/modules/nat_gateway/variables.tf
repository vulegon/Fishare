variable  "env" {
  description = "環境名"
  type        = string
}

variable "product_name" {
  description = "プロダクト名"
  type        = string
}

variable "allocation_id" {
  description = "Elastic IPのAllocation ID"
  type        = string
}

variable "subnet_id" {
  description = "NAT Gatewayを配置するサブネットのID"
  type        = string
}

