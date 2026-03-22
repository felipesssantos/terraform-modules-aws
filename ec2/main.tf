# Definição do Security Group restrito no VPC referenciado
resource "aws_security_group" "this" {
  name        = "${var.project_name}-sg"
  description = "Security Group base com acesso SSH e HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP Ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { "Name" = "${var.project_name}-sg" },
    var.tags
  )
}

# Instância EC2 vinculada aos parâmetros de Subnet e SG recebidos
resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id 
  key_name      = var.key_name != "" ? var.key_name : null

  vpc_security_group_ids = [aws_security_group.this.id]
  
  tags = merge(
    { "Name" = "${var.project_name}-ec2" },
    var.tags
  )
}
