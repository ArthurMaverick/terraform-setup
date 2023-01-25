package terraform.policies.public_ingress

import input.plan as plan

deny[msg] {
  r := plan.resource_changes[_]
  r.type == "aws_vpc"
  r.change.after.ingress[_].cidr_blocks[_] == "0.0.0.0/0"
  msg := sprintf("%v has 0.0.0.0/0 as allowed ingress", [r.address])
}
