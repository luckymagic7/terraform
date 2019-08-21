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
