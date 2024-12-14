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

variable "validation_record_fqdns" {
  type        = list(string)
  description = "ACMのバリデーション用のレコードのFQDN"
}
