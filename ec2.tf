resource "aws_launch_template" "this" {
  name_prefix   = local.namespaced_service_name
  image_id      = var.instance_config.ami
  instance_type = var.instance_config.type
  key_name      = var.instance_config.key_name

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.autoscaling_group.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      "Name" = "${local.namespaced_service_name}-server"
    }
  }
}

resource "aws_instance" "jenkins" {
  ami           = var.instance_config.ami
  instance_type = var.instance_config.type

  vpc_security_group_ids = [aws_security_group.jenkins.id]
  subnet_id              = aws_subnet.this["pvt_a"].id
  availability_zone      = aws_subnet.this["pvt_a"].availability_zone

  tags = {
    "Name" = "${local.namespaced_service_name}-jenkins"
  }
}

