## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_function_event_invoke_config.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function_event_invoke_config) | resource |
| [aws_lambda_layer_version.lambda_layer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |
| [aws_lambda_permission.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [archive_file.dependencies_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [archive_file.lambda_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architectures"></a> [architectures](#input\_architectures) | A list of architectures that your function supports. | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_dead_letter_config"></a> [dead\_letter\_config](#input\_dead\_letter\_config) | A map that configures options for function dead letter queue. | `map(string)` | `{}` | no |
| <a name="input_dependencies_path"></a> [dependencies\_path](#input\_dependencies\_path) | The path to the function's dependencies within the local filesystem. | `string` | `"./lambda/node_modules/"` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the function. | `string` | `"lambda function - edited by terraform"` | no |
| <a name="input_enable_layer_dependency"></a> [enable\_layer\_dependency](#input\_enable\_layer\_dependency) | Whether to enable the layer dependency. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | A map that defines environment variables for the Lambda function. | `map(string)` | `{}` | no |
| <a name="input_ephemeral_storage"></a> [ephemeral\_storage](#input\_ephemeral\_storage) | A map that configures options for function ephemeral storage. | `map(string)` | `{}` | no |
| <a name="input_file_system_config"></a> [file\_system\_config](#input\_file\_system\_config) | A map that configures options for function file system. | `map(string)` | `{}` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | The name of the function. | `string` | `""` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | The function entrypoint in your code. | `string` | `"index.handler"` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | The ARN of the IAM role that Lambda assumes when it executes your function to access any other Amazon Web Services (AWS) resources. | `string` | `""` | no |
| <a name="input_image_config"></a> [image\_config](#input\_image\_config) | A map that configures options for function image. | `map(string)` | `{}` | no |
| <a name="input_lambda_permissions"></a> [lambda\_permissions](#input\_lambda\_permissions) | A list of maps that define the permissions for the Lambda function. | `map(string)` | `{}` | no |
| <a name="input_layer_name"></a> [layer\_name](#input\_layer\_name) | The name of the layer. | `string` | `"lambda-layer"` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | A list of function layers to add to the function's execution environment. | `list(string)` | `[]` | no |
| <a name="input_maximum_event_age_in_seconds"></a> [maximum\_event\_age\_in\_seconds](#input\_maximum\_event\_age\_in\_seconds) | The maximum age of a request that Lambda sends to a function for processing. | `number` | `60` | no |
| <a name="input_maximum_retry_attempts"></a> [maximum\_retry\_attempts](#input\_maximum\_retry\_attempts) | The maximum number of times to retry when the function returns an error. | `number` | `2` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | The amount of memory in MB your Lambda function is given. | `number` | `128` | no |
| <a name="input_on_failure_destination"></a> [on\_failure\_destination](#input\_on\_failure\_destination) | The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic. | `string` | `{}` | no |
| <a name="input_on_success_destination"></a> [on\_success\_destination](#input\_on\_success\_destination) | The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic. | `string` | `{}` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime environment for the Lambda function. | `string` | `"nodejs16.x"` | no |
| <a name="input_source_file_path"></a> [source\_file\_path](#input\_source\_file\_path) | The path to the function's deployment package within the local filesystem. | `string` | `"./lambda/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the function. | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The function execution time at which Lambda should terminate the function. | `number` | `3` | no |
| <a name="input_tracing_config"></a> [tracing\_config](#input\_tracing\_config) | A map that configures options for function tracing. | `map(string)` | `{}` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | A map that configures options for function VPC. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | n/a |
| <a name="output_lambda_function_id"></a> [lambda\_function\_id](#output\_lambda\_function\_id) | n/a |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | n/a |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | n/a |
| <a name="output_lambda_function_tags"></a> [lambda\_function\_tags](#output\_lambda\_function\_tags) | n/a |
| <a name="output_lambda_function_version"></a> [lambda\_function\_version](#output\_lambda\_function\_version) | n/a |
