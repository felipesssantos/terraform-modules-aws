output "resultado_vpc_id" {
  description = "ID da VPC criada no teste"
  value       = module.minha_vpc_de_teste.vpc_id
}

output "ip_publico_do_servidor" {
  description = "Lista de IPs públicos das instâncias criadas"
  value       = module.meu_servidor_web[*].public_ip
}

output "ids_das_instancias" {
  description = "Lista dos IDs das instâncias (úteis para conectar via AWS CLI + SSM)"
  value       = module.meu_servidor_web[*].instance_id
}
