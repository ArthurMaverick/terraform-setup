resource "aws_codestarconnections_connection" "this" {
  name          = "${var.aws_codestarconnections_connection.name}-${var.stage}"
  provider_type = var.aws_codestarconnections_connection.provider_type
  tags = {
    "Terraform"   = "true"
    "Environment" = var.stage
  }
}
