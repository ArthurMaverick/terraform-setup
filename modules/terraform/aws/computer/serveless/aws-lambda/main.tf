locals {
  has_image_config        = try(var.image_config, null) != null
  id                      = split("-", uuid())[0]
  function_name           = coalesce(var.function_name, format("%s-%s", "lambda", local.id))
  enable_layer_dependency = var.enable_layer_dependency && local.has_image_config == false
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = var.source_file_path
  output_path = "lambda_launcher.zip"
}

data "archive_file" "dependencies_zip" {
  count       = local.enable_layer_dependency ? 1 : 0
  type        = "zip"
  source_file = var.dependencies_path
  output_path = "dependencies.zip"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  count      = local.enable_layer_dependency ? 1 : 0
  layer_name = var.layer_name
  filename   = data.archive_file.dependencies_zip.output_path

  compatible_runtimes = [var.runtime]
}

resource "aws_lambda_function" "this" {
  function_name    = local.function_name
  architectures    = var.architectures
  role             = coalesce(var.iam_role_arn, "IAM ROLE HAS BEN NOT SET")
  memory_size      = var.memory_size
  description      = var.description
  timeout          = var.timeout
  layers           = local.enable_layer_dependency ? aws_lambda_layer_version.lambda_layer.arn : null
  runtime          = local.has_image_config ? null : var.runtime
  handler          = local.has_image_config ? null : var.handler
  filename         = local.has_image_config ? null : data.archive_file.lambda_zip.output_path
  source_code_hash = local.has_image_config ? null : data.archive_file.lambda_zip.output_base64sha256

  dynamic "image_config" {
    for_each = try(var.image_config, {})
    content {
      command     = image_config.value.command
      entry_point = image_config.value.entry_point
    }
  }
  dynamic "ephemeral_storage" {
    for_each = try(var.ephemeral_storage, {})
    content {
      size = ephemeral_storage.value.size_in_gb
    }
  }
  dynamic "tracing_config" {
    for_each = try(var.tracing_config, {})
    content {
      mode = tracing_config.value.mode
    }
  }
  dynamic "dead_letter_config" {
    for_each = try(var.dead_letter_config, {})
    content {
      target_arn = dead_letter_config.value.target_arn
    }
  }
  dynamic "environment" {
    for_each = try(var.environment, {})
    content {
      variables = environment.value.variables
    }
  }
  dynamic "vpc_config" {
    for_each = try(var.vpc_config, {})
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }
  }
  dynamic "file_system_config" {
    for_each = try(var.file_system_config, {})
    content {
      arn              = file_system_config.value.arn
      local_mount_path = file_system_config.value.local_mount_path
    }
  }

  tags = merge({ Name = local.function_name }, var.tags)
}

resource "aws_lambda_function_event_invoke_config" "this" {
  count                        = var.event_invoke_config_enabled ? 1 : 0
  function_name                = aws_lambda_function.this.function_name
  maximum_event_age_in_seconds = var.maximum_event_age_in_seconds
  maximum_retry_attempts       = var.maximum_retry_attempts

  destination_config {
    dynamic "on_failure" {
      for_each = try(var.on_failure_destination, {})
      content {
        destination = on_failure.value.destination
      }
    }
    dynamic "on_success" {
      for_each = try(var.on_success_destination, {})
      content {
        destination = on_success.value.destination
      }
    }
  }
}

resource "aws_lambda_permission" "this" {
  for_each      = try(var.lambda_permissions, {})
  function_name = aws_lambda_function.this.function_name
  action        = "lambda:InvokeFunction"
  statement_id  = each.value.statement_id
  principal     = each.value.principal
  source_arn    = each.value.source_arn
}
