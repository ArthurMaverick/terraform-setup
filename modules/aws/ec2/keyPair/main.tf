resource "aws_key_pair" "this" {
  key_name   = join("-", [var.name, var.stage])
  public_key = file(var.path)
}
