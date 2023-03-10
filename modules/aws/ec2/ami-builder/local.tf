locals {
  ami_builder = { for key, value in var.ami_builder : key => value }
}
