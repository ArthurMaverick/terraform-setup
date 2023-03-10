variable "stage" {
  type        = string
  description = "(optional) environment"
}

variable "aws_cloudwatch_log_group" {
  type = object({
    resource          = string
    app               = string
    retention_in_days = number
  })
  description = "(required) variables to create a log group"
}
