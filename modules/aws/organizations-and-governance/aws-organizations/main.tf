#-------------------------------------------------------------------------------
# ORGANIZATIONAL DELEGATED ADMINISTRATOR
#-------------------------------------------------------------------------------
resource "aws_organizations_delegated_administrator" "admin" {
  account_id        = var.root_account_id
  service_principal = "principal"
}

#-------------------------------------------------------------------------------
# ORGANIZATIONAL ROOT
#-------------------------------------------------------------------------------
resource "aws_organizations_organization" "this" {
  aws_service_access_principals = [
    "wellarchitected.amazonaws.com"
    /* "cloudtrail.amazonaws.com", */
    /* "config.amazonaws.com", */
  ]
  feature_set = "ALL"
}

#-------------------------------------------------------------------------------
# ORGANIZATIONAL UNITs
#-------------------------------------------------------------------------------
resource "aws_organizations_organizational_unit" "workloads" {
  name = "workload"

  parent_id = aws_organizations_organization.this.roots[0].id
  tags      = merge({ Name = "Workload-OU" }, var.tags)
}

resource "aws_organizations_organizational_unit" "dev" {
  name      = "dev"
  parent_id = aws_organizations_organizational_unit.workloads.id

  tags = merge({ Name = "dev-OU" }, var.tags)
}

resource "aws_organizations_account" "dev" {
  name              = "arthur-devops"
  email             = "arthuracs18@gmail.com"
  close_on_deletion = true

  parent_id = aws_organizations_organizational_unit.dev.id
  tags = merge({
    Name = "Devops",
    Role = "Admin" },
  var.tags)
}
