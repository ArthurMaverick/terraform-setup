resource "aws_ecs_cluster" "ecs" {
  name = "default"

  configuration {
    execute_command_configuration {
      logging = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.test.name
      }
    }
  }
  tags = {
    Name = "default"
  }
}
