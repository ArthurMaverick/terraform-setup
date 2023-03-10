locals {
  aws_instance = { for key, value in var.aws_instance : key => value }
}
