output "aws_ami_id" {
  value = [for value in aws_ami_from_instance.this : value.id]
}
