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

variable "api_alb_sg_ids" {
  description = "APIセキュリティグループのID"
  type        = list(string)
}

variable "front_alb_sg_ids" {
  description = "frontセキュリティグループのID"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "パブリックサブネットのID"
  type        = list(string)
}

variable "front_certificate_arn" {
  description = "FRONT ACM証明書のARN"
  type        = string
}

variable "api_certificate_arn" {
  description = "API ACM証明書のARN"
  type        = string
}
