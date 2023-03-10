data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_key_pair" "this" {
  for_each = local.aws_instance
  key_name = each.value.key_pair
}

data "local_file" "user_data" {
  filename = join("/", tolist([path.module, "user-data.sh"]))
}
