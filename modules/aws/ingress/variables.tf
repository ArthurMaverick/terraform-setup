variable "security_groups" {
  type = list(object({
    name        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  description = "rules to be added to the ingress of the security group"
}

variable "app" {
  type        = string
  description = "name of the application"
}

variable "stage" {
  type        = string
  description = "environment of the application"
}

variable "vpc_id" {
  type        = string
  description = "value of the VPC ID"
}
