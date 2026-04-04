variable "region" {
  description = "Região da AWS"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome raiz da infraestrutura"
  type        = string
  default     = "projeto01"
}

variable "vpc_cidr" {
  description = "Range de IP da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Lista de subnets públicas (expostas à internet para ALB)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Lista de subnets privadas (blindadas para hospedar ASG/Bancos de Dados)"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "Zonas de Disponibilidade de infraestrutura"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "ami_id" {
  description = "ID do Sistema Operacional (AMI) para inicializar no ASG"
  type        = string
  default     = "ami-051f8a213df8bc089" # Amazon Linux 2023 em us-east-1
}

variable "instance_type" {
  description = "Tamanho de processamento do Servidor EC2"
  type        = string
  default     = "t2.micro"
}

variable "min_size" {
  description = "Quantidade mínima absoluta de instâncias vivas"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Quantidade máxima de instâncias para escala em horário de pico"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Quantidade desejada constante rodando no Auto Scaling"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags padronizadas essenciais de custos e identificação em toda AWS"
  type        = map(string)
  default = {
    Environment = "Desenvolvimento"
    Owner       = "Mavie"
  }
}
