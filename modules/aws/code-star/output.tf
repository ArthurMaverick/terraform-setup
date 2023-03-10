output "aws_codestarconnections_connection_names" {
  value = aws_codestarconnections_connection.this.name
}

output "aws_codestarconnections_connection_arns" {
  value = aws_codestarconnections_connection.this.arn
}
