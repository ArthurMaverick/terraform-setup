output "argocd_server_namespace" {
  value = helm_release.argocd.namespace
}
