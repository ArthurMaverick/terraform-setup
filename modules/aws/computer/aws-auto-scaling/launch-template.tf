data "aws_ami" "amazon_linux" {
  name_regex = "[gG][oO][lL][dD][-][aA][mM][iI]"
  /* executable_users = ["self"] */
  owners = ["self"]
  filter {
    name   = "name"
    values = [var.aws_ami_ids_name]
  }
}

resource "aws_launch_template" "this" {
  for_each      = local.aws_launch_template
  instance_type = each.value.instance_type
  name_prefix   = each.value.name_prefix
  key_name      = each.value.key_name
  image_id      = data.aws_ami.amazon_linux.image_id

  block_device_mappings {
    device_name = each.value.ebs_block_device[each.key].device_name

    ebs {
      volume_size           = each.value.ebs_block_device[each.key].volume_size
      volume_type           = each.value.ebs_block_device[each.key].volume_type
      delete_on_termination = each.value.ebs_block_device[each.key].delete_on_termination
      encrypted             = each.value.ebs_block_device[each.key].encrypted
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.tag_name
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
