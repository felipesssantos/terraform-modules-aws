provider "aws" {
  region = var.region
}

module "minha_vpc" {
  source          = "../vpc"
  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
  tags            = var.tags
}

module "identidade_ec2" {
  source                  = "../iam"
  role_name               = "${var.project_name}-ec2-ssm-role"
  trusted_services        = ["ec2.amazonaws.com"]
  managed_policy_arns     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  create_instance_profile = true
  tags                    = var.tags
}

module "meu_balancer" {
  source             = "../alb"
  project_name       = var.project_name
  vpc_id             = module.minha_vpc.vpc_id
  subnet_ids         = module.minha_vpc.public_subnets_ids
  load_balancer_type = "application"
  tags               = var.tags
}

module "meu_asg" {
  source                = "../asg"
  project_name          = var.project_name
  vpc_id                = module.minha_vpc.vpc_id
  subnet_ids            = module.minha_vpc.private_subnets_ids 
  target_group_arns     = [module.meu_balancer.target_group_arn] 
  alb_security_group_id = module.meu_balancer.security_group_id
  iam_instance_profile  = module.identidade_ec2.instance_profile_name
  
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  tags                  = var.tags
}
