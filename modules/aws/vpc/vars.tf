variable "vpc" {
  type = object({
    name                 = string
    project              = string
    environment          = string
    cidr                 = string
    azs                  = list(string)
    private_subnets      = list(string)
    public_subnets       = list(string)
    enable_nat_gateway   = bool
    enable_vpn_gateway   = bool
    enable_dns_hostnames = bool
  })
  description = "VPC configuration"
}
