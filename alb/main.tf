resource "aws_security_group" "this" {
  name        = "${var.project_name}-alb-sg"
  description = "Security Group base com acesso HTTP e HTTPS"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP Ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Ingress"
    from_port   = 443
    to_port     = 443
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
    { "Name" = "${var.project_name}-alb-sg" },
    var.tags
  )
}

resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  load_balancer_type = var.load_balancer_type
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.this.id]

  tags = merge(
    { "Name" = "${var.project_name}-alb" },
    var.tags
  )
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port                = "80"
  protocol            = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name     = "${var.project_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/" # Em qual URL o balancer vai "bater" para ver se a máquina está viva
    healthy_threshold   = 2   # Quantos sucessos seguidos para declarar a máquina viva
    unhealthy_threshold = 2   # Quantas falhas para declarar ela morta (e tirar o tráfego dela)
  }
  
}
