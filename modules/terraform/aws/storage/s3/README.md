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
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_s3"></a> [s3](#input\_s3) | n/a | <pre>list(object({<br>    stage         = string<br>    byte_length   = number<br>    bucket        = string<br>    force_destroy = bool<br>    acl           = string //"private"<br>    /* object_key         = string<br>    object_source      = string */<br>    /* tags = map(string) */<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_s3_bucket_arns"></a> [aws\_s3\_bucket\_arns](#output\_aws\_s3\_bucket\_arns) | n/a |
| <a name="output_aws_s3_bucket_ids"></a> [aws\_s3\_bucket\_ids](#output\_aws\_s3\_bucket\_ids) | n/a |
