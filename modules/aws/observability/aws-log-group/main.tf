locals {
  resource = var.aws_cloudwatch_log_group.resource
  app      = var.aws_cloudwatch_log_group.app
}

resource "aws_cloudwatch_log_group" "this" {
  name              = join("/", tolist(["aws", local.resource, var.stage, local.app]))
  retention_in_days = var.aws_cloudwatch_log_group.retention_in_days
}
