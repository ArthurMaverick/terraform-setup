include "root" {
  path = find_in_parent_folders()
}

locals {
  env_vars       = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars    = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env            = local.env_vars.locals.environment
  aws_account_id = local.env_vars.locals.aws_account_id
  region         = local.region_vars.locals.aws_region
  projects       = local.env_vars.locals.projects
  repositories   = local.env_vars.locals.repositories
}

terraform {
  source = "${get_repo_root()}/modules/k8s/kind///"

  extra_arguments "plan_file" {
    commands  = ["plan"]
    arguments = ["-out=$(pwd)/terraform/${local.env}/tfplan.txt"]
  }

  extra_arguments "plan_file" {
    commands  = ["run-all apply"]
    arguments = ["$(pwd)/terraform/${local.env}/tfplan.txt"]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Override parameters for this environment
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  stage = "dev"
  region = "us-east-2"
  aws_account_id = "123456789012"
}

/* provider "kind" {} */
