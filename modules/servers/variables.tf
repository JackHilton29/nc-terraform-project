variable "public_subnet" {
  type = string
  description = "Public subnet to use for services"
}

variable "private_subnet" {
  type = string
  description = "Private subnet to use for services"
}

variable "public_security_groups" {
  type = list(string)
  description = "List of security groups for public subnets"
}

variable "private_security_groups" {
  type = list(string)
  description = "List of security groups for private subnets"
}

variable "ami" {
  type = string
  description = "AMI for EC2 instance to use"
}

variable "instance_type" {
  type = string
  description = "Type of EC2 instance to use"
}

variable "number_of_instance" {
  type = number
  description = "Number of current instance"
}

variable "key_name" {
  type = string
  description = "Key name for SSH connection"
}