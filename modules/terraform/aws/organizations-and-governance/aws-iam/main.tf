resource "random_id" "id" {
  for_each = local.iam
  keepers = {
    aws_iam_role        = each.value.policy
    aws_iam_role_policy = each.value.policy
  }
  byte_length = 6
}

resource "aws_iam_role" "this" {
  for_each = local.iam
  name = join("-", tolist([
    each.value.stage,
    each.value.project,
    each.value.aws_account_id,
    random_id.id[each.key].hex
  ]))

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = each.value.services
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "this" {
  count = length(aws_iam_role.this)
  name = join("-", tolist([
    local.iam[count.index].stage,
    local.iam[count.index].policy,
    local.iam[count.index].aws_account_id,
    random_id.id[count.index].hex
  ]))
  role = aws_iam_role.this[count.index].id

  policy = lookup(local.policies[count.index], local.iam[count.index].policy, "")
}
