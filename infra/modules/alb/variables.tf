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

variable "security_group_ids" {
  description = "セキュリティグループのID"
  type        = list(string)
}

variable "subnet_ids" {
  description = "サブネットのID"
  type        = list(string)
}

variable "certificate_arn" {
  description = "ACM証明書のARN"
  type        = string
}
