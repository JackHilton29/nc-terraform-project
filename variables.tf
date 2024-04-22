####
## Networking
####

variable "vpc_cidr_block" {
  type = string
  description = "CIDR block for vpc"
}

variable "vpc_enable_dns_hostnames" {
  type = bool
  description = "Boolean value to enable/disable DNS hostnames for vpc"
}

variable "vpc_name" {
  type = string
  description = "Name of vpc"
}

variable "igw_name" {
  type = string
  description = "Name of igw"
}

variable "public_subnet_name" {
  type = string
  description = "Name of public subnets"
}

variable "private_subnet_name" {
  type = string
  description = "Name of private subnets"
}

variable "azs" {
  type = list(string)
  description = "List of availability zones"
}

variable "public_subnets" {
  type = list(string)
  description = "List of public subnets"
}

variable "private_subnets" {
  type = list(string)
  description = "List of private subnets"
}

variable "public_route_table_name" {
  type = string
  description = "Name of public route table"
}

variable "private_route_table_name" {
  type = string
  description = "Name of private route table"
}

variable "public_route_table_cidr_block" {
  type = string
  description = "CIDR block for route in public route table"
}

variable "eip_domain" {
  type = string
  description = "Domain of elastic IP"
}

variable "nat_name" {
  type = string
  description = "Name of NAT gateway"
}

variable "nat_destination_cidr_block" {
  type = string
  description = "CIDR block of destination for NAT gateway"
}

####
## Security
####

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

####
## Dynamo
####

variable "dynamo_tables" {
  type = list(object({
    name = string,
    hash_key = string
    hash_key_type = string
    billding_mode = string
  }))
}

####
## Servers
####

variable "number_of_instances" {
  type = number
  description = "Number of instances to run for each service"
}

variable "ami" {
  type = string
  description = "AMI for EC2 instance to use"
}

variable "instance_type" {
  type = string
  description = "Type of EC2 instance to use"
}

variable "key_name" {
  type = string
  description = "Key name for SSH connection"
}

####
## Load Balancers
####

variable "target_port" {
  type = number
  description = "port for our target groups"
}

variable "lb_port" {
  type = number
  description = "port for our load balancers"
}

variable "lb_protocol" {
  type = string
  description = "protocol for our target groups"
}

variable "lb_protocol_version" {
  type = string
  description = "protocol version for our target groups"
}

variable "load_balancer_type" {
  type = string
  description = "type of load balancer"
}

variable "action_type" {
  type = string
  description = "type of action for load balancer"
}

variable "path_conditions" {
  type = object({
    lighting = list(string),
    heating = list(string),
    status = list(string),
    auth = list(string)
  })
  description = "path conditions for path based routing"
}

variable "health_checks" {
  type = object({
    lighting = string,
    heating = string,
    status = string,
    auth = string
  })
  description = "paths for health checks"
}

####
## Autoscaling
####

variable "amis" {
  type = object({
    lighting = string,
    heating = string,
    status = string,
    auth = string
  })
  description = "AMI's for EC2 instances"
}

variable "max_size" {
  type = number
  description = "maximum number of EC2 instances"
}

variable "min_size" {
  type = number
  description = "minimum number of EC2 instances"
}

variable "desired_capacity" {
  type = number
  description = "number of desired EC2 instances"
}

variable "health_check_grace_period" {
  type = number
  description = "health check grace period"
}

variable "health_check_type" {
  type = string
  description = "type of health check"
}

variable "number_of_AZs" {
  type = number
  description = "Number of availability zones for autoscaling groups"
}