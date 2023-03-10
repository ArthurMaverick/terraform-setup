data "aws_ssm_parameter" "github_token" {
  name = var.github_token
}

data "aws_ssm_parameter" "private_key_bucket" {
  name = var.private_key_bucket
}
