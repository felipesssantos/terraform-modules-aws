variable "project_name" {
  description = "Nome do projeto para dar nome ao ALB"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde o ALB e o SG serão criados"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de Subnets Públicas onde o ALB vai rotear o tráfego (no mínimo 2 para alta disponibilidade)"
  type        = list(string)
}

variable "load_balancer_type" {
  description = "Tipo de Load Balancer (application ou network)"
  type        = string
  default     = "application"
}   

variable "tags" {
  description = "Tags a serem aplicadas nos recursos"
  type        = map(string)
  default     = {}
}

