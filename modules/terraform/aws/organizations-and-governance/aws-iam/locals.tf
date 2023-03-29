locals {
  iam = { for key, value in var.iam : key => value }

  policies = [
    for value in var.iam : { format(value.policy) : file("${path.module}/policies/${value.policy}.json") }
  ]
}
