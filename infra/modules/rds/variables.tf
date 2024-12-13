variable "env" {
  description = "環境名"
  type        = string
}

variable "product_name" {
  description = "プロダクト名"
  type        = string
}

variable "db_username" {
  description = "RDSのユーザー名"
  type        = string
}

variable "db_password" {
  description = "RDSのパスワード"
  type        = string
}

variable "subnet_group_name" {
  description = "サブネットグループの名前"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "VPCのセキュリティグループID"
  type        = list(string)
}

variable "availability_zone" {
  description = "利用するAZ"
  type        = string
}
