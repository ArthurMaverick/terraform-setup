output "aws_ecr_repository_name" {
  value = [for value in aws_ecr_repository.this : value.name]

}

output "aws_ecr_repository_arn" {
  value = [for value in aws_ecr_repository.this : value.arn]
}

output "aws_ecr_repository_url" {
  value = [for value in aws_ecr_repository.this : value.repository_url]
}
