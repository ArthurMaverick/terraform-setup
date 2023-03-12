output "aws_s3_bucket_arns" {
  value = { for key, value in aws_s3_bucket.this : var.s3[key].bucket => value.arn }
}

output "aws_s3_bucket_ids" {
  value = { for key, value in aws_s3_bucket.this : var.s3[key].bucket => value.id }
}
