## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.9.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helm_argo"></a> [helm\_argo](#module\_helm\_argo) | ../../../modules/k8s/helm/argocd | n/a |
| <a name="module_helm_crossplane"></a> [helm\_crossplane](#module\_helm\_crossplane) | ../../../modules/k8s/helm/crossplane | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argo_password"></a> [argo\_password](#input\_argo\_password) | ArgoCD password | `string` | n/a | yes |
| <a name="input_git_secret"></a> [git\_secret](#input\_git\_secret) | Git secret | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage | `string` | `"demo"` | no |

## Outputs

No outputs.
