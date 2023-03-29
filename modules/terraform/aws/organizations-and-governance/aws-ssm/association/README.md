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
| [aws_ssm_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_ssm_association"></a> [aws\_ssm\_association](#input\_aws\_ssm\_association) | n/a | <pre>list(object({<br>    document        = string<br>    gh_token        = string<br>    project         = string<br>    max_concurrency = string<br>    max_errors      = string<br>    target_key      = string<br>    target_value    = list(string)<br>    stage           = string<br>    s3_bucket_name  = string<br>    s3_key_prefix   = string<br>    /* s3_region       = string */<br>  }))</pre> | n/a | yes |

## Outputs

No outputs.
