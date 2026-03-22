output "bucket_id" {
  description = "ID Nominal Exato que repassaremos pro terraform guardar o state"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "Endereço absoluto pra criação de Roles e segurança Restrita de Usuários no IAM"
  value       = aws_s3_bucket.this.arn
}
