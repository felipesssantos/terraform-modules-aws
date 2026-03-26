terraform {
  required_version = ">= 1.0.0"
  
  backend "s3" {
    bucket = "mavie-master-tf-state-vault-7813a"
    key    = "examples/vpc-basic/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Instância Módulo VPC (Infraestrutura de Rede Base)
module "minha_vpc_de_teste" {
  source = "../../vpc"

  project_name    = var.project_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs

  tags = {
    Environment = "Desenvolvimento via Tfvars"
    Owner       = "Mavie"
  }
}

# Acesso gerido pelo AWS Systems Manager (SSM) Session Manager

# Módulo de IAM criando as permissões de SSM dinamicamente
module "iam_ec2_ssm" {
  source = "../../iam"

  role_name               = "${var.project_name}-ssm-role"
  trusted_services        = ["ec2.amazonaws.com"]
  managed_policy_arns     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  create_instance_profile = true
  
  tags = {
    Environment = "Desenvolvimento via Modulo IAM"
    Owner       = "Felipe"
  }
}
# Instância Módulo EC2 (Servidor)
module "meu_servidor_web" {
  source = "../../ec2"

  count = var.count_ec2

  project_name  = "${var.project_name}-${count.index + 1}"
  
  # Acoplamento das saídas geradas pela VPC (Rede) dentro da EC2
  vpc_id        = module.minha_vpc_de_teste.vpc_id
  subnet_id     = module.minha_vpc_de_teste.public_subnets_ids[count.index % length(module.minha_vpc_de_teste.public_subnets_ids)]
  
  ami_id        = var.ami_id
  instance_type = "t2.micro"
  iam_instance_profile = module.iam_ec2_ssm.instance_profile_name

  tags = {
    Environment = "Desenvolvimento via Modulo Terraform"
    Owner       = "Felipe"
  }
}

