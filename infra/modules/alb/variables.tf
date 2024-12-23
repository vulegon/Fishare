variable "vpc_id" {
  description = "VPCのID"
  type        = string
}

variable "env" {
  description = "環境名"
  type        = string
}

variable "product_name" {
  description = "プロダクト名"
  type        = string
}

variable "front_alb_sg_ids" {
  description = "frontセキュリティグループのID"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "パブリックサブネットのID"
  type        = list(string)
}

variable "fishare_certificate_arn" {
  description = "ACM証明書のARN"
  type        = string
}
