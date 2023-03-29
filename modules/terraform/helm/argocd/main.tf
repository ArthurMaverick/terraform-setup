resource "aws_ssm_parameter" "argo_password" {
  name        = format("/%s/%s/%s", var.stage, "argocd", "password")
  description = format("Password for %s ArgoCD", var.stage)
  value       = var.argo_password
  overwrite   = true
  type        = "SecureString"

  tags = merge({ "Stage" = var.stage }, var.tags)
}

resource "aws_ssm_parameter" "git_secret" {
  name        = format("/%s/%s/%s", var.stage, "git", "password")
  description = format("Secret for %s", var.git_name)
  value       = var.git_secret
  overwrite   = true
  type        = "SecureString"
  tags        = merge({ "Stage" = var.stage }, var.tags)
}

resource "helm_release" "argocd" {
  name             = format("%s-%s", var.stage, "argocd")
  repository       = var.argo_repository
  version          = var.argo_version
  chart            = var.argo_chart
  namespace        = var.namespace
  create_namespace = true
  wait             = true
  cleanup_on_fail  = true
  force_update     = true
  values = [
    file("${path.module}/values.yaml"),
  ]

  set_sensitive {
    name  = "configs.secret.argocdServerAdminPassword"
    value = aws_ssm_parameter.argo_password.value
  }

  set_sensitive {
    name  = "configs.secret.githubSecret"
    value = aws_ssm_parameter.git_secret.value
  }

  dynamic "set" {
    for_each = try(var.values, {})
    content {
      name  = set.value.name
      value = set.value.value
    }
  }
}
