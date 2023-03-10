resource "aws_ami_from_instance" "this" {
  for_each           = local.ami_from_instance
  name               = each.value.project
  source_instance_id = each.value.source_instance_id
  tags = {
    Owner     = each.value.owner_tag
    Project   = each.value.project
    UpdatedAt = formatdate("MMM DD, YYYY", timestamp())
  }
  lifecycle {
    ignore_changes = [
      tags["UpdatedAt"]
    ]
  }
}
