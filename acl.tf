resource "aws_default_network_acl" "default" {
  default_network_acl_id = "${aws_vpc.task.default_network_acl_id}"
  subnet_ids = [
    "${aws_subnet.pub_a.id}",
    "${aws_subnet.priv_a.id}",
    "${aws_subnet.pub_c.id}",
    "${aws_subnet.priv_c.id}"
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
    Name = "default_ACL"
  }
}
