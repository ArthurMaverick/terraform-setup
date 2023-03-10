resource "aws_instance" "this" {
  for_each      = local.aws_instance
  instance_type = each.value.instance_type
  ami           = data.aws_ami.amazon_linux_2.id

  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = each.value.security_group_ids
  key_name               = data.aws_key_pair.this[each.key].key_name
  user_data              = data.local_file.user_data.content

  root_block_device {
    encrypted             = each.value.root_block_device.encrypted
    volume_type           = each.value.root_block_device.volume_type
    volume_size           = each.value.root_block_device.volume_size
    delete_on_termination = try(each.value.root_block_device.delete_on_termination, false)
  }

  tags = {
    Name        = join("-", [var.stage, each.value.project, "instance"])
    Provisioner = "Terraform"
  }
}
