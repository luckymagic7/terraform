# Private_Route_table
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

resource "aws_route_table_association" "priv_a" {
  subnet_id      = "${aws_subnet.priv_a.id}"
  route_table_id = "${aws_route_table.priv_a.id}"
}

resource "aws_route_table_association" "priv_c" {
  subnet_id      = "${aws_subnet.priv_c.id}"
  route_table_id = "${aws_route_table.priv_c.id}"
}

# Public_Route_table
resource "aws_route_table" "pub_a" {
  vpc_id = "${aws_vpc.task.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.task_igw.id}"
  }
  tags = {
    Name = "pub_a"
  }
}

resource "aws_route_table" "pub_c" {
  vpc_id = "${aws_vpc.task.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.task_igw.id}"
  }
  tags = {
    Name = "pub_c"
  }
}

resource "aws_route_table_association" "pub_a" {
  subnet_id      = "${aws_subnet.pub_a.id}"
  route_table_id = "${aws_route_table.pub_a.id}"
}

resource "aws_route_table_association" "pub_c" {
  subnet_id      = "${aws_subnet.pub_c.id}"
  route_table_id = "${aws_route_table.pub_c.id}"
}
