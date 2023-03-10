locals {
  aws_ssm_association = { for key, value in var.aws_ssm_association : key => value }
}
