resource "aws_s3_bucket" "app_codepipeline" {
  bucket = join("-", tolist([
    var.stage,
    var.type_project,
    var.region,
    "codepipeline"
  ]))
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Environment = var.stage
  }
}

resource "aws_s3_bucket_acl" "app_codepipeline" {
  bucket = aws_s3_bucket.app_codepipeline.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "app_codepipeline" {
  bucket = aws_s3_bucket.app_codepipeline.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "app_codepipeline" {
  bucket = aws_s3_bucket.app_codepipeline.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
