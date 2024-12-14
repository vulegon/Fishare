variable  "env" {
  description = "環境名"
  type        = string
}

variable "product_name" {
  description = "プロダクト名"
  type        = string
}

variable "nat_ami" {
  description = "AMI"
  type        = string
}

variable "nat_instance_type" {
  description = "インスタンスタイプ"
  type        = string
}

variable "public_subnet_id" {
  description = "パブリックサブネットのID"
  type        = string
}

variable "nat_security_group_ids" {
  description = "NATインスタンスのセキュリティグループID"
  type        = list(string)
}

