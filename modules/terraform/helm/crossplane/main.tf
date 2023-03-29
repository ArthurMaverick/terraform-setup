resource "helm_release" "crossplane" {
  name             = format("%s-%s", var.stage, "crossplane")
  repository       = var.crossplane_repository
  chart            = var.crossplane_chart
  namespace        = var.namespace
  create_namespace = true
  wait             = true
  values = [
    file("${path.module}/crossplane-values.yaml"),
  ]
}
