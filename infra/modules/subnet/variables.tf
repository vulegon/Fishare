variable "vpc_id" {
  description = "VPCのID"
  type        = string
}

variable "name" {
  description = "サブネットの名前"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "パブリックサブネットのCIDRブロック"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "プライベートサブネットのCIDRブロック"
  type        = list(string)
}

variable "target_availability_zones" {
  description = "サブネットを作成するAZ"
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1c"] # 必要なゾーンだけ指定
}
