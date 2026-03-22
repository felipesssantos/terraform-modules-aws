output "instance_id" {
  description = "O endereço do identificador físico local da máquina virtual"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "O IP Global mapeado para essa instância para requisições externas e acesso via navegador ou Putty/Terminal SSH"
  value       = aws_instance.this.public_ip
}

output "security_group_id" {
  description = "Resumo da ID Virtual Fence de proteção dessa EC2"
  value       = aws_security_group.this.id
}
