variable "aws_ami_from_instance" {
  type = list(object({
    source_instance_id = string
    region             = string
    project            = string
    owner_tag          = string
  }))
  description = "List of AMI from instance objects"
}
