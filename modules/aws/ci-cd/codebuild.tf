resource "aws_codebuild_project" "codebuild" {
  name = join("-", tolist([
    var.stage,
    var.type_project,
    "codebuild"
  ]))
  //"${var.stage}-${var.project}-codebuild"
  description          = "AWS CodeBuild for the app ${var.type_project}" //"${var.project}"
  build_timeout        = "20"
  queued_timeout       = "10"
  service_role         = var.iam_role_arn
  resource_access_role = var.iam_role_arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_SOURCE_CACHE"]
  }

  environment {
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = "true"
    compute_type                = "BUILD_GENERAL1_SMALL"

    environment_variable {
      name  = "STAGE"
      value = var.stage
    }
    environment_variable {
      name  = "AWS_REGION"
      value = var.region
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.aws_account_id
    }
  }

  source {
    type            = "GITHUB"
    git_clone_depth = 1
    location        = "https://github.com/${var.organization}/Infrastructure.git"
    buildspec       = file("${path.module}/buildspec.yaml")
    git_submodules_config {
      fetch_submodules = true
    }
  }

  logs_config {
    cloudwatch_logs {
      status     = "ENABLED"
      group_name = aws_cloudwatch_log_group.app.name
    }
  }

  tags = {
    Environment = var.stage
  }
}

resource "aws_cloudwatch_log_group" "app" {
  name              = "/aws/codebuild/${var.stage}-codebuild"
  retention_in_days = 30

  tags = {
    Environment = var.stage
  }
}
