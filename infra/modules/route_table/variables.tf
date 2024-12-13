variable "vpc_id" {
  description = "VPCのID"
  type        = string
}

variable "internet_gateway_id" {
  description = "インターネットゲートウェイのID"
  type        = string
}

variable  "env" {
  description = "環境名"
  type        = string
}

variable "product_name" {
  description = "プロダクト名"
  type        = string
}

variable "public_subnet_id" {
  description = "パブリックサブネットのID"
  type        = string
}

variable "private_subnet_id" {
  description = "プライベートサブネットのID"
  type        = string
}
