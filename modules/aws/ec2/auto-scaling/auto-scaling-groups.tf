resource "aws_autoscaling_group" "this" {
  for_each = local.aws_autoscaling_group

  name                      = each.value.name
  max_size                  = each.value.max_size
  min_size                  = each.value.min_size
  desired_capacity          = each.value.desired_capacity
  health_check_grace_period = each.value.health_check_grace_period
  health_check_type         = each.value.health_check_type
  vpc_zone_identifier       = each.value.vpc_zone_identifier
  force_delete              = each.value.force_delete

  mixed_instances_policy {

    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 0
    }

    launch_template {
      launch_template_specification {
        launch_template_name = aws_launch_template.this[each.key].name
        version              = "$Latest"
      }
    }


  }
}

/* resource "aws_autoscaling_group_tag" "this" {
  for_each               = local.aws_autoscaling_group
  autoscaling_group_name = aws_autoscaling_group.this[each.key].name
  tag {
    key                 = "Name"
    value               = var.tag_name
    propagate_at_launch = false
  }
  lifecycle {
    ignore_changes = [
      tag[0].value,
      tag[0].key,
      tag[0].propagate_at_launch
    ]
  } */
/* } */
