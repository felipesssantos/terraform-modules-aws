variable "bucket_name" {
  description = "Nome de registro do Cofrinho (ID Mestre tem que ser Único mundialmente na AWS)"
  type        = string
}

variable "tags" {
  description = "Acompanhamento e organização da Nuvem de Metadados"
  type        = map(string)
  default     = {}
}
