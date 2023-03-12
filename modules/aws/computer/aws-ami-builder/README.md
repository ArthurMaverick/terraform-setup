## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.57.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_imagebuilder_distribution_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_distribution_configuration) | resource |
| [aws_imagebuilder_image.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/imagebuilder_image) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_builder"></a> [ami\_builder](#input\_ami\_builder) | values for aws\_imagebuilder\_image | <pre>list(object({<br>    /* project name */<br>    project = string<br>    /* random id */<br>    keepers     = string<br>    byte_length = number<br>    /* aws_imagebuilder_image */<br>    owner_tag        = string<br>    image_recipe_arn = string<br>    /*  aws_imagebuilder_distribution_configuration*/<br>    region  = string<br>    ami_tag = string<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_ids"></a> [ami\_ids](#output\_ami\_ids) | n/a |
| <a name="output_aws_imagebuilder_distribution_configurations"></a> [aws\_imagebuilder\_distribution\_configurations](#output\_aws\_imagebuilder\_distribution\_configurations) | n/a |
| <a name="output_aws_imagebuilder_images"></a> [aws\_imagebuilder\_images](#output\_aws\_imagebuilder\_images) | n/a |
