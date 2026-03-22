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

# Gerador local de par de chaves SSH para testes
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Envio da chave pública para cadastro na AWS
resource "aws_key_pair" "this" {
  key_name   = "${var.project_name}-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Exportando fisicamente a chave privada para acessar a instância
resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/${var.project_name}-key.pem"
  file_permission = "0400"
}

# Instância Módulo EC2 (Servidor)
module "meu_servidor_web" {
  source = "../../ec2"

  project_name  = var.project_name
  
  # Acoplamento das saídas geradas pela VPC (Rede) dentro da EC2
  vpc_id        = module.minha_vpc_de_teste.vpc_id
  subnet_id     = module.minha_vpc_de_teste.public_subnets_ids[0]
  
  ami_id        = var.ami_id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.this.key_name

  tags = {
    Environment = "Desenvolvimento via Modulo Terraform"
    Owner       = "Felipe"
  }
}

output "resultado_vpc_id" {
  value = module.minha_vpc_de_teste.vpc_id
}

output "ip_publico_do_servidor" {
  value = module.meu_servidor_web.public_ip
}
