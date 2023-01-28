module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = join("-", [var.vpc.environment, var.vpc.project, var.vpc.name])
  cidr   = var.vpc.cidr

  azs             = var.vpc.azs
  private_subnets = var.vpc.private_subnets
  public_subnets  = var.vpc.public_subnets

  enable_nat_gateway = var.vpc.enable_nat_gateway
  enable_vpn_gateway = var.vpc.enable_vpn_gateway

  enable_dns_hostnames = var.vpc.enable_dns_hostnames

  tags = {
    Managed     = "Terraform"
    Environment = var.vpc.environment
  }
  version = "3.19.0"
}
