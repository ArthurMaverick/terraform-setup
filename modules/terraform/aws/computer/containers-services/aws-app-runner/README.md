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
| [aws_apprunner_auto_scaling_configuration_version.autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_auto_scaling_configuration_version) | resource |
| [aws_apprunner_connection.connetion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_connection) | resource |
| [aws_apprunner_custom_domain_association.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_custom_domain_association) | resource |
| [aws_apprunner_observability_configuration.observability_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_observability_configuration) | resource |
| [aws_apprunner_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_service) | resource |
| [aws_apprunner_vpc_connector.connector](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_vpc_connector) | resource |
| [aws_apprunner_vpc_ingress_connection.vpc_ingress_connection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apprunner_vpc_ingress_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_runner_name"></a> [app\_runner\_name](#input\_app\_runner\_name) | The name of the App Runner service. | `string` | n/a | yes |
| <a name="input_auto_deployments_enabled"></a> [auto\_deployments\_enabled](#input\_auto\_deployments\_enabled) | Whether to enable automatic deployments for the App Runner service. | `bool` | `true` | no |
| <a name="input_code_repository"></a> [code\_repository](#input\_code\_repository) | The code repository configuration for the App Runner service. | `map(string)` | `{}` | no |
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | The ARN of the App Runner connection to use for the App Runner service. | `string` | `""` | no |
| <a name="input_health_threshold"></a> [health\_threshold](#input\_health\_threshold) | The number of consecutive health checks successes required before considering an unhealthy target healthy. | `number` | `2` | no |
| <a name="input_image_repository"></a> [image\_repository](#input\_image\_repository) | The image repository configuration for the App Runner service. | `map(string)` | `{}` | no |
| <a name="input_interval"></a> [interval](#input\_interval) | The time interval between health checks. | `number` | `5` | no |
| <a name="input_is_publicly_accessible"></a> [is\_publicly\_accessible](#input\_is\_publicly\_accessible) | Whether the App Runner service is publicly accessible. | `bool` | `true` | no |
| <a name="input_max_concurrency"></a> [max\_concurrency](#input\_max\_concurrency) | The maximum number of concurrent deployments. | `number` | `2` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum number of instances that can be scaled up to. | `number` | `2` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum number of instances that can be scaled down to. | `number` | `1` | no |
| <a name="input_observability_enabled"></a> [observability\_enabled](#input\_observability\_enabled) | Whether to enable observability for the App Runner service. | `bool` | `true` | no |
| <a name="input_path"></a> [path](#input\_path) | The path to the health check. | `string` | `"/"` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol to use for the health check. | `string` | `"HTTP"` | no |
| <a name="input_provider_type"></a> [provider\_type](#input\_provider\_type) | The source provider type for the App Runner service. | `string` | `"GITHUB"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the App Runner service. | `map(string)` | <pre>{<br>  "Poweredby": "terraform"<br>}</pre> | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The amount of time to wait for a response from the health check. | `number` | `2` | no |
| <a name="input_unhealthy_threshold"></a> [unhealthy\_threshold](#input\_unhealthy\_threshold) | The number of consecutive health check failures required before considering the target unhealthy. | `number` | `2` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC to use for the App Runner service. | `string` | n/a | yes |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | The IDs of the security groups to use for the App Runner service. | `list(string)` | n/a | yes |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | The IDs of the subnets to use for the App Runner service. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the App Runner service. |
