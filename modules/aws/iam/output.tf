output "iam_role_arns" {
  value = [for value in aws_iam_role.this : { format(split("-", value.name)[1]) : value.arn }]
}

output "aws_iam_role_policy_arn" {
  value = [for value in aws_iam_role_policy.this : { format(split("-", value.name)[1]) : value.id }]

}
