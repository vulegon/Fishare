variable "env" {
  description = "環境名"
  type        = string
}

variable "product_name" {
  description = "プロダクト名"
  type        = string
}

variable "private_subnet_ids" {
  description = "プライベートサブネットのID"
  type        = list(string)
}
