locals {
  codepipeline = { for key, value in var.codepipeline : key => value }
}
