resource "aws_security_group" "sg_for_private" {
  name = "sg_for_private"
  description = "security group for private instances"
  vpc_id      = "${aws_vpc.task.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.bastion_ssh.id}"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.allow_80_port.id}"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
  tags = {
    Name = "sg_for_private"
  }
}

resource "aws_instance" "priv_a" {
  ami = "ami-095ca789e0549777d"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.web_admin.key_name}"
  subnet_id = "${aws_subnet.priv_a.id}"
  vpc_security_group_ids = [
    "${aws_security_group.sg_for_private.id}"
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    iops = 100
  }
  volume_tags = {
    Name = "a"
  }
  tags = {
    Name = "priv_a"
  }
}

resource "aws_instance" "priv_c" {
  ami = "ami-095ca789e0549777d"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.web_admin.key_name}"
  subnet_id = "${aws_subnet.priv_c.id}"
  vpc_security_group_ids = [
    "${aws_security_group.sg_for_private.id}"
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    iops = 100
  }
  volume_tags = {
    Name = "c"
  }
  tags = {
    Name = "priv_c"
  }
}
