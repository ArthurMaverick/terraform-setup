variable "stage" {
  type        = string
  description = "(optional) environment"
}

variable "aws_codestarconnections_connection" {
  type = object({
    name          = string
    provider_type = string
  })
  description = "(required) variables to aws_codestarconnections_connection"
}
