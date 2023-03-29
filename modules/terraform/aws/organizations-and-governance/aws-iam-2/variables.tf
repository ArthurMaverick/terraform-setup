variable "stage" {
  type        = string
  description = "The stage of the infrastructure."
  default     = "dev"
}

variable "project" {
  type        = string
  description = "The project name of the infrastructure."
  default     = "project"
}

variable "policies" {
  type = list(object({
    sid        = string
    effect     = string
    actions    = list(string)
    resources  = list(string)
    principals = map(string)
    condition  = map(string)
  }))
  default = [
    {
      sid        = "AllowAll"
      effect     = "Allow"
      actions    = ["*"]
      resources  = ["*"]
      principals = {}
      condition  = {}
    },
  ]
}
