output "vpc_id" {
  description = "ID da VPC gerada"
  value       = aws_vpc.this.id
}

output "public_subnets_ids" {
  description = "Lista com os IDs das subnets públicas"
  value       = aws_subnet.public[*].id
}

output "private_subnets_ids" {
  description = "Lista com os IDs das subnets privadas"
  value       = aws_subnet.private[*].id
}

output "internet_gateway_id" {
  description = "ID do Internet Gateway configurado"
  value       = aws_internet_gateway.this.id
}
