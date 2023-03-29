resource "aws_imagebuilder_image" "this" {
  count                            = length(local.ami_builder)
  infrastructure_configuration_arn = aws_imagebuilder_distribution_configuration.this[count.index].arn
  image_recipe_arn                 = local.ami_builder[count.index].image_recipe_arn
  tags = {
    Owner     = local.ami_builder[count.index].owner_tag
    Project   = local.ami_builder[count.index].project
    UpdatedAt = formatdate("MMM DD, YYYY", timestamp())
  }
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}
