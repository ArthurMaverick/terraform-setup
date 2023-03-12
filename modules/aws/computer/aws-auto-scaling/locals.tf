locals {
  aws_autoscaling_group = { for key, value in var.aws_autoscaling_group : key => value }
  aws_launch_template   = { for key, value in var.aws_launch_template : key => value }
}
