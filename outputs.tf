output "arn" {
  value       = aws_ecr_repository.this.arn
  description = "The ARN of this repository"
}

output "name" {
  value       = aws_ecr_repository.this.name
  description = "The name of this repository"
}

output "url" {
  value       = aws_ecr_repository.this.repository_url
  description = "The URL of this repository"
}

