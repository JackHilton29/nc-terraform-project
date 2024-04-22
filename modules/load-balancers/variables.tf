variable "vpc_id" {
  type = string
  description = "ID of our vpc"
}

variable "target_port" {
  type = number
  description = "port for our target groups"
}

variable "lb_port" {
  type = number
  description = "port for our target groups"
}

variable "protocol" {
  type = string
  description = "protocol for our target groups"
}

variable "protocol_version" {
  type = string
  description = "protocol version for our target groups"
}

variable "lighting_instance_ids" {
  type = list(string)
  description = "list of lighting service instance ids"
}

variable "heating_instance_ids" {
  type = list(string)
  description = "list of heating service instance ids"
}

variable "status_instance_ids" {
  type = list(string)
  description = "list of status service instance ids"
}

variable "auth_instance_ids" {
  type = list(string)
  description = "list of auth service instance ids"
}

variable "load_balancer_type" {
  type = string
  description = "type of load balancer"
}

variable "public_security_groups" {
  type = list(string)
  description = "list of security group ids for public load balancer"
}

variable "public_subnets" {
  type = list(string)
  description = "list of subnet ids for public load balancer"
}

variable "private_security_groups" {
  type = list(string)
  description = "list of security group ids for private load balancer"
}

variable "private_subnets" {
  type = list(string)
  description = "list of subnet ids for private load balancer"
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