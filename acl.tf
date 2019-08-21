resource "aws_network_acl" "priv_a" {
  vpc_id = "${aws_vpc.task.id}"
  subnet_ids = [
    "${aws_subnet.priv_a.id}"
  ]

  ingress {
    protocol   = "tcp"
    rule_no    = 90
    action     = "allow"
    cidr_block = "${aws_instance.bastion.private_ip}/32"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 91
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "priv_a"
  }
}

resource "aws_network_acl" "priv_c" {
  vpc_id = "${aws_vpc.task.id}"
  subnet_ids = [
    "${aws_subnet.priv_c.id}"
  ]

  ingress {
    protocol   = "tcp"
    rule_no    = 90
    action     = "allow"
    cidr_block = "${aws_instance.bastion.private_ip}/32"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 91
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "priv_c"
  }
}

resource "aws_network_acl" "pub_a" {
  vpc_id = "${aws_vpc.task.id}"
  subnet_ids = [
    "${aws_subnet.pub_a.id}"
  ]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "pub_a"
  }
}

resource "aws_network_acl" "pub_c" {
  vpc_id = "${aws_vpc.task.id}"
  subnet_ids = [
    "${aws_subnet.pub_c.id}"
  ]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "pub_c"
  }
}
