module "networking" {
  source = "../../modules/networking"

  environment  = var.environment
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  azs          = var.availability_zones
}
