output "lambda_function_arn" {
  value = aws_lambda_function.this.arn
}

output "lambda_function_name" {
  value = aws_lambda_function.this.function_name
}

output "lambda_function_id" {
  value = aws_lambda_function.this.id
}

output "lambda_function_tags" {
  value = aws_lambda_function.this.tags
}

output "lambda_function_version" {
  value = aws_lambda_function.this.version
}

output "lambda_function_invoke_arn" {
  value = aws_lambda_function.this.invoke_arn
}
