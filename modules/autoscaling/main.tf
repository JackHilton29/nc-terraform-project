####
## Lighting
####

resource "aws_launch_template" "lighting" {
  name = "lighting_launch_template"

  image_id = var.amis.lighting

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  key_name = "tf-project-key-pair"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.public_security_groups
    subnet_id = var.public_subnet
  }

  user_data = filebase64("${path.module}/../../user-data.sh")
}

resource "aws_autoscaling_group" "lighting" {
  name                      = "lighting-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = true
  launch_template {
    name = aws_launch_template.lighting.name
    version = aws_launch_template.lighting.latest_version
  }
  vpc_zone_identifier       = [var.public_subnet]
}

resource "aws_autoscaling_attachment" "lighting" {
  autoscaling_group_name = aws_autoscaling_group.lighting.name
  lb_target_group_arn = var.target_group_arns.lighting
}

####
## Heating
####

resource "aws_launch_template" "heating" {
  name = "heating_launch_template"

  image_id = var.amis.heating

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  key_name = "tf-project-key-pair"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.public_security_groups
    subnet_id = var.public_subnet
  }

  user_data = filebase64("${path.module}/../../user-data.sh")
}

resource "aws_autoscaling_group" "heating" {
  name                      = "heating-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = true
  launch_template {
    name = aws_launch_template.heating.name
    version = aws_launch_template.heating.latest_version
  }
  vpc_zone_identifier       = [var.public_subnet]
}

resource "aws_autoscaling_attachment" "heating" {
  autoscaling_group_name = aws_autoscaling_group.heating.name
  lb_target_group_arn = var.target_group_arns.heating
}

####
## Status
####

resource "aws_launch_template" "status" {
  name = "status_launch_template"

  image_id = var.amis.status

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  key_name = "tf-project-key-pair"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = var.public_security_groups
    subnet_id = var.public_subnet
  }

  user_data = filebase64("${path.module}/../../user-data.sh")
}

resource "aws_autoscaling_group" "status" {
  name                      = "status-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = true
  launch_template {
    name = aws_launch_template.status.name
    version = aws_launch_template.status.latest_version
  }
  vpc_zone_identifier       = [var.public_subnet]
}

resource "aws_autoscaling_attachment" "status" {
  autoscaling_group_name = aws_autoscaling_group.status.name
  lb_target_group_arn = var.target_group_arns.status
}

####
## Auth
####

resource "aws_launch_template" "auth" {
  name = "auth_launch_template"

  image_id = var.amis.auth

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = var.instance_type

  key_name = "tf-project-key-pair"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups = var.private_security_groups
    subnet_id = var.private_subnet
  }

  user_data = filebase64("${path.module}/../../user-data.sh")
}

resource "aws_autoscaling_group" "auth" {
  name                      = "auth-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = true
  launch_template {
    name = aws_launch_template.auth.name
    version = aws_launch_template.auth.latest_version
  }
  vpc_zone_identifier       = [var.private_subnet]
}

resource "aws_autoscaling_attachment" "auth" {
  autoscaling_group_name = aws_autoscaling_group.auth.name
  lb_target_group_arn = var.target_group_arns.auth
}