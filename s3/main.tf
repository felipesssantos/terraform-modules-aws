# Criação unificada do Container S3
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = merge(
    {
      "Name"    = var.bucket_name
    },
    var.tags
  )
}

# Habilidade ativada de retenção cronológica do State (Versionamento)
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}
