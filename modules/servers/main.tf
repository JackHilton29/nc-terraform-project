resource "aws_instance" "lighting" {
  ami = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  key_name = var.key_name
  vpc_security_group_ids = var.public_security_groups
  subnet_id = var.public_subnet

  tags = {
    Name = "lighting-${var.number_of_instance}"
  }
}

resource "aws_instance" "heating" {
  ami = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  key_name = var.key_name
  vpc_security_group_ids = var.public_security_groups
  subnet_id = var.public_subnet

  tags = {
    Name = "heating-${var.number_of_instance}"
  }
}

resource "aws_instance" "status" {
  ami = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  key_name = var.key_name
  vpc_security_group_ids = var.public_security_groups
  subnet_id = var.public_subnet

  tags = {
    Name = "status-${var.number_of_instance}"
  }
}

resource "aws_instance" "auth" {
  ami = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = false
  key_name = var.key_name
  vpc_security_group_ids = var.private_security_groups
  subnet_id = var.private_subnet

  tags = {
    Name = "auth-${var.number_of_instance}"
  }
}