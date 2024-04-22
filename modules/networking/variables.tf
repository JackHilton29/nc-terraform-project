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