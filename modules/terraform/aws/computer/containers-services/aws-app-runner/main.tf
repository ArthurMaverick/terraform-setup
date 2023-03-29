resource "aws_apprunner_service" "this" {
  service_name                   = var.app_runner_name
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.autoscaling.arn

  health_check_configuration {
    healthy_threshold   = var.healthy_threshold
    interval            = var.interval
    path                = var.path
    protocol            = var.protocol
    timeout             = var.timeout
    unhealthy_threshold = var.unhealthy_threshold

  }

  observability_configuration {
    observability_configuration_arn = aws_apprunner_observability_configuration.observability_configuration.arn
    observability_enabled           = var.observability_enabled
  }

  source_configuration {
    auto_deployments_enabled = var.auto_deployments_enabled
    dynamic "image_repository" {
      for_each = try(var.image_repository, {})
      content {
        image_configuration {
          port                          = image_repository.value.port
          start_command                 = image_repository.value.start_command
          runtime_environment_secrets   = image_repository.value.runtime_environment_secrets
          runtime_environment_variables = image_repository.value.runtime_environment_variables
        }
        image_identifier      = image_repository.value.image_identifier
        image_repository_type = image_repository.value.image_repository_type
      }
    }
    dynamic "code_repository" {
      for_each = try(var.code_repository, {})
      content {
        code_configuration {
          code_configuration_values {
            build_command = code_repository.value.build_command
            port          = code_repository.value.port
            runtime       = code_repository.value.runtime
            start_command = code_repository.value.start_command
          }

          configuration_source = code_repository.value.configuration_source
        }
        repository_url = code_repository.value.repository_url

        source_code_version {
          type  = code_repository.value.type
          value = code_repository.value.value
        }
      }
    }
    authentication_configuration {
      connection_arn = aws_apprunner_connection.connetion.arn
    }
  }

  network_configuration {
    ingress_configuration {
      is_publicly_accessible = var.is_publicly_accessible
    }
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = aws_apprunner_vpc_connector.connector.arn
    }
  }

  tags = merge({ Name = format("%s-%s", var.app_runner_name, "service") }, var.tags)
}

resource "aws_apprunner_auto_scaling_configuration_version" "autoscaling" {
  auto_scaling_configuration_name = format("%s-%s", var.app_runner_name, "auto_scaling")

  max_concurrency = var.max_concurrency
  max_size        = var.max_size
  min_size        = var.min_size

  tags = merge({ Name = format("%s-%s", var.app_runner_name, "autoscaling") }, var.tags)
}

resource "aws_apprunner_observability_configuration" "observability_configuration" {
  observability_configuration_name = format("%s-%s", var.app_runner_name, "observability")

  trace_configuration {
    vendor = "AWSXRAY" // https://docs.aws.amazon.com/pt_br/apprunner/latest/dg/monitor-xray.html
  }

  tags = merge({ Name = format("%s-%s", var.app_runner_name, "observability") }, var.tags)
}

resource "aws_apprunner_connection" "connetion" {
  for_each        = try(var.code_repository, {})
  connection_name = var.connections_name
  provider_type   = var.provider_type

  tags = merge({ Name = format("%s-%s", var.app_runner_name, "connection") }, var.tags)
}

resource "aws_apprunner_custom_domain_association" "domain" {
  service_arn          = aws_apprunner_service.this.arn
  domain_name          = var.domain_name //"example.com"
  enable_www_subdomain = var.enable_www_subdomain
}

resource "aws_apprunner_vpc_connector" "connector" {
  vpc_connector_name = format("%s-%s", var.app_runner_name, "vpc_connector")
  subnets            = var.subnets
  security_groups    = var.security_groups
  tags               = merge({ Name = format("%s-%s", var.app_runner_name, "vpc_connector") }, var.tags)
}

resource "aws_apprunner_vpc_ingress_connection" "vpc_ingress_connection" {
  count       = enable_vpc_ingress_connection ? 1 : 0
  name        = format("%s-%s", var.app_runner_name, "vpc_ingress_connection")
  service_arn = aws_apprunner_service.this.arn

  ingress_vpc_configuration {
    vpc_id          = var.vpc_id
    vpc_endpoint_id = var.vpc_endpoint_id
  }

  tags = merge({ Name = format("%s-%s", var.app_runner_name, "vpc_ingress_connection") }, var.tags)
}
