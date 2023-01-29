# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Automatically load account-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  # Extract the variables we need for easy access
  environment    = local.environment_vars.locals.environment
  aws_account_id = local.environment_vars.locals.aws_account_id
  aws_region     = local.region_vars.locals.aws_region
}

terraform {
  extra_arguments "retry_lock" {
   commands = get_terraform_commands_that_need_locking()
   arguments = [
     "-lock-timeout=20m"
   ]
  }

  before_hook "cleaner" {
    commands = [
      "init",
    ]
    execute = ["rm", "-rf", ".terraform"]
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["${local.aws_account_id}"]
}
EOF
}

remote_state {
  backend = "s3"

  config = {
    bucket         = join("-", [local.environment, get_env("BUCKET", "tf-bucket"), local.aws_account_id, local.aws_region])
    dynamodb_table = join("-", [get_env("DYNAMODB_TABLE", "terraform-locks"), local.aws_account_id])
    encrypt        = true
    region         = local.aws_region
    key            = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.environment_vars.locals,
  local.region_vars.locals,
)
