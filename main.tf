module "networking" {
  source = "./modules/networking"

  vpc_cidr_block = var.vpc_cidr_block
  vpc_enable_dns_hostnames = var.vpc_enable_dns_hostnames
  vpc_name = var.vpc_name
  igw_name = var.igw_name
  public_subnet_name = var.public_subnet_name
  private_subnet_name = var.private_subnet_name
  azs = var.azs
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  public_route_table_name = var.public_route_table_name
  private_route_table_name = var.private_route_table_name
  public_route_table_cidr_block = var.public_route_table_cidr_block
  eip_domain = var.eip_domain
  nat_name = var.nat_name
  nat_destination_cidr_block = var.nat_destination_cidr_block
}

module "security" {
  source = "./modules/security"

  vpc_id = module.networking.vpc_id
  security_groups = var.security_groups
  http_security_group = var.http_security_group
  https_security_group = var.https_security_group
  ssh_security_group = var.ssh_security_group
  ssh_private_security_group = var.ssh_private_security_group
  p3000_security_group = var.p3000_security_group
  #instance_ip = module.servers[0].status_instance_ip
}

module "dynamo" {
  source = "./modules/dynamo"

  count = length(var.dynamo_tables)
  table_name = var.dynamo_tables[count.index].name
  hash_key = var.dynamo_tables[count.index].hash_key
  hash_key_type = var.dynamo_tables[count.index].hash_key_type
  billing_mode = var.dynamo_tables[count.index].billding_mode
}

module "servers" {
  source = "./modules/servers"

  count = var.number_of_instances
  public_subnet = module.networking.public_subnets[count.index]
  private_subnet = module.networking.private_subnets[count.index]
  public_security_groups = module.security.public_security_groups
  private_security_groups = module.security.private_security_groups
  ami = var.ami
  instance_type = var.instance_type
  number_of_instance = count.index + 1
  key_name = var.key_name
}

module "load-balancers" {
  source = "./modules/load-balancers"
  
  vpc_id = module.networking.vpc_id
  target_port = var.target_port
  lb_port = var.lb_port
  protocol = var.lb_protocol
  protocol_version = var.lb_protocol_version
  lighting_instance_ids = module.servers[*].lighting_instance_id
  heating_instance_ids = module.servers[*].heating_instance_id
  status_instance_ids = module.servers[*].status_instance_id
  auth_instance_ids = module.servers[*].auth_instance_id
  load_balancer_type = var.load_balancer_type
  public_security_groups = module.security.public_security_groups
  public_subnets = module.networking.public_subnets
  private_security_groups = module.security.private_security_groups
  private_subnets = module.networking.private_subnets
  action_type = var.action_type
  path_conditions = var.path_conditions
  health_checks = var.health_checks
}

module "autoscaling" {
  source = "./modules/autoscaling"
  count = var.number_of_AZs

  amis = var.amis
  instance_type = var.instance_type
  public_security_groups = module.security.public_security_groups
  private_security_groups = module.security.private_security_groups
  public_subnet = module.networking.public_subnets[count.index]
  private_subnet = module.networking.private_subnets[count.index]
  vpc_subnets = module.networking.public_subnets
  max_size = var.max_size
  min_size = var.min_size
  desired_capacity = var.desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type = var.health_check_type
  target_group_arns = {
    lighting = module.load-balancers.lighting_target_arn,
    heating = module.load-balancers.heating_target_arn,
    status = module.load-balancers.status_target_arn,
    auth = module.load-balancers.auth_target_arn
  }
}