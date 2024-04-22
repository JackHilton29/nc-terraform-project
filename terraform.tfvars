####
## Networking
####

vpc_cidr_block = "10.0.0.0/20"
vpc_enable_dns_hostnames = true
vpc_name = "ce-terraform-project"
igw_name = "igw"
public_subnet_name = "subnet-public"
private_subnet_name = "subnet-private"
azs = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
public_subnets = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
public_route_table_name = "rtb-public"
private_route_table_name = "rtb-private"
public_route_table_cidr_block = "0.0.0.0/0"
eip_domain = "vpc"
nat_name = "ce-terraform-project-NAT"
nat_destination_cidr_block = "0.0.0.0/0"

####
## Security
####

security_groups = [ "HTTP", "HTTPS", "SSH", "SSH_PRIVATE", "3000" ]
http_security_group = {
    index = 0
    ingress_rules = {
      cidr_ipv4 = "0.0.0.0/0",
      cidr_ipv6 = "::/0",
      from_port = 80,
      to_port = 80,
      ip_protocol = "tcp"
    },
    egress_rules = {
      cidr_ipv4 = "0.0.0.0/0",
      cidr_ipv6 = "::/0",
      ip_protocol = "-1"
    }
  }
https_security_group = {
    index = 1
    ingress_rules = {
      cidr_ipv4 = "0.0.0.0/0",
      cidr_ipv6 = "::/0",
      from_port = 443,
      to_port = 443,
      ip_protocol = "tcp"
    },
    egress_rules = {
      cidr_ipv4 = "0.0.0.0/0",
      cidr_ipv6 = "::/0",
      ip_protocol = "-1"
    }
  }
ssh_security_group = {
    index = 2
    ingress_rules = {
      from_port = 22,
      to_port = 22,
      ip_protocol = "tcp"
    }
  }

ssh_private_security_group = {
    index = 3
    ingress_rules = {
      from_port = 22,
      to_port = 22,
      ip_protocol = "tcp"
    }
  }

p3000_security_group = {
    index = 0
    ingress_rules = {
      cidr_ipv4 = "0.0.0.0/0",
      cidr_ipv6 = "::/0",
      from_port = 3000,
      to_port = 3000,
      ip_protocol = "tcp"
    },
    egress_rules = {
      cidr_ipv4 = "0.0.0.0/0",
      cidr_ipv6 = "::/0",
      ip_protocol = "-1"
    }
  }

####
## Dynamo
####

dynamo_tables = [ {
  name = "Lighting",
  hash_key = "id",
  hash_key_type = "N",
  billding_mode = "PAY_PER_REQUEST"
},
{
  name = "Heating",
  hash_key = "id",
  hash_key_type = "N",
  billding_mode = "PAY_PER_REQUEST"
} ]

####
## Servers
####

number_of_instances = 0
ami = "ami-0505148b3591e4c07"
instance_type = "t2.micro"
key_name = "tf-project-key-pair"

####
## Load Balancers
####

target_port = 3000
lb_port = 80
lb_protocol = "HTTP"
lb_protocol_version = "HTTP1"
load_balancer_type = "application"
action_type = "forward"
path_conditions = {
  lighting = ["/api/lights*"],
  heating = ["/api/heating*"],
  status = ["/api/status*"],
  auth = ["/api/auth*"]
}
health_checks = {
  lighting = "/api/lights/health",
  heating = "/api/heating",
  status = "/api/status",
  auth = "/api/auth"
}

####
## Autoscaling
####

amis = {
  lighting = "ami-08b4701ea32ed26e2",
  heating = "ami-0091f689b858a1190",
  status = "ami-0dc15d03bfbd703be",
  auth = "ami-097155f3f4e3f2e1c"
}
max_size = 1
min_size = 1
desired_capacity = 1
health_check_grace_period = 300
health_check_type = "ELB"
number_of_AZs=1