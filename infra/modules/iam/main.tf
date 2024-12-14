resource "aws_iam_user" "user" {
  name = "${var.env}-user"
}

resource "aws_iam_group" "developers" {
  name = "${var.env}-developers"
}

resource "aws_iam_group_policy_attachment" "group_policy" {
  group = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_group_membership" "user_group_membership" {
  user = aws_iam_user.user.name
  groups = [aws_iam_group.developers.name]
  depends_on = [aws_iam_group_policy_attachment.group_policy]
}

resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.user.name
}

# タスク実行ロール (execution_role_arn)
resource "aws_iam_role" "ecs_task_execution" {
  name               = "${var.env}-${var.product_name}-ecs-task-execution-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# ECS タスク実行ポリシーアタッチ
resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_logs" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# タスクロール (task_role_arn)
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.env}-${var.product_name}-ecs-task-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# マネージドポリシーアタッチ (S3 & Secrets Manager フルアクセス)
resource "aws_iam_role_policy_attachment" "ecs_task_s3_access" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_task_secretsmanager_access" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}
