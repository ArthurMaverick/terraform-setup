variable "iam" {
  type = list(object({
    stage          = string
    aws_account_id = string
    project        = string
    policy         = string
    services       = list(string)
  }))
}
