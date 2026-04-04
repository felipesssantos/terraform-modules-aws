variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "count_ec2" {
  description = "Quantidade de instâncias EC2"
  type        = number
  default     = 2
}

variable "vpc_cidr" {
  description = "Bloco IP da VPC"
  type        = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "ami_id" {
  description = "ID da imagem da máquina na AWS"
  type        = string
}
