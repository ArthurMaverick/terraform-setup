locals {
  aws_region = reverse(split("/", abspath(get_terragrunt_dir())))[0]
}
