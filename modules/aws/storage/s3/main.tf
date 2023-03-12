
resource "random_id" "this" {
  count = length(local.s3)
  keepers = {
    ami_id = var.s3[count.index].stage
  }

  byte_length = 6
}

resource "aws_s3_bucket" "this" {
  for_each = local.s3
  bucket   = join("-", tolist([each.value.stage, each.value.bucket, random_id.this[each.key].hex]))

  force_destroy = each.value.force_destroy

  tags = {
    "key" = "value"
  }
}

resource "aws_s3_bucket_acl" "this" {
  count  = length(aws_s3_bucket.this)
  bucket = aws_s3_bucket.this[count.index].id
  acl    = var.s3[count.index].acl

}

/* resource "aws_s3_object" "this" {
  count = length(aws_s3_bucket.this)
  bucket   = aws_s3_bucket.this[count.index].arn
  key      = var.s3[count.index].object_key
  source   = data.archive_file.data_folder[count.index].output_path

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  force_destroy = var.s3[count.index].force_destroy

} */
