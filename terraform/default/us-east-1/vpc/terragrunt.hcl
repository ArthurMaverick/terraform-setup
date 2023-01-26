terraform {
  source = "${get_terragrunt_dir()}///" //${get_path_to_repo_root() "../vpc///"
  # source = "github.com/terraform-aws-modules/terraform-aws-vpc"
  # source = "${path_relative_to_include()}/../modules//${path_relative_to_include()}" //${get_path_to_repo_root()

  extra_arguments "vpc_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]

    arguments = [
      /* "-var-file=${get_terragrunt_dir()}/../vpc.tfvars", */
      "-var-file=vpc.tfvars",
      /* "-var-file=${get_terragrunt_dir()}/${path_relative_from_include()}/default.tfvars", */
    ]
  }
}

/* include "root" {
  path = "../../terragrunt.hcl"
} */
