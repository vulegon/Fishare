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
  description = "FRONTドメイン名"
}

variable "front_validation_record_fqdns" {
  type        = list(string)
  description = "FRONT ACMのバリデーション用のレコードのFQDN"
}
