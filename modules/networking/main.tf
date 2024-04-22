#####
### VPC
#####

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  tags = {
    Name = var.vpc_name
  }
}

#####
### Internet Gateway 
#####

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.igw_name
  }
}

######
### Subnet definitions
######

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets)

  vpc_id = aws_vpc.main_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block = var.public_subnets[count.index]
  
  tags = {
    Name = "${var.public_subnet_name}-${count.index+1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = var.azs[count.index]
  cidr_block        = var.private_subnets[count.index]

  tags = {
    Name = "${var.private_subnet_name}-${count.index+1}"
  }
}

######
## Public Routes
######

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = var.public_route_table_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}

######
## Private Routes
######

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "private_routes" {
  count          = length(aws_subnet.private_subnets)
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_subnets[count.index].id
}

######
## NAT
######

resource "aws_eip" "eip" {
  domain   = var.eip_domain
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.allocation_id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = var.nat_name
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route" "public_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = var.nat_destination_cidr_block
  gateway_id             = aws_nat_gateway.nat.id
}