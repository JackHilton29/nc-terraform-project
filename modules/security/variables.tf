variable "vpc_id" {
  type = string
  description = "ID of vpc"
}

variable "security_groups" {
  type = list(string)
  description = "List of security groups"
}

variable "http_security_group" {
  type = object({
    index = number
    ingress_rules = object({
      cidr_ipv4 = string,
      cidr_ipv6 = string,
      from_port = number,
      to_port = number,
      ip_protocol = string
    })
    egress_rules = object({
      cidr_ipv4 = string,
      cidr_ipv6 = string,
      ip_protocol = string
    })
  })
  description = "HTTP security group with ingress and egress rules"
}

variable "https_security_group" {
  type = object({
    index = number
    ingress_rules = object({
      cidr_ipv4 = string,
      cidr_ipv6 = string,
      from_port = number,
      to_port = number,
      ip_protocol = string
    })
    egress_rules = object({
      cidr_ipv4 = string,
      cidr_ipv6 = string,
      ip_protocol = string
    })
  })
  description = "HTTP security group with ingress and egress rules"
}

variable "ssh_security_group" {
  type = object({
    index = number
    ingress_rules = object({
      from_port = number,
      to_port = number,
      ip_protocol = string
    })
  })
  description = "SSH security group"
}

variable "ssh_private_security_group" {
  type = object({
    index = number
    ingress_rules = object({
      from_port = number,
      to_port = number,
      ip_protocol = string
    })
  })
  description = "SSH security group"
}

variable "p3000_security_group" {
  type = object({
    index = number
    ingress_rules = object({
      cidr_ipv4 = string,
      cidr_ipv6 = string,
      from_port = number,
      to_port = number,
      ip_protocol = string
    })
    egress_rules = object({
      cidr_ipv4 = string,
      cidr_ipv6 = string,
      ip_protocol = string
    })
  })
  description = "3000 security group with ingress and egress rules"
}

# variable "instance_ip" {
#   type = string
#   description = "Local ip address of EC2 instance to connect from on private subnet"
# }