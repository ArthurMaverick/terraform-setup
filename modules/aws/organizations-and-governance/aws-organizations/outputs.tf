#-------------------------------------------------------------------------------
# ORGANIZATIONAL DELEGATED ADMINISTRATOR
#-------------------------------------------------------------------------------
output "delegated_administrator" {
  description = "The name of the delegated administrator."
  value       = aws_organizations_delegated_administrator.admin.service_principal
}

#-------------------------------------------------------------------------------
# ORGANIZATIONAL ROOT
#-------------------------------------------------------------------------------
output "organization_id" {
  description = "The name of the organization."
  value       = aws_organizations_organization.this.id
}

#-------------------------------------------------------------------------------
# ORGANIZATIONAL UNITs
#-------------------------------------------------------------------------------
output "workloads_organizational_unit" {
  description = "workload OU"
  value       = aws_organizations_organizational_unit.workloads.id
}

output "dev_organizational_unit" {
  description = "Dev OU"
  value       = aws_organizations_organizational_unit.dev.id
}
