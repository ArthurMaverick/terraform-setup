terraform {
  before_hook "linter" {
    commands = [
      "apply",
      "plan",
    ]
    execute = ["terraform", "validate"]
    run_on_error = false
  }
}

remote_state {
  backend = "s3"

  config = {
    bucket         = join("-", [get_env("BUCKET", "tf-bucket"), get_aws_account_id()])
    dynamodb_table = join("-", [get_env("DYNAMODB_TABLE", "tf-dynamo-table"), get_aws_account_id()])
    encrypt        = true
    region         = get_env("REGION", "us-east-1")
    key            = "${path_relative_to_include()}/terraform.tfstate"
  }
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "${get_env("BUCKET", "tf-bucket")}-${get_aws_account_id()}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${get_env("REGION", "us-east-1")}"
    dynamodb_table = "${get_env("DYNAMO", "tf-bucket")}-${get_aws_account_id()}"
  }
}
EOF
}
