variable "s3" {
  type = list(object({
    stage         = string
    byte_length   = number
    bucket        = string
    force_destroy = bool
    acl           = string //"private"
    /* object_key         = string
    object_source      = string */
    /* tags = map(string) */
  }))
}
