output "role_name" {
  description = "O nome da IAM Role criada."
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "O identificador global (ARN) da IAM Role."
  value       = aws_iam_role.this.arn
}

output "instance_profile_name" {
  description = "O nome do Instance Profile se ele foi criado."
  value       = var.create_instance_profile ? aws_iam_instance_profile.this[0].name : null
}
