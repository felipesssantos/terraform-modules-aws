# Documento de Trust Policy dinâmica, para que a role possa ser usada por EC2, Lambda, ECS, etc.
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = var.trusted_services
    }
  }
}

# Cria a IAM Role com a política de confiança acima
resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

# Faz a iteração (loop) pelas políticas que quiser anexar
resource "aws_iam_role_policy_attachment" "managed" {
  for_each   = toset(var.managed_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.value
}

# Se create_instance_profile for verdadeiro, ele entra como capa da role para ser usado em instâncias EC2
resource "aws_iam_instance_profile" "this" {
  count = var.create_instance_profile ? 1 : 0
  name  = "${var.role_name}-profile"
  role  = aws_iam_role.this.name
}
