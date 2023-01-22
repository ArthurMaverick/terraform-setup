terraform {
  # source = "github.com/terraform-aws-modules/terraform-aws-vpc"
  source = "../vpc///" //${get_path_to_repo_root()
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
      "-var-file=${get_terragrunt_dir()}/default.tfvars",
      /* "-var-file=${get_terragrunt_dir()}/${path_relative_from_include()}/default.tfvars", */
    ]
  }
}

include "root" {
  path = find_in_parent_folders()
}
