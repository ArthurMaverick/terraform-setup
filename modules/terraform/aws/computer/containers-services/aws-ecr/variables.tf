variable "stage" {
  type        = string
  description = "(optional) environment"
}

variable "aws_ecr_repository" {
  type = list(object({
    name                 = string
    image_tag_mutability = string
    scan_on_push         = bool
  }))
  description = "(optional) variables to aws_ecr_repository"
}
