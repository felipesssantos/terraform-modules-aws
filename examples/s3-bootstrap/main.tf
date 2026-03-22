terraform {
  required_version = ">= 1.0.0"
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

# Bootstrap isolado para armazenamento de Remote State 
module "meu_cofre_terraform" {
  source = "../../s3"

  bucket_name = "mavie-master-tf-state-vault-7813a" 

  tags = {
    Owner       = "Mavie"
    Environment = "Serviços Centrais Globais"
  }
}

output "meu_cofre_nome" {
  value = module.meu_cofre_terraform.bucket_id
}
