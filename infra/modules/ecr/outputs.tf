output "api_repository_url" {
  value = aws_ecr_repository.api_repository.repository_url
}

output "front_repository_url" {
  value = aws_ecr_repository.front_repository.repository_url
}
