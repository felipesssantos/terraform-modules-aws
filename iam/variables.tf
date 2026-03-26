variable "role_name" {
  description = "Nome da role a ser criada"
  type        = string
}

variable "trusted_services" {
  description = "Lista de serviços da AWS que podem assumir esta role (trust policy). Ex: [\"ec2.amazonaws.com\"]"
  type        = list(string)
}

variable "managed_policy_arns" {
  description = "Lista de ARNs de políticas oficiais da AWS para anexar à role"
  type        = list(string)
  default     = []
}

variable "create_instance_profile" {
  description = "Flag dizendo se deve ser criado um IAM Instance Profile (necessário se for usar em EC2)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags padronizadas para os recursos de IAM"
  type        = map(string)
  default     = {}
}
