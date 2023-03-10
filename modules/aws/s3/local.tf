locals {
  s3 = { for key, value in var.s3 : key => value }
}
