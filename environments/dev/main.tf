module "networking" {
  source = "../../modules/networking"

  environment  = var.environment
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  azs          = var.availability_zones
}

module "eks" {
  source = "../../modules/eks"

  environment                  = var.environment
  project_name                 = var.project_name
  cluster_version              = var.cluster_version
  vpc_id                       = module.networking.vpc_id
  private_subnet_ids           = module.networking.private_subnet_ids
  node_instance_types          = var.node_instance_types
  node_desired_size            = var.node_desired_size
  node_min_size                = var.node_min_size
  node_max_size                = var.node_max_size
  admin_user_arn               = "arn:aws:iam::${var.aws_account_id}:user/${var.admin_username}"
  endpoint_public_access_cidrs = var.endpoint_public_access_cidrs
}
