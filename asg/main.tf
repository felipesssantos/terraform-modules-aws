resource "aws_launch_template" "this" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.this.id]

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  tags = merge(
    { "Name" = "${var.project_name}-lt" },
    var.tags
  )
}

resource "aws_autoscaling_group" "this" {
  name                      = "${var.project_name}-asg"
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.subnet_ids
  target_group_arns         = var.target_group_arns

  # O ASG não aceita o atributo estático 'tags = {}'. Ele exige um bloco 'tag {}' iterado!
  dynamic "tag" {
    for_each = merge({ "Name" = "${var.project_name}-asg" }, var.tags)
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_security_group" "this" {
  name        = "${var.project_name}-asg-sg"
  description = "Security Group das maquinas do ASG"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { "Name" = "${var.project_name}-asg-sg" },
    var.tags
  )
}