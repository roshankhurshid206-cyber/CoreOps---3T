# ---------------------------------------------------------------------------
# CoreOps-3T Root Orchestrator
# Wires the Network -> Compute -> Storage tiers together.
# ---------------------------------------------------------------------------

module "vpc" {
  source      = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment
}

module "ec2" {
  source             = "./modules/ec2"
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type      = var.instance_type
  ami_id             = var.ami_id
  key_name           = var.key_name
}

module "rds" {
  source                = "./modules/rds"
  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  db_subnet_group_name  = module.vpc.db_subnet_group_name
  web_security_group_id = module.ec2.security_group_id
  db_instance_class     = var.db_instance_class
  allocated_storage     = var.allocated_storage
  db_username           = var.db_username
  db_password           = var.db_password
}
