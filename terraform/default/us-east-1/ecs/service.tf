resource "aws_ecs_service" "mongo" {
  name                   = "mongodb"
  cluster                = aws_ecs_cluster.ecs.id
  task_definition        = aws_ecs_task_definition.task.arn
  scheduling_strategy    = "REPLICA" # or DAEMON
  desired_count          = 1
  iam_role               = "arm" //var.role_arn
  enable_execute_command = true

  network_configuration {
    subnets          = ["subnet-1", "subnet-2"]
    security_groups  = ["sg-1", "sg-2"]
    assign_public_ip = false
  }

  ordered_placement_strategy {
    type = "spread"
  }

  load_balancer {
    target_group_arn = "arn" //aws_lb_target_group.foo.arn
    container_name   = "mongo"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }

  service_connect_configuration {
    enabled = true
    log_configuration {
      log_driver = "awslogs"
      options = {
        "awslogs-group"         = "ecs-service-logs"
        "awslogs-region"        = "us-west-2"
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }
  tags = {
    Name = "mongodb"
  }
}
