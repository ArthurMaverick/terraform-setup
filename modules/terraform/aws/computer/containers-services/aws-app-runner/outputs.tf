output "arn" {
  value       = aws_apprunner_service.this.arn
  description = "ARN of the App Runner service."
}
