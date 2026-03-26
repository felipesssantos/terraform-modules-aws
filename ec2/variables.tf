variable "project_name" {
  description = "Prefixo para a nomenclatura da EC2 e do SG"
  type        = string
}

variable "vpc_id" {
  description = "ID lógico da VPC onde a máquina e o Security Group vão existir"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet (pública ou privada) onde o cabo de rede será plugado"
  type        = string
}

variable "ami_id" {
  description = "ID da imagem de SO na AWS (Amazon Linux 2023 por padrão na us-east-1)"
  type        = string
  default     = "ami-051f8a213df8bc089" 
}

variable "instance_type" {
  description = "Poder de processamento de hardware da máquina"
  type        = string
  default     = "t2.micro" # Tier grátis
}

variable "tags" {
  description = "Tags padronizadas adicionais"
  type        = map(string)
  default     = {}
}

variable "key_name" {
  description = "Nome da chave SSH para associar à instância"
  type        = string
  default     = ""
}

variable "iam_instance_profile" {
  description = "Nome do IAM Instance Profile (criado no modulo IAM) para a instância EC2"
  type        = string
  default     = null
}
