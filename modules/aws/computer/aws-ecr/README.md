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
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_ecr_repository"></a> [aws\_ecr\_repository](#input\_aws\_ecr\_repository) | (optional) variables to aws\_ecr\_repository | <pre>list(object({<br>    name                 = string<br>    image_tag_mutability = string<br>    scan_on_push         = bool<br>  }))</pre> | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | (optional) environment | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ecr_repository_arn"></a> [aws\_ecr\_repository\_arn](#output\_aws\_ecr\_repository\_arn) | n/a |
| <a name="output_aws_ecr_repository_name"></a> [aws\_ecr\_repository\_name](#output\_aws\_ecr\_repository\_name) | n/a |
| <a name="output_aws_ecr_repository_url"></a> [aws\_ecr\_repository\_url](#output\_aws\_ecr\_repository\_url) | n/a |
