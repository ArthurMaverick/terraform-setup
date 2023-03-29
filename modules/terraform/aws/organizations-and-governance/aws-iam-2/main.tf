locals {
  id = split("-", uuid())[0]
}

resource "aws_iam_role" "this" {
  name = join("-", tolist([
    var.stage,
    var.project,
    local.id,
    "role"
  ]))

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "*"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "this" {
  count = length(var.policies)
  name = join("-", tolist([
    var.stage,
    var.project,
    local.id,
    "policy"
  ]))
  policy = data.aws_iam_policy_document.this[count.index].json
}

data "aws_iam_policy_document" "this" {
  count = length(var.policies)

  dynamic "statement" {
    for_each = try(var.policies, {})
    content {
      sid       = statement.value.sid
      actions   = statement.value.actions
      resources = statement.value.resources
      effect    = statement.value.effect

      dynamic "principals" {
        for_each = try(statement.value.principals, {})
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }
      dynamic "condition" {
        for_each = try(statement.value.condition, {})
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.policies)
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this[count.index].arn
}
