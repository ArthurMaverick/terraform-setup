output "ami_ids" {
  value = [for key, value in aws_imagebuilder_image.this : value.id]
}

output "aws_imagebuilder_distribution_configurations" {
  value = [for key, value in aws_imagebuilder_distribution_configuration.this : value.arn]
}

output "aws_imagebuilder_images" {
  value = [for key, value in aws_imagebuilder_image.this : value.arn]
}
