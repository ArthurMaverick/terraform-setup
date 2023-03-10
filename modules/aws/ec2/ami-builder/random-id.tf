
/* resource "random_id" "this" {
  for_each    = local.ami_builder
  byte_length = each.value.byte_length
  keepers = {
    ami_id = each.value.keepers
  }
  prefix = each.value.project
} */
