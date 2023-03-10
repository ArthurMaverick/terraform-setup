/* https://github.com/hashicorp/terraform-provider-aws/issues/9996 */
resource "aws_ssm_association" "this" {
  for_each         = local.aws_ssm_association
  name             = each.value.document //"AWS-ApplyAnsiblePlaybooks"
  association_name = "ansible"
  max_concurrency  = each.value.max_concurrency //"50"
  max_errors       = each.value.max_errors      //"50"

  targets {
    key    = each.value.target_key   //"tag:Name"
    values = each.value.target_value //[]
  }


  parameters = {
    sourceType          = "S3"
    sourceInfo          = <<EOJ

 {
   "path": "https://dev-ansible-c68798461d8b.s3.amazonaws.com/ami-builder.yaml"
 }

EOJ
    InstallDependencies = "True"
    PlaybookFile        = "ami-builder.yml"
    ExtraVariables      = "s=s"
    Check               = "False"
    Verbose             = "-v"

    /* region     = each.value.region         //"us-east-1" */


  }
  output_location {
    s3_bucket_name = each.value.s3_bucket_name //"my-bucket"
    s3_key_prefix  = each.value.s3_key_prefix  //"my-prefix"
    /* s3_region      = each.value.region         //"us-east-1" */
  }
}
