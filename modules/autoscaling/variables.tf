variable "amis" {
  type = object({
    lighting = string,
    heating = string,
    status = string,
    auth = string
  })
  description = "AMI's for EC2 instances"
}

variable "instance_type" {
  type = string
  description = "type of EC2 instance"
}

variable "public_security_groups" {
  type = list(string)
  description = "list of public security groups"
}

variable "private_security_groups" {
  type = list(string)
  description = "list of private security groups"
}

variable "public_subnet" {
  type = string
  description = "subnet for public instances"
}

variable "private_subnet" {
  type = string
  description = "subnet for private instances"
}

variable "vpc_subnets" {
  type = list(string)
  description = "vpc subnet ids"
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

variable "target_group_arns" {
  type = object({
    lighting = string,
    heating = string,
    status = string,
    auth = string
  })
  description = "ARNs for target groups"
}