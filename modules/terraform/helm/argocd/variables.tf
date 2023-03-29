//------------------------------------------------------------------------------
// REQUIRED VARIABLES
//------------------------------------------------------------------------------

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
  description = "Stage to deploy ArgoCD"
}

//------------------------------------------------------------------------------
// OPTIONAL VARIABLES
//------------------------------------------------------------------------------

variable "git_name" {
  type        = string
  description = "Git name"
  default     = "github"
}

variable "namespace" {
  type        = string
  description = "Namespace to deploy ArgoCD"
  default     = "argocd-system"
}

variable "argo_version" {
  type        = string
  description = "ArgoCD version"
  default     = "5.27.1"
}

variable "argo_chart" {
  type        = string
  description = "ArgoCD chart"
  default     = "argo-cd"
}

variable "argo_repository" {
  type        = string
  description = "ArgoCD repository"
  default     = "https://argoproj.github.io/argo-helm"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "values" {
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "configs.cm.timeout.reconciliation"
      value = "40s"
    },
    {
      name  = "configs.cm.params.applicationsetcontroller.enable.progressive.syncs"
      value = true
    }
  ]
}
