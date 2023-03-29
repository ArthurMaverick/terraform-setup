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
| [aws_controltower_control.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_control) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organizational_units.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organizational_units) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization_unit_name"></a> [organization\_unit\_name](#input\_organization\_unit\_name) | The name of the organization unit to apply the control to | `string` | `"Root"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_control_identifier"></a> [control\_identifier](#output\_control\_identifier) | The control identifier of the control tower control |
| <a name="output_name"></a> [name](#output\_name) | The name of the control tower control |
| <a name="output_target_identifier"></a> [target\_identifier](#output\_target\_identifier) | The target identifier of the control tower control |
