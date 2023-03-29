
/* module "kind" {
  source = "../../../modules/k8s/kind"
  stage  = "sandbox"
} */

module "helm_crossplane" {
  source = "../../../modules/k8s/helm/crossplane"
  stage  = var.stage
}

module "helm_argo" {
  source        = "../../../modules/k8s/helm/argocd"
  stage         = var.stage
  argo_password = var.argo_password
  git_secret    = var.git_secret
}
