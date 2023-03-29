output "github_token" {
  value       = data.aws_ssm_parameter.github_token.value
  description = "github_token"
  sensitive   = true
}

output "private_key_bucket" {
  value       = data.aws_ssm_parameter.private_key_bucket.value
  description = "private_key_bucket"
  sensitive   = true
}
