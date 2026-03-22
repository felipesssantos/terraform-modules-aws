variable "project_name" {
  description = "Nome do projeto para ser usado como prefixo nos recursos"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloco CIDR para a VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Lista de blocos CIDR para as subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Lista de blocos CIDR para as subnets privadas"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "azs" {
  description = "Lista de Availability Zones onde as subnets serão criadas"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "tags" {
  description = "Tags adicionais para todos os recursos"
  type        = map(string)
  default     = {}
}
