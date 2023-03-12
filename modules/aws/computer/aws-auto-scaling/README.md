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
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS account ID of the account that owns the AMI. | `string` | n/a | yes |
| <a name="input_aws_ami_ids_name"></a> [aws\_ami\_ids\_name](#input\_aws\_ami\_ids\_name) | The name of the AMI (provided during image creation). | `string` | n/a | yes |
| <a name="input_aws_autoscaling_group"></a> [aws\_autoscaling\_group](#input\_aws\_autoscaling\_group) | n/a | <pre>list(object({<br>    name                      = string<br>    max_size                  = number<br>    min_size                  = number<br>    health_check_grace_period = number<br>    health_check_type         = string<br>    desired_capacity          = number<br>    force_delete              = bool<br>    vpc_zone_identifier       = list(string)<br><br>  }))</pre> | `[]` | no |
| <a name="input_aws_launch_template"></a> [aws\_launch\_template](#input\_aws\_launch\_template) | n/a | <pre>list(object({<br>    name_prefix = string<br><br>    /* image_id      = string */<br>    instance_type = string<br>    key_name      = string<br>    ebs_block_device = list(object({<br>      device_name           = string<br>      volume_size           = number<br>      volume_type           = string<br>      delete_on_termination = bool<br>      encrypted             = bool<br>    }))<br>    security_groups = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_tag_name"></a> [tag\_name](#input\_tag\_name) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
