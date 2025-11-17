module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "${var.project_name}-${var.environment}-vpc"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = [for k, v in var.azs : cidrsubnet(var.vpc_cidr, 4, k)]
  # offset public subnets by number of azs * 16 (each /20 uses 16 /24 blocks)
  public_subnets = [for k, v in var.azs : cidrsubnet(var.vpc_cidr, 8, k + length(var.azs) * 16)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Tags required for EKS
  public_subnet_tags = {
    "kubernetes.io/role/elb"                                               = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.environment}-cluster" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"                                      = "1"
    "kubernetes.io/cluster/${var.project_name}-${var.environment}-cluster" = "shared"
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
