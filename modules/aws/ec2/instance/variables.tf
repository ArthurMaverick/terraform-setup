variable "stage" {
  type        = string
  description = "Stage of the application"
}

variable "aws_instance" {
  type = list(object({
    project            = string
    repository         = string
    instance_type      = string
    key_pair           = string
    security_group_ids = list(string)
    subnet_id          = string

    root_block_device = object({
      delete_on_termination = bool
      encrypted             = bool
      volume_size           = number
      volume_type           = string
    })
  }))
  description = "List of objects containing values for the aws_instance resource"
}
