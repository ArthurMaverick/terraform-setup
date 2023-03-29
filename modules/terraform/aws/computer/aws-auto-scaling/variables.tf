variable "tag_name" {
  type = string
}

variable "aws_ami_ids_name" {
  type        = string
  description = "The name of the AMI (provided during image creation)."
}

variable "aws_account_id" {
  type        = string
  description = "The AWS account ID of the account that owns the AMI."
}

variable "aws_autoscaling_group" {
  type = list(object({
    name                      = string
    max_size                  = number
    min_size                  = number
    health_check_grace_period = number
    health_check_type         = string
    desired_capacity          = number
    force_delete              = bool
    vpc_zone_identifier       = list(string)

  }))
  default = []
}

variable "aws_launch_template" {
  type = list(object({
    name_prefix = string

    /* image_id      = string */
    instance_type = string
    key_name      = string
    ebs_block_device = list(object({
      device_name           = string
      volume_size           = number
      volume_type           = string
      delete_on_termination = bool
      encrypted             = bool
    }))
    security_groups = list(string)
  }))
  default = []
}
