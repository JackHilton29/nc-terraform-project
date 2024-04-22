####
## Lighting Target Group
####

resource "aws_lb_target_group" "lighting" {
  name     = "lighting-target-group"
  port     = var.target_port
  protocol = var.protocol
  protocol_version = var.protocol_version
  vpc_id   = var.vpc_id
  health_check {
    path = var.health_checks.lighting
    protocol = var.protocol
  }
}

resource "aws_lb_target_group_attachment" "lighting" {
  count = length(var.lighting_instance_ids)

  target_group_arn = aws_lb_target_group.lighting.arn
  target_id        = var.lighting_instance_ids[count.index]
  port             = var.target_port
}

####
## Heating Target Group
####

resource "aws_lb_target_group" "heating" {
  name     = "heating-target-group"
  port     = var.target_port
  protocol = var.protocol
  protocol_version = var.protocol_version
  vpc_id   = var.vpc_id
  health_check {
    path = var.health_checks.heating
    protocol = var.protocol
  }
}

resource "aws_lb_target_group_attachment" "heating" {
  count = length(var.heating_instance_ids)

  target_group_arn = aws_lb_target_group.heating.arn
  target_id        = var.heating_instance_ids[count.index]
  port             = var.target_port
}

####
## Status Target Group
####

resource "aws_lb_target_group" "status" {
  name     = "status-target-group"
  port     = var.target_port
  protocol = var.protocol
  protocol_version = var.protocol_version
  vpc_id   = var.vpc_id
  health_check {
    path = var.health_checks.status
    protocol = var.protocol
  }
}

resource "aws_lb_target_group_attachment" "status" {
  count = length(var.status_instance_ids)

  target_group_arn = aws_lb_target_group.status.arn
  target_id        = var.status_instance_ids[count.index]
  port             = var.target_port
}

####
## Auth Target Group
####

resource "aws_lb_target_group" "auth" {
  name     = "auth-target-group"
  port     = var.target_port
  protocol = var.protocol
  protocol_version = var.protocol_version
  vpc_id   = var.vpc_id
  health_check {
    path = var.health_checks.auth
    protocol = var.protocol
  }
}

resource "aws_lb_target_group_attachment" "auth" {
  count = length(var.auth_instance_ids)

  target_group_arn = aws_lb_target_group.auth.arn
  target_id        = var.auth_instance_ids[count.index]
  port             = var.target_port
}

####
## Public Load Balancer
####

resource "aws_lb" "public" {
  name               = "public-lb"
  internal           = false
  load_balancer_type = var.load_balancer_type
  security_groups    = var.public_security_groups
  subnets = var.public_subnets
}

resource "aws_lb_listener" "public" {
  load_balancer_arn = aws_lb.public.arn
  port              = var.lb_port
  protocol          = var.protocol

  default_action {
    type             = var.action_type
    target_group_arn = aws_lb_target_group.status.arn
  }
}

####
## Private Load Balancer
####

resource "aws_lb" "private" {
  name               = "private-lb"
  internal           = true
  load_balancer_type = var.load_balancer_type
  security_groups    = var.private_security_groups
  subnets = var.private_subnets
}

resource "aws_lb_listener" "private" {
  load_balancer_arn = aws_lb.private.arn
  port              = var.lb_port
  protocol          = var.protocol

  default_action {
    type             = var.action_type
    target_group_arn = aws_lb_target_group.auth.arn
  }
}

####
## Lighting Listener Rules
####

resource "aws_lb_listener_rule" "lighting" {
  listener_arn = aws_lb_listener.public.arn
  priority     = 1

  action {
    type             = var.action_type
    target_group_arn = aws_lb_target_group.lighting.arn
  }

  condition {
    path_pattern {
      values = var.path_conditions.lighting
    }
  }
}

####
## Heating Listener Rules
####

resource "aws_lb_listener_rule" "heating" {
  listener_arn = aws_lb_listener.public.arn
  priority     = 2

  action {
    type             = var.action_type
    target_group_arn = aws_lb_target_group.heating.arn
  }

  condition {
    path_pattern {
      values = var.path_conditions.heating
    }
  }
}

####
## Status Listener Rules
####

resource "aws_lb_listener_rule" "status" {
  listener_arn = aws_lb_listener.public.arn
  priority     = 3

  action {
    type             = var.action_type
    target_group_arn = aws_lb_target_group.status.arn
  }

  condition {
    path_pattern {
      values = var.path_conditions.status
    }
  }
}

####
## Auth Listener Rules
####

resource "aws_lb_listener_rule" "auth" {
  listener_arn = aws_lb_listener.private.arn
  priority     = 4

  action {
    type             = var.action_type
    target_group_arn = aws_lb_target_group.auth.arn
  }

  condition {
    path_pattern {
      values = var.path_conditions.auth
    }
  }
}
