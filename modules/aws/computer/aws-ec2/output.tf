output "aws_instance_id" {
  value = [for value in aws_instance.this : value.id]
}

output "aws_instance_arn" {
  value = [for value in aws_instance.this : value.arn]
}

output "aws_instance_public_ip" {
  value = [for value in aws_instance.this : value.public_ip]
}

output "ami_id" {
  value = data.aws_ami.amazon_linux_2.id
}
