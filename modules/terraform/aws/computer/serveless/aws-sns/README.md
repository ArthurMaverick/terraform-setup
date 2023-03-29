## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_iam_policy_document.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backoff_function"></a> [backoff\_function](#input\_backoff\_function) | The backoff function. | `string` | `"linear"` | no |
| <a name="input_disable_subscription_overrides"></a> [disable\_subscription\_overrides](#input\_disable\_subscription\_overrides) | Boolean indicating whether to disable subscription overrides. | `bool` | `false` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name for the topic. | `string` | `""` | no |
| <a name="input_fifo_topic"></a> [fifo\_topic](#input\_fifo\_topic) | Boolean indicating whether to create a FIFO topic. | `bool` | `false` | no |
| <a name="input_max_delay_target"></a> [max\_delay\_target](#input\_max\_delay\_target) | The maximum delay target in seconds. | `number` | `20` | no |
| <a name="input_max_receives_per_second"></a> [max\_receives\_per\_second](#input\_max\_receives\_per\_second) | The maximum receives per second. | `number` | `10` | no |
| <a name="input_min_delay_target"></a> [min\_delay\_target](#input\_min\_delay\_target) | The minimum delay target in seconds. | `number` | `20` | no |
| <a name="input_num_max_delay_retries"></a> [num\_max\_delay\_retries](#input\_num\_max\_delay\_retries) | The number of maximum delay retries. | `number` | `0` | no |
| <a name="input_num_min_delay_retries"></a> [num\_min\_delay\_retries](#input\_num\_min\_delay\_retries) | The number of minimum delay retries. | `number` | `0` | no |
| <a name="input_num_no_delay_retries"></a> [num\_no\_delay\_retries](#input\_num\_no\_delay\_retries) | The number of no delay retries. | `number` | `0` | no |
| <a name="input_num_retries"></a> [num\_retries](#input\_num\_retries) | The number of retries. | `number` | `3` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The name of the topic you want to create. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sns_topic_arn"></a> [sns\_topic\_arn](#output\_sns\_topic\_arn) | SNS topic ARN |
| <a name="output_sns_topic_id"></a> [sns\_topic\_id](#output\_sns\_topic\_id) | SNS topic id |
| <a name="output_sns_topic_name"></a> [sns\_topic\_name](#output\_sns\_topic\_name) | SNS topic name |
| <a name="output_sns_topic_tags"></a> [sns\_topic\_tags](#output\_sns\_topic\_tags) | SNS topic display name |
