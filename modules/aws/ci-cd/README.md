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
| [aws_cloudwatch_log_group.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_codebuild_project.codebuild](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_s3_bucket.app_codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.app_codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_public_access_block.app_codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.app_codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_codestar_connection_arn"></a> [app\_codestar\_connection\_arn](#input\_app\_codestar\_connection\_arn) | value of the connection arn | `string` | n/a | yes |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_codepipeline"></a> [codepipeline](#input\_codepipeline) | value of the codepipeline | <pre>list(object({<br>    /* source */<br>    stage_project          = string<br>    stage_repository       = string<br>    stage_type             = string<br>    stage_catetory         = string<br>    stage_owner            = string<br>    stage_provider         = string<br>    stage_version          = string<br>    stage_output_artifacts = list(string)<br>    config_BranchName      = string<br>    /* build */<br>    build_name             = string<br>    build_category         = string<br>    build_owner            = string<br>    build_provider         = string<br>    build_input_artifacts  = list(string)<br>    build_output_artifacts = list(string)<br>    build_version          = string<br>    build_order            = number<br>  }))</pre> | n/a | yes |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | n/a | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | value of the organization | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | n/a | `string` | n/a | yes |
| <a name="input_type_project"></a> [type\_project](#input\_type\_project) | value of the project | `string` | n/a | yes |

## Outputs

No outputs.
