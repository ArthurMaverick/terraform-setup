locals {
  aws_ecr_repository = { for key, value in var.aws_ecr_repository : key => value }
}
