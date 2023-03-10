locals {
  ami_from_instance = { for key, value in var.aws_ami_from_instance : key => value }
}
