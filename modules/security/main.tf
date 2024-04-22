data "http" "myipaddr" {
   url = "http://icanhazip.com"
}

resource "aws_security_group" "sg" {
  count = length(var.security_groups)
  name        = var.security_groups[count.index]
  description = "Security group for ${var.security_groups[count.index]} protocol"
  vpc_id      = var.vpc_id
}

####
## HTTP
####

resource "aws_vpc_security_group_ingress_rule" "incoming_http_ipv6" {
  security_group_id = aws_security_group.sg[var.http_security_group.index].id

  cidr_ipv6   = var.http_security_group.ingress_rules.cidr_ipv6
  from_port   = var.http_security_group.ingress_rules.from_port
  ip_protocol = var.http_security_group.ingress_rules.ip_protocol
  to_port     = var.http_security_group.ingress_rules.to_port
}

resource "aws_vpc_security_group_egress_rule" "outgoing_http_ipv6" {
  security_group_id = aws_security_group.sg[var.http_security_group.index].id

  cidr_ipv6   = var.http_security_group.egress_rules.cidr_ipv6
  ip_protocol = var.http_security_group.egress_rules.ip_protocol
}

resource "aws_vpc_security_group_ingress_rule" "incoming_http_ipv4" {
  security_group_id = aws_security_group.sg[var.http_security_group.index].id

  cidr_ipv4   = var.http_security_group.ingress_rules.cidr_ipv4
  from_port   = var.http_security_group.ingress_rules.from_port
  ip_protocol = var.http_security_group.ingress_rules.ip_protocol
  to_port     = var.http_security_group.ingress_rules.to_port
}

resource "aws_vpc_security_group_egress_rule" "outgoing_http_ipv4" {
  security_group_id = aws_security_group.sg[var.http_security_group.index].id

  cidr_ipv4   = var.http_security_group.egress_rules.cidr_ipv4
  ip_protocol = var.http_security_group.egress_rules.ip_protocol
}

####
## HTTPS
####

resource "aws_vpc_security_group_ingress_rule" "incoming_https_ipv6" {
  security_group_id = aws_security_group.sg[var.https_security_group.index].id

  cidr_ipv6   = var.https_security_group.ingress_rules.cidr_ipv6
  from_port   = var.https_security_group.ingress_rules.from_port
  ip_protocol = var.https_security_group.ingress_rules.ip_protocol
  to_port     = var.https_security_group.ingress_rules.to_port
}

resource "aws_vpc_security_group_egress_rule" "outgoing_https_ipv6" {
  security_group_id = aws_security_group.sg[var.https_security_group.index].id

  cidr_ipv6   = var.https_security_group.egress_rules.cidr_ipv6
  ip_protocol = var.https_security_group.egress_rules.ip_protocol
}

resource "aws_vpc_security_group_ingress_rule" "incoming_https_ipv4" {
  security_group_id = aws_security_group.sg[var.https_security_group.index].id

  cidr_ipv4   = var.https_security_group.ingress_rules.cidr_ipv4
  from_port   = var.https_security_group.ingress_rules.from_port
  ip_protocol = var.https_security_group.ingress_rules.ip_protocol
  to_port     = var.https_security_group.ingress_rules.to_port
}

resource "aws_vpc_security_group_egress_rule" "outgoing_https_ipv4" {
  security_group_id = aws_security_group.sg[var.https_security_group.index].id

  cidr_ipv4   = var.https_security_group.egress_rules.cidr_ipv4
  ip_protocol = var.https_security_group.egress_rules.ip_protocol
}

####
## 3000
####

####
## HTTP
####

resource "aws_vpc_security_group_ingress_rule" "incoming_p3000_ipv6" {
  security_group_id = aws_security_group.sg[var.p3000_security_group.index].id

  cidr_ipv6   = var.p3000_security_group.ingress_rules.cidr_ipv6
  from_port   = var.p3000_security_group.ingress_rules.from_port
  ip_protocol = var.p3000_security_group.ingress_rules.ip_protocol
  to_port     = var.p3000_security_group.ingress_rules.to_port
}

resource "aws_vpc_security_group_ingress_rule" "incoming_p3000_ipv4" {
  security_group_id = aws_security_group.sg[var.p3000_security_group.index].id

  cidr_ipv4   = var.p3000_security_group.ingress_rules.cidr_ipv4
  from_port   = var.p3000_security_group.ingress_rules.from_port
  ip_protocol = var.p3000_security_group.ingress_rules.ip_protocol
  to_port     = var.p3000_security_group.ingress_rules.to_port
}

####
## SSH
####

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.sg[var.ssh_security_group.index].id

  cidr_ipv4   = "${chomp(data.http.myipaddr.response_body)}/32"
  from_port   = var.ssh_security_group.ingress_rules.from_port
  ip_protocol = var.ssh_security_group.ingress_rules.ip_protocol
  to_port     = var.ssh_security_group.ingress_rules.to_port
}

# resource "aws_vpc_security_group_ingress_rule" "ssh_private" {
#   security_group_id = aws_security_group.sg[var.ssh_private_security_group.index].id

#   cidr_ipv4   = "${var.instance_ip}/32"
#   from_port   = var.ssh_private_security_group.ingress_rules.from_port
#   ip_protocol = var.ssh_private_security_group.ingress_rules.ip_protocol
#   to_port     = var.ssh_private_security_group.ingress_rules.to_port
# }