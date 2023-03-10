variable "codepipeline" {
  type = list(object({
    /* source */
    stage_project          = string
    stage_repository       = string
    stage_type             = string
    stage_catetory         = string
    stage_owner            = string
    stage_provider         = string
    stage_version          = string
    stage_output_artifacts = list(string)
    config_BranchName      = string
    /* build */
    build_name             = string
    build_category         = string
    build_owner            = string
    build_provider         = string
    build_input_artifacts  = list(string)
    build_output_artifacts = list(string)
    build_version          = string
    build_order            = number
  }))
  description = "value of the codepipeline"
}
variable "type_project" {
  type        = string
  description = "value of the project"
}
/* variable "private_key_bucket" {
  type = string
}
variable "ssm_github_token" {
  type = string
} */
variable "stage" {
  type = string //
}
variable "aws_account_id" {
  type = string //
}
variable "region" {
  type = string //
}
variable "app_codestar_connection_arn" {
  type        = string //
  description = "value of the connection arn"
}
variable "organization" {
  type        = string //
  description = "value of the organization"
}
variable "iam_role_arn" {
  type = string
}
/* variable "ssm_github_token" {
  type = string
} */
