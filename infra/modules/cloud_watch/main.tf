resource "aws_cloudwatch_log_group" "api_ecs_logs" {
  name              = "/ecs/${var.env}-${var.product_name}-api"
  retention_in_days = 3  # 保存期間を短くしてコスト削減 (必要に応じて変更)
}

resource "aws_cloudwatch_log_group" "front_ecs_logs" {
  name              = "/ecs/${var.env}-${var.product_name}-front"
  retention_in_days = 3  # 保存期間を短くしてコスト削減 (必要に応じて変更)
}

resource "aws_cloudwatch_log_group" "redis_ecs_logs" {
  name              = "/ecs/${var.env}-${var.product_name}-redis"
  retention_in_days = 3  # 保存期間を短くしてコスト削減 (必要に応じて変更)
}

resource "aws_cloudwatch_log_group" "sidekiq_ecs_logs" {
  name              = "/ecs/${var.env}-${var.product_name}-sidekiq"
  retention_in_days = 3  # 保存期間を短くしてコスト削減 (必要に応じて変更)
}
