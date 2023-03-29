variable "argo_password" {
  type        = string
  sensitive   = true
  description = "ArgoCD password"
}

variable "git_secret" {
  type        = string
  sensitive   = true
  description = "Git secret"
}

variable "stage" {
  type        = string
  description = "Stage"
  default     = "demo"
}
