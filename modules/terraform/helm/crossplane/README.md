## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.crossplane](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_crossplane_chart"></a> [crossplane\_chart](#input\_crossplane\_chart) | Crossplane Helm chart name | `string` | `"crossplane"` | no |
| <a name="input_crossplane_repository"></a> [crossplane\_repository](#input\_crossplane\_repository) | Crossplane Helm repository | `string` | `"https://charts.crossplane.io/stable"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to install Crossplane into | `string` | `"crossplane-system"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage to install Crossplane into | `string` | n/a | yes |

## Outputs

No outputs.
