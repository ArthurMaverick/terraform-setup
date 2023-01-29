# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path = find_in_parent_folders()
}

locals {
   env_vars    = read_terragrunt_config(find_in_parent_folders("env.hcl"))
   region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
   env         = local.env_vars.locals.environment
   region      = local.region_vars.locals.aws_region
}

terraform {
  source = "${get_terragrunt_dir()}///"

  extra_arguments "plan_file" {
    commands = ["plan"]
    arguments = ["-out=$(pwd)/terraform/${local.env}/tfplan.txt"]
  }

  extra_arguments "plan_file" {
    commands = ["run-all apply"]
    arguments = ["$(pwd)/terraform/${local.env}/tfplan.txt"]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Override parameters for this environment
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  vpc = {
    azs                  = ["${local.region}a", "${local.region}b"]
    environment          = local.env
    name                 = "vpc"
    project              = "client2"
    cidr                 = "10.0.0.0/16"
    private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets       = ["10.0.101.0/24", "10.0.102.0/24"]
    enable_nat_gateway   = false
    enable_vpn_gateway   = false
    enable_dns_hostnames = false
  }
}

 # extra_arguments "vpc_vars" {
 #   commands = [
 #     "apply",
 #     "plan",
 #     "import",
 #     "push",
 #     "refresh",
 #     "destroy"
 #   ]
 #
 #   arguments = [
 #     "-var-file=vpc.tfvars",
 #     /* "-var-file=${get_terragrunt_dir()}/../vpc.tfvars", */
 #     /* "-var-file=${get_terragrunt_dir()}/${path_relative_from_include()}/default.tfvars", */
 #   ]
 # }
