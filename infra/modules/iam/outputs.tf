output "user_name" {
  value = aws_iam_user.user.name
}

output "group_name" {
  value = aws_iam_group.developers.name
}

output "user_group_membership" {
  value = aws_iam_user_group_membership.user_group_membership.groups
}

output "group_policy_arn" {
  value = aws_iam_group_policy_attachment.group_policy.policy_arn
}

output "access_key_id" {
  value = aws_iam_access_key.access_key.id
  sensitive = true
}

output "secret_access_key" {
  value = aws_iam_access_key.access_key.secret
  sensitive = true
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}
