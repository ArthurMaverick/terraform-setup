## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_account.dev](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_delegated_administrator.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization) | resource |
| [aws_organizations_organizational_unit.dev](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.workloads](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_root_account_id"></a> [root\_account\_id](#input\_root\_account\_id) | value of the root account id | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_delegated_administrator"></a> [delegated\_administrator](#output\_delegated\_administrator) | The name of the delegated administrator. |
| <a name="output_dev_organizational_unit"></a> [dev\_organizational\_unit](#output\_dev\_organizational\_unit) | Dev OU |
| <a name="output_organization_id"></a> [organization\_id](#output\_organization\_id) | The name of the organization. |
| <a name="output_workloads_organizational_unit"></a> [workloads\_organizational\_unit](#output\_workloads\_organizational\_unit) | workload OU |
