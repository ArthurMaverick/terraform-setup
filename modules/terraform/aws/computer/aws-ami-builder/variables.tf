variable "ami_builder" {
  type = list(object({
    /* project name */
    project = string
    /* random id */
    keepers     = string
    byte_length = number
    /* aws_imagebuilder_image */
    owner_tag        = string
    image_recipe_arn = string
    /*  aws_imagebuilder_distribution_configuration*/
    region  = string
    ami_tag = string
  }))
  description = "values for aws_imagebuilder_image"
}
