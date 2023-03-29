## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.57.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codestarconnections_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarconnections_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_codestarconnections_connection"></a> [aws\_codestarconnections\_connection](#input\_aws\_codestarconnections\_connection) | (required) variables to aws\_codestarconnections\_connection | <pre>object({<br>    name          = string<br>    provider_type = string<br>  })</pre> | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | (optional) environment | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_codestarconnections_connection_arns"></a> [aws\_codestarconnections\_connection\_arns](#output\_aws\_codestarconnections\_connection\_arns) | n/a |
| <a name="output_aws_codestarconnections_connection_names"></a> [aws\_codestarconnections\_connection\_names](#output\_aws\_codestarconnections\_connection\_names) | n/a |
