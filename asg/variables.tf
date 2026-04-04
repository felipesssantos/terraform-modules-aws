variable "project_name" {
  description = "Nome do projeto para nomear o ASG e o Launch Template"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC (necessário para criar um Security Group da máquina aqui dentro)"
  type        = string
}

variable "subnet_ids" {
  description = "Lista de subnets onde as EC2 vão nascer"
  type        = list(string)
}

variable "target_group_arns" {
  description = "Lista com o ARN do Target Group do ALB (pra amarrar a máquina nova de volta no Balancer)"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Qual o ID do security group do Load Balancer (para permitir apenas tráfego vindo dele)"
  type        = string
}


# --- Variáveis do EC2 (Launch Template) ---

variable "ami_id" {
  description = "A Imagem (OS) que vai ser clonada em todas as máquinas"
  type        = string
}

variable "instance_type" {
  description = "O tamanho e poder de cada máquina clonada"
  type        = string
  default     = "t2.micro"
}

variable "iam_instance_profile" {
  description = "Nome do Perfil IAM para liberar acesso via SSM"
  type        = string
  default     = null
}

# --- Variáveis do ASG ---

variable "min_size" {
  description = "Número mínimo de máquinas vivas simultaneamente"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Número máximo de máquinas permitidas num pico de acesso"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Número ideal de máquinas rodando no dia a dia"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags padronizadas adicionais"
  type        = map(string)
  default     = {}
}
