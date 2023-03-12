resource "aws_imagebuilder_distribution_configuration" "this" {
  for_each = local.ami_builder

  name = join("-", tolist([each.value.project, "{{imagebuilder:buildDate}}"]))

  distribution {
    region = each.value.region
    ami_distribution_configuration {
      name = join("-", tolist([each.value.project, "{{imagebuilder:buildDate}}"]))
      ami_tags = {
        Product   = each.value.project
        Owner     = each.value.owner_tag
        UpdatedAt = formatdate("MMM DD, YYYY", timestamp())
      }
    }
  }
  tags = {
    Owner     = each.value.owner_tag
    Project   = each.value.project
    UpdatedAt = formatdate("MMM DD, YYYY", timestamp())
  }
}
