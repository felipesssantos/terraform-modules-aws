# Criação do bloco lógico da VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    {
      "Name" = "${var.project_name}-vpc"
    },
    var.tags
  )
}

# Estabelece o Internet Gateway para saída de tráfego
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      "Name" = "${var.project_name}-igw"
    },
    var.tags
  )
}

# Renderização iterativa e contínua das subnets públicas
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true 

  tags = merge(
    {
      "Name" = "${var.project_name}-public-subnet-${count.index + 1}"
    },
    var.tags
  )
}

# Renderização iterativa e contínua das subnets privadas
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = merge(
    {
      "Name" = "${var.project_name}-private-subnet-${count.index + 1}"
    },
    var.tags
  )
}

# Tabela de roteamento principal (Default Route -> IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    {
      "Name" = "${var.project_name}-public-rt"
    },
    var.tags
  )
}

# Associa subnets públicas iteradas à saída livre de internet
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
