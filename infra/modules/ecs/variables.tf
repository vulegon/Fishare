variable "env" {
  description = "環境名"
  type        = string
}

variable "product_name" {
  description = "プロダクト名"
  type        = string
}

variable "desired_count" {
  description = "起動するコンテナ数"
  type        = number
}

variable "api_service_security_group_ids" {
  description = "apiセキュリティグループID"
  type        = list(string)
}

variable "front_service_security_group_ids" {
  description = "frontセキュリティグループID"
  type        = list(string)
}

variable "redis_service_security_group_ids" {
  description = "redisセキュリティグループID"
  type        = list(string)
}

variable "sidekiq_service_security_group_ids" {
  description = "sidekiqセキュリティグループID"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "パブリックサブネットID"
  type        = list(string)
}

variable "ecs_task_execution_role_arn" {
  description = "ECS タスク実行ロールのARN"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ECS タスクロールのARN"
  type        = string
}

variable "api_repository_url" {
  description = "API用コンテナイメージのECRリポジトリURL"
  type        = string
}

variable "front_repository_url" {
  description = "フロント用コンテナイメージのECRリポジトリURL"
  type        = string
}

variable "redis_repository_url" {
  description = "Redis用コンテナイメージのECRリポジトリURL"
  type        = string
}

variable "sidekiq_repository_url" {
  description = "Sidekiq用コンテナイメージのECRリポジトリURL"
  type        = string
}

variable "api_ecs_log_group_name" {
  description = "API用ECSロググループ"
  type        = string
}

variable "front_ecs_log_group_name" {
  description = "フロント用ECSロググループ"
  type        = string
}

variable "redis_ecs_log_group_name" {
  description = "Redis用ECSロググループ"
  type        = string
}

variable "sidekiq_ecs_log_group_name" {
  description = "Sidekiq用ECSロググループ"
  type        = string
}

variable "api_alb_target_group_arn" {
  description = "API用ALBのターゲットグループARN"
  type        = string
}

variable "front_alb_target_group_arn" {
  description = "フロント用ALBのターゲットグループARN"
  type        = string
}
