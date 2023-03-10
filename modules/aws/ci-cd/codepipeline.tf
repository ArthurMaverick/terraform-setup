resource "aws_codepipeline" "app" {
  depends_on = [
    aws_s3_bucket.app_codepipeline
  ]

  name     = "${var.stage}-${var.type_project}-codepipeline"
  role_arn = var.iam_role_arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.app_codepipeline.id
  }

  stage {
    name = "Source"
    dynamic "action" {
      for_each = local.codepipeline
      content {
        name             = action.value.stage_project
        category         = action.value.stage_catetory
        owner            = action.value.stage_owner
        provider         = action.value.stage_provider
        version          = action.value.stage_version
        output_artifacts = action.value.stage_output_artifacts
        configuration = {
          ConnectionArn        = var.app_codestar_connection_arn
          FullRepositoryId     = "${var.organization}/${action.value.stage_repository}"
          BranchName           = action.value.config_BranchName
          OutputArtifactFormat = "CODEBUILD_CLONE_REF"
        }
      }
    }
  }

  stage {
    name = "Build"
    dynamic "action" {
      for_each = local.codepipeline
      content {
        name             = action.value.build_name
        category         = action.value.build_category
        owner            = action.value.build_owner
        provider         = action.value.build_provider
        input_artifacts  = action.value.build_input_artifacts
        output_artifacts = action.value.build_output_artifacts
        version          = action.value.build_version
        run_order        = action.value.build_order
        configuration = {
          ProjectName = aws_codebuild_project.codebuild.name
          /* EnvironmentVariables = jsonencode([{
            name  = "STAGE"
            value = var.stage
          }]) */
        }
      }
    }
  }
}
