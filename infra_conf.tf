# VPC
resource "aws_vpc" "task" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "task"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.task.id}"

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg_for_VPC"
  }
}

# IGW
resource "aws_internet_gateway" "task_igw" {
  vpc_id = "${aws_vpc.task.id}"

  tags = {
    Name = "task_igw"
  }
}

# Subnet
resource "aws_subnet" "pub_a" {
  vpc_id     = "${aws_vpc.task.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub_a"
  }
}

resource "aws_subnet" "pub_c" {
  vpc_id     = "${aws_vpc.task.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub_c"
  }
}

resource "aws_subnet" "priv_a" {
  vpc_id     = "${aws_vpc.task.id}"
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "priv_a"
  }
}

resource "aws_subnet" "priv_c" {
  vpc_id     = "${aws_vpc.task.id}"
  cidr_block = "10.0.11.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "priv_c"
  }
}

# EIP & NAT
resource "aws_eip" "a" {
  vpc      = true
  tags = {
    Name = "eip_for_a_nat"
  }
}

resource "aws_nat_gateway" "a" {
  allocation_id = "${aws_eip.a.id}"
  subnet_id     = "${aws_subnet.pub_a.id}"

  tags = {
    Name = "a"
  }
}

resource "aws_eip" "c" {
  vpc      = true
  tags = {
    Name = "eip_for_c_nat"
  }
}

resource "aws_nat_gateway" "c" {
  allocation_id = "${aws_eip.c.id}"
  subnet_id     = "${aws_subnet.pub_c.id}"

  tags = {
    Name = "c"
  }
}

# Default_Route_table
resource "aws_default_route_table" "default" {
  default_route_table_id = "${aws_vpc.task.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.task_igw.id}"
  }

  tags = {
    Name = "default"
  }
}


# Custom_Route_table
resource "aws_route_table" "priv_a" {
  vpc_id = "${aws_vpc.task.id}"

  tags = {
    Name = "priv_a"
  }
}

resource "aws_route_table" "priv_c" {
  vpc_id = "${aws_vpc.task.id}"

  tags = {
    Name = "priv_c"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.priv_a.id}"
  route_table_id = "${aws_route_table.priv_a.id}"
}

resource "aws_route_table_association" "c" {
  subnet_id      = "${aws_subnet.priv_c.id}"
  route_table_id = "${aws_route_table.priv_c.id}"
}

# Attach route_table to NAT
resource "aws_route" "a" {
  route_table_id            = "${aws_route_table.priv_a.id}"
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.a.id}"
}

resource "aws_route" "c" {
  route_table_id            = "${aws_route_table.priv_c.id}"
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.c.id}"
}
