//------------------------------------------------------------------------------
// REQUIRED VARIABLES
//------------------------------------------------------------------------------
variable "stage" {
  type        = string
  description = "Stage to install Crossplane into"
}

//------------------------------------------------------------------------------
// OPTIONAL VARIABLES
//------------------------------------------------------------------------------
variable "namespace" {
  type        = string
  description = "Namespace to install Crossplane into"
  default     = "crossplane-system"
}

variable "crossplane_repository" {
  type        = string
  description = "Crossplane Helm repository"
  default     = "https://charts.crossplane.io/stable"
}

variable "crossplane_chart" {
  type        = string
  description = "Crossplane Helm chart name"
  default     = "crossplane"
}
