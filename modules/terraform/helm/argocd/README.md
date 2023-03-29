## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.60.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.argo_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.git_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argo_chart"></a> [argo\_chart](#input\_argo\_chart) | ArgoCD chart | `string` | `"argo-cd"` | no |
| <a name="input_argo_password"></a> [argo\_password](#input\_argo\_password) | ArgoCD password | `string` | n/a | yes |
| <a name="input_argo_repository"></a> [argo\_repository](#input\_argo\_repository) | ArgoCD repository | `string` | `"https://argoproj.github.io/argo-helm"` | no |
| <a name="input_argo_version"></a> [argo\_version](#input\_argo\_version) | ArgoCD version | `string` | `"5.27.1"` | no |
| <a name="input_git_name"></a> [git\_name](#input\_git\_name) | Git name | `string` | `"github"` | no |
| <a name="input_git_secret"></a> [git\_secret](#input\_git\_secret) | Git secret | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to deploy ArgoCD | `string` | `"argocd-system"` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage to deploy ArgoCD | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_values"></a> [values](#input\_values) | n/a | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "configs.cm.timeout.reconciliation",<br>    "value": "40s"<br>  },<br>  {<br>    "name": "configs.cm.params.applicationsetcontroller.enable.progressive.syncs",<br>    "value": true<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argocd_server_namespace"></a> [argocd\_server\_namespace](#output\_argocd\_server\_namespace) | n/a |
