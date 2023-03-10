variable "aws_ssm_association" {
  type = list(object({
    document        = string
    gh_token        = string
    project         = string
    max_concurrency = string
    max_errors      = string
    target_key      = string
    target_value    = list(string)
    stage           = string
    s3_bucket_name  = string
    s3_key_prefix   = string
    /* s3_region       = string */
  }))
}
