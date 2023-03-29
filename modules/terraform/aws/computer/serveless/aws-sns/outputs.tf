output "sns_topic_arn" {
  value       = aws_sns_topic.this.arn
  description = "SNS topic ARN"
}

output "sns_topic_name" {
  value       = aws_sns_topic.this.name
  description = "SNS topic name"
}

output "sns_topic_id" {
  value       = aws_sns_topic.this.id
  description = "SNS topic id"
}

output "sns_topic_tags" {
  value       = aws_sns_topic.this.tags
  description = "SNS topic display name"
}
