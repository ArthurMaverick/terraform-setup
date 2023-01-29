locals {
  environment = reverse(split("/", abspath(get_terragrunt_dir())))[0]
  aws_account_id = get_aws_account_id()
}
